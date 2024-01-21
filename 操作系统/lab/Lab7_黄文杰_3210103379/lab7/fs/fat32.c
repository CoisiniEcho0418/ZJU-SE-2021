#include <fat32.h>
#include <printk.h>
#include <virtio.h>
#include <string.h>
#include <mbr.h>
#include <mm.h>

struct fat32_bpb fat32_header;

struct fat32_volume fat32_volume;

uint8_t fat32_buf[VIRTIO_BLK_SECTOR_SIZE];
uint8_t fat32_table_buf[VIRTIO_BLK_SECTOR_SIZE];

uint64_t cluster_to_sector(uint64_t cluster) {
    return (cluster - 2) * fat32_volume.sec_per_cluster + fat32_volume.first_data_sec;
}

uint32_t next_cluster(uint64_t cluster) {
    uint64_t fat_offset = cluster * 4;
    uint64_t fat_sector = fat32_volume.first_fat_sec + fat_offset / VIRTIO_BLK_SECTOR_SIZE;
    virtio_blk_read_sector(fat_sector, fat32_table_buf);
    int index_in_sector = fat_offset % (VIRTIO_BLK_SECTOR_SIZE / sizeof(uint32_t));
    return *(uint32_t*)(fat32_table_buf + index_in_sector);
}

void fat32_init(uint64_t lba, uint64_t size) {
    virtio_blk_read_sector(lba, (void*)&fat32_header);
    fat32_volume.first_fat_sec = lba + fat32_header.rsvd_sec_cnt;
    fat32_volume.sec_per_cluster = fat32_header.sec_per_clus;
    fat32_volume.first_data_sec = fat32_volume.first_fat_sec + fat32_header.num_fats * fat32_header.fat_sz16;
    fat32_volume.fat_sz = fat32_header.fat_sz16;

    virtio_blk_read_sector(fat32_volume.first_data_sec, fat32_buf); // Get the root directory
    struct fat32_dir_entry *dir_entry = (struct fat32_dir_entry *)fat32_buf;
}

int is_fat32(uint64_t lba) {
    virtio_blk_read_sector(lba, (void*)&fat32_header);
    if (fat32_header.boot_sector_signature != 0xaa55) {
        return 0;
    }
    return 1;
}

int next_slash(const char* path) {
    int i = 0;
    while (path[i] != '\0' && path[i] != '/') {
        i++;
    }
    if (path[i] == '\0') {
        return -1;
    }
    return i;
}

void to_upper_case(char *str) {
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] >= 'a' && str[i] <= 'z') {
            str[i] -= 32;
        }
    }
}

struct fat32_file fat32_open_file(const char *path) {
    struct fat32_file file;
    /* todo: open the file according to path */
    to_upper_case(path);
    uint32_t cluster = 0;
    uint32_t sector = fat32_volume.first_data_sec;
    uint32_t dir_index = 0;
    while (1) {
        virtio_blk_read_sector(sector, fat32_buf);
        struct fat32_dir_entry *dir_entry = (struct fat32_dir_entry *)fat32_buf;
        for (int i = 0; i < FAT32_ENTRY_PER_SECTOR; i++) {
            if (memcmp(path, dir_entry[i].name, 11) == 0) {
                file.dir.cluster = cluster;
                file.dir.index = dir_index;
                file.cluster = dir_entry[i].starthi << 16 | dir_entry[i].startlow;
                return file;
            }
            dir_index++;
        }
        cluster = next_cluster(cluster);
        if (cluster >= 0x0ffffff8) {
            return file;
        }
        sector = cluster_to_sector(cluster);
    }
    return file;
}

int64_t fat32_lseek(struct file* file, int64_t offset, uint64_t whence) {
    if (whence == SEEK_SET) {
        file->cfo = offset;
    } else if (whence == SEEK_CUR) {
        file->cfo = file->cfo + offset;
    } else if (whence == SEEK_END) {
        /* Calculate file length */
        file->cfo = file->fat32_file.dir.index * sizeof(struct fat32_dir_entry) + file->fat32_file.dir.cluster * fat32_volume.sec_per_cluster * VIRTIO_BLK_SECTOR_SIZE + file->fat32_file.cluster * fat32_volume.sec_per_cluster * VIRTIO_BLK_SECTOR_SIZE;
    } else {
        printk("fat32_lseek: whence not implemented\n");
        while (1);
    }
    return file->cfo;
}

uint64_t fat32_table_sector_of_cluster(uint32_t cluster) {
    return fat32_volume.first_fat_sec + cluster / (VIRTIO_BLK_SECTOR_SIZE / sizeof(uint32_t));
}

