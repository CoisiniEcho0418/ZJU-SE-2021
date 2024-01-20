#include<stdio.h>
#include<stdlib.h>

#define INF 10000 // Define a macro to represent infinity.
#define MAXNUM 1005 // Define the maximum value for the number of vertices

// two-dimensional edge weight table (INF representing no adjacent edge).
int edge[MAXNUM][MAXNUM];

// Check whether a given sequence is a Dijkstra sequence and return the result.
// Algorithm1:
int check_dijkstra1(int v_num); // 1:Yes 0:No
// Algorithm2:
int check_dijkstra2(int v_num); // 1:Yes 0:No

int main(void){
	// Initialize the two-dimensional edge weight table.
	for(int i=0;i<MAXNUM;i++){
		for(int j=0;j<MAXNUM;j++){
			if(i==j){
				edge[i][j]=0;
			}else{
				edge[i][j]=INF;
			}	
		}
	}
	
	int v_num,e_num; // the total numbers of vertices(v_num) and edges(e_num)
	scanf("%d%d",&v_num,&e_num);
	// Read in information about weighted edges and 
	// update the two-dimensional edge weight table.
	for(int i=0;i<e_num;i++){
		int x,y,weight;
		scanf("%d%d%d",&x,&y,&weight);
		edge[x][y]=edge[y][x]=weight;
	}
	
	// the number of queries
	int k;
	scanf("%d",&k);
	for(int i=0;i<k;i++){
		
		// use algorithm1
		int flag = check_dijkstra1(v_num);
		// use algorithm2
		//int flag = check_dijkstra2(v_num);
		
		if(flag){
			printf("Yes\n");
		}else{
			printf("No\n");
		}
	}
	
}

int check_dijkstra1(int v_num) {
    int seq[v_num]; // The sequence of vertices
    int dist[v_num + 1]; // The minimum distance from the source to each vertex
    int visited[v_num + 1]; // Used to mark whether each vertex has been visited (0:NO 1:YES)

    // Read the input sequence of vertices
    for (int i = 0; i < v_num; i++) {
        scanf("%d", &seq[i]);
    }

    // Initialize the dist array and visited array
    for (int i = 0; i < v_num + 1; i++) {
        dist[i] = INF;
        visited[i] = 0;
    }

    dist[seq[0]] = 0;

    // Loop through the vertices in the input sequence
    for (int i = 0; i < v_num; i++) {
        int next_v = seq[i]; // The index of the smallest unknown distance vertex
        int min_dist = dist[seq[i]];

        // Check if there is any vertex with a smaller distance that has not been visited
        for (int j = 1; j <= v_num; j++) {
            if (!visited[j] && dist[j] < min_dist) {
                return 0; // Not a Dijkstra sequence if a smaller distance is found
            }
        }

        visited[next_v] = 1; // Mark the current vertex as visited

        // Update the distances of adjacent vertices
        for (int j = 1; j <= v_num; j++) {
            if (!visited[j] && edge[next_v][j] != INF) {
                if (edge[next_v][j] + dist[next_v] < dist[j]) {
                    dist[j] = edge[next_v][j] + dist[next_v];
                }
            }
        }
    }

    return 1; // It's a Dijkstra sequence
}


int check_dijkstra2(int v_num) {
    int seq[v_num];     // The sequence of vertices
    int dist[v_num + 1]; // The minimum distance from the source to each vertex

    // Read the input sequence of vertices
    for (int i = 0; i < v_num; i++) {
        scanf("%d", &seq[i]);
    }

    // Initialize the dist array with infinity for all vertices except the source
    for (int i = 0; i < v_num + 1; i++) {
        dist[i] = INF;
    }

    dist[seq[0]] = 0; // Set the distance of the source vertex to 0

    // Loop through the vertices in the input sequence
    for (int i = 0; i < v_num; i++) {
        int u = seq[i]; // Current vertex

        // Update distances to adjacent vertices
        for (int j = 1; j <= v_num; j++) {
            if (edge[u][j] != INF) { // If there is an edge between u and v
                if (dist[u] + edge[u][j] < dist[j]) {
                	// Update the distance if a shorter path is found
                    dist[j] = dist[u] + edge[u][j]; 
                }
            }
        }
    }

    // Check if the resulting distances are non-decreasing
    for (int i = 1; i < v_num; i++) {
        if (dist[seq[i]] < dist[seq[i - 1]]) {
        	// Not a Dijkstra sequence if a smaller distance is found later in the sequence
            return 0; 
        }
    }

    return 1; // It's a Dijkstra sequence
}




