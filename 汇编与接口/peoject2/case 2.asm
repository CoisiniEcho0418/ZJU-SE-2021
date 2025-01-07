.code 
start:
 in al, 125 ; read temperature
 
 cmp al, 15
 jb low
 
 cmp al, 25
 ja high
 
 jmp start
 
low:
 mov al, 1
 out 127, al ; turn on heater
 jmp start
 
high:
 mov al, 0
 out 127, al ; turn off heater
 jmp start
 
 hlt
 
.exit