int64_t fat32_extend_filesz(struct file* file, uint64_t new_size) {
    uint64_t sector = cluster_to_sector(file->fat32_file.dir.cluster) + file->fat32_file.dir.index / FAT32_ENTRY_PER_SECTOR;

    virtio_blk_read_sector(sector, fat32_table_buf);
    uint32_t index = file->fat32_file.dir.index % FAT32_ENTRY_PER_SECTOR;
    uint32_t original_file_len = ((struct fat32_dir_entry *)fat32_table_buf)[index].size;
    ((struct fat32_dir_entry *)fat32_table_buf)[index].size = new_size;

    virtio_blk_write_sector(sector, fat32_table_buf);

    uint32_t clusters_required = new_size / (fat32_volume.sec_per_cluster * VIRTIO_BLK_SECTOR_SIZE);
    uint32_t clusters_original = original_file_len / (fat32_volume.sec_per_cluster * VIRTIO_BLK_SECTOR_SIZE);
    uint32_t new_clusters = clusters_required - clusters_original;

    uint32_t cluster = file->fat32_file.cluster;
    while (1) {
        uint32_t next_cluster_number = next_cluster(cluster);
        if (next_cluster_number >= 0x0ffffff8) {
            break;
        }
        cluster = next_cluster_number;
    }

    for (int i = 0; i < new_clusters; i++) {
        uint32_t cluster_to_append;
        for (int j = 2; j < fat32_volume.fat_sz * VIRTIO_BLK_SECTOR_SIZE / sizeof(uint32_t); j++) {
            if (next_cluster(j) == 0) {
                cluster_to_append = j;
                break;
            }
        }
        uint64_t fat_sector = fat32_table_sector_of_cluster(cluster);
        virtio_blk_read_sector(fat_sector, fat32_table_buf);
        uint32_t index_in_sector = cluster * 4 % VIRTIO_BLK_SECTOR_SIZE;
        *(uint32_t*)(fat32_table_buf + index_in_sector) = cluster_to_append;
        virtio_blk_write_sector(fat_sector, fat32_table_buf);
        cluster = cluster_to_append;
    }

    uint64_t fat_sector = fat32_table_sector_of_cluster(cluster);
    virtio_blk_read_sector(fat_sector, fat32_table_buf);
    uint32_t index_in_sector = cluster * 4 % VIRTIO_BLK_SECTOR_SIZE;
    *(uint32_t*)(fat32_table_buf + index_in_sector) = 0x0fffffff;
    virtio_blk_write_sector(fat_sector, fat32_table_buf);

    return 0;
}

int64_t fat32_read(struct file* file, void* buf, uint64_t len) {
    uint64_t sector = cluster_to_sector(file->fat32_file.cluster) + file->fat32_file.dir.index / FAT32_ENTRY_PER_SECTOR;
    virtio_blk_read_sector(sector, fat32_table_buf);
    uint32_t index = file->fat32_file.dir.index % FAT32_ENTRY_PER_SECTOR;
    uint32_t file_len = ((struct fat32_dir_entry *)fat32_table_buf)[index].size;
    if (file->cfo + len > file_len) {
        len = file_len - file->cfo;
    }
    uint64_t start_sector = cluster_to_sector(file->fat32_file.cluster) + file->cfo / VIRTIO_BLK_SECTOR_SIZE;
    uint64_t end_sector = cluster_to_sector(file->fat32_file.cluster) + (file->cfo + len) / VIRTIO_BLK_SECTOR_SIZE;
    uint64_t start_offset = file->cfo % VIRTIO_BLK_SECTOR_SIZE;
    uint64_t end_offset = (file->cfo + len) % VIRTIO_BLK_SECTOR_SIZE;
    uint64_t read_len = 0;
    for (uint64_t i = start_sector; i <= end_sector; i++) {
        virtio_blk_read_sector(i, fat32_buf);
        if (i == start_sector && i == end_sector) {
            memcpy(buf, fat32_buf + start_offset, len);
            read_len += len;
        } else if (i == start_sector) {
            memcpy(buf, fat32_buf + start_offset, VIRTIO_BLK_SECTOR_SIZE - start_offset);
            read_len += VIRTIO_BLK_SECTOR_SIZE - start_offset;
        } else if (i == end_sector) {
            memcpy(buf + read_len, fat32_buf, end_offset);
            read_len += end_offset;
        } else {
            memcpy(buf + read_len, fat32_buf, VIRTIO_BLK_SECTOR_SIZE);
            read_len += VIRTIO_BLK_SECTOR_SIZE;
        }
    }
    file->cfo += read_len;
    return read_len;
    /* todo: read content to buf, and return read length */
}

int64_t fat32_write(struct file* file, const void* buf, uint64_t len) {
    return 0;
    /* todo: fat32_write */
}