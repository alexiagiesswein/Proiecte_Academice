.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc
extern rand: proc
extern printf: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "Minion rush",0
area_width EQU 480
area_height EQU 640
area DD 0

counter DD 0 ; numara evenimentele de tip timer
counter2 DD 0 ;numara scorul

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20

x   DD 0       ;coordonatele minionului
y DD 128
x_old DD 220   ;coordonatele vechi ale minionului
y_old DD 580
sta DD 0       ;un contor pentru a desena minionul in mijloc doar o data (la inceput)

a DD 315       ;coordonatele obstacolelor (pe fiecare rand este un obstacol)
a2 DD 448
a3 DD 183
a4 DD 156
a5 DD 544
a_old DD 0    ;coordonatele vechi ale obstacolelor
a2_old DD 0
a3_old DD 0
a4_old DD 0
a5_old DD 0


b DD 490    ;coordonatele bananelor (pe unele randuri sunt si cate 2 banane)
c1 DD 189
b2 DD 260
c2 DD 50
b3 DD 446
c3 DD 30
c4 DD 50
b4 DD 413
b5 DD 234    ;coordonatele vechi ale bananelor
b_old DD 0
c1_old DD 0
b2_old DD 0
c2_old DD 0
b3_old DD 0
c3_old DD 0
c4_old DD 0
b4_old DD 0
b5_old DD 0

const DD 10   ;un contor pentru a vedea cat de repede se misca obiectele (daca trece mai mult timp, viteza va creste)
timp DD 50     ;un contor pentru a vedea cat timp o trecut
text DB "GAME OVER",0   ; se afiseaza daca dam de un obstacol

symbol_width EQU 10
symbol_height EQU 20
symbol_width1 EQU 40
symbol_height1 EQU 50

include digits.inc
include letters.inc
include mini.inc
include blocaj.inc
include banane.inc
.code
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y
make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_verde
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_verde:
	mov dword ptr [edi], 0ADFF2Fh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp


make_mini proc           ;macroul pentru desenarea minionului
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, 0 ; citim simbolul de afisat
	lea esi, mini
	jmp draw_text
	
draw_text:
	mov ebx, symbol_width1
	mul ebx
	mov ebx, symbol_height1
	mul ebx
	add esi, eax
	mov ecx, symbol_height1
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height1
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width1
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_verde
	mov dword ptr [edi], 0000CDh  ;minionul va fi albastru
	jmp simbol_pixel_next
simbol_pixel_verde:
	mov dword ptr [edi], 0ADFF2Fh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_mini endp

make_mini2 proc    ;macroul pentru a face minionul verde (practic inlocuieste unde o fost minionul cu pixeli verzi, il sterge)
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, 0 ; citim simbolul de afisat
	lea esi, mini
	jmp draw_text
	
draw_text:
	mov ebx, symbol_width1
	mul ebx
	mov ebx, symbol_height1
	mul ebx
	add esi, eax
	mov ecx, symbol_height1
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height1
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width1
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_verde
	mov dword ptr [edi], 0ADFF2Fh
	jmp simbol_pixel_next
simbol_pixel_verde:
	mov dword ptr [edi], 0ADFF2Fh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_mini2 endp


make_blocaj proc                   ;macroul care deseneaza blocajul
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, 0 ; citim simbolul de afisat
	lea esi, blocaj
	jmp draw_text
	
draw_text:
	mov ebx, symbol_width1
	mul ebx
	mov ebx, symbol_height1
	mul ebx
	add esi, eax
	mov ecx, symbol_height1
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height1
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width1
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_verde
	mov dword ptr [edi], 800000h   ;blocajul va fi maro
	jmp simbol_pixel_next
simbol_pixel_verde:
	mov dword ptr [edi], 0ADFF2Fh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_blocaj endp

make_blocaj2 proc      ;macroul pentru a desena blocajul verde (pune pixeli verzi unde era blocajul, sterge blocajul)
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, 0 ; citim simbolul de afisat
	lea esi, blocaj
	jmp draw_text
	
draw_text:
	mov ebx, symbol_width1
	mul ebx
	mov ebx, symbol_height1
	mul ebx
	add esi, eax
	mov ecx, symbol_height1
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height1
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width1
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_verde
	mov dword ptr [edi], 0ADFF2Fh
	jmp simbol_pixel_next
simbol_pixel_verde:
	mov dword ptr [edi], 0ADFF2Fh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_blocaj2 endp



make_banane proc       ;macroul care deseneaza bananele
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, 0 ; citim simbolul de afisat
	lea esi, banane
	jmp draw_text
	
draw_text:
	mov ebx, symbol_width1
	mul ebx
	mov ebx, symbol_height1
	mul ebx
	add esi, eax
	mov ecx, symbol_height1
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height1
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width1
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_verde
	mov dword ptr [edi], 0FFD700h  ;bananele sunt galbene
	jmp simbol_pixel_next
simbol_pixel_verde:
	mov dword ptr [edi], 0ADFF2Fh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_banane endp

make_banane2 proc      ;macroul care deseneaza bananele verzi (pune pixeli verzi in locul unde a fost banana, sterge banana)
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, 0 ; citim simbolul de afisat
	lea esi, banane
	jmp draw_text
	
draw_text:
	mov ebx, symbol_width1
	mul ebx
	mov ebx, symbol_height1
	mul ebx
	add esi, eax
	mov ecx, symbol_height1
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height1
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width1
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_verde
	mov dword ptr [edi], 0ADFF2Fh
	jmp simbol_pixel_next
simbol_pixel_verde:
	mov dword ptr [edi], 0ADFF2Fh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_banane2 endp

;macrouri ca sa apelam mai usor desenarea simbolurilor
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm

make_mini_macro macro symbol, drawArea, x, y ;pentru a desena minionul
	push y
	push x
	push drawArea
	push symbol
	call make_mini
	add esp, 16
endm

make_mini2_macro macro symbol, drawArea, x, y ;pentru a sterge minionul
	push y
	push x
	push drawArea
	push symbol
	call make_mini2
	add esp, 16
endm

make_blocaj_macro macro symbol, drawArea, x, y  ;pentru a desena blocajul
	push y
	push x
	push drawArea
	push symbol
	call make_blocaj
	add esp, 16
endm

make_blocaj2_macro macro symbol, drawArea, x, y    ;pentru a sterge blocajul
	push y
	push x
	push drawArea
	push symbol
	call make_blocaj2
	add esp, 16
endm

make_banane_macro macro symbol, drawArea, x, y    ;pentru a desena banana
	push y
	push x
	push drawArea
	push symbol
	call make_banane
	add esp, 16
endm

make_banane2_macro macro symbol, drawArea, x, y   ;pentru a sterge banana
	push y
	push x
	push drawArea
	push symbol
	call make_banane2
	add esp, 16
endm


line_vertical macro x, y, len, color    ;deseneaza linii verticale pentru a despartii coloanele (5 linii vor fi)
local bucla_line
mov eax,y
mov ebx,area_width
mul ebx
add eax,x
shl eax,2
add eax,area
mov ecx,len
bucla_line:
mov dword ptr[eax],color
add eax, area_width*4
loop bucla_line
endm





; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click)
; arg2 - x
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	
	
	mov esi,0   ;dupa ce a fost initializata cu pixeli albi, facem toata fereastra verde (practic o reinitializam cu pixeli verzi)
	mov ecx,480
	mov edi,480
	bucla:
	line_vertical  esi, 0, 640, 0ADFF2Fh   ;deseneaza linii verticale verzi pe toata fereastra (toata fereastra va fi verde)
	inc esi
	dec edi
	mov ecx,edi
	loop bucla
	
	jmp afisare_litere
	
evt_click:
  
  mov ebx,580               ;verificam daca s-a dat click mai jos de coordonata y=580 (pentru a evita iesirea din fereastra)
  cmp [ebp+arg3],ebx
  jg mmm
  
  make_mini_macro 'M', area, [ebp+arg2], [ebp+arg3]   ;daca nu s-a dat click mai jos de y=580, desenam minionul in locul in care s-a dat click
  make_mini2_macro 'M', area, x_old, y_old            ;stergem minionul din fosta locatie
  mov eax,[ebp+arg2]                                  ;retinem coordonatele pentru a stii fosta locatie
  mov x_old, eax
  mov eax,[ebp+arg3]
  mov y_old, eax

   jmp afisare_litere
	
  mmm: 
  make_mini_macro 'M', area, [ebp+arg2], 580          ;daca s-a dat click mai jos de y=580, desenam minionul de la y=580
  make_mini2_macro 'M', area, x_old, y_old            ;stergem minionul din fosta locatie
  mov eax,[ebp+arg2]                                  ;retinem coordonatele
  mov x_old, eax
  mov eax,580
  mov y_old, eax
	
   jmp afisare_litere
	
evt_timer:
	inc counter
	
	 make_blocaj2_macro 'B', area, 42, a_old     ;stergem blocajele din fosta locatie (initial fosta locatie e 0, dupa se tot retin coordonatele)
	 make_blocaj2_macro 'B', area, 10, a_old     ;fiecare blocaj este alcatuit din 2 desene
	
  	
	 make_blocaj2_macro 'B', area, 238, a2_old
	 make_blocaj2_macro 'B', area, 206, a2_old
	
    	
	 make_blocaj2_macro 'B', area, 141, a3_old
	 make_blocaj2_macro 'B', area, 109, a3_old
	 
	 
	 make_blocaj2_macro 'B', area, 335, a4_old
	 make_blocaj2_macro 'B', area, 302, a4_old
	 
	
	 make_blocaj2_macro 'B', area, 426, a5_old
	 make_blocaj2_macro 'B', area, 394, a5_old
	 
	 make_banane2_macro 'A', area, 25, b_old     ;stergem bananele din fosta locatie (initial fosta locatie e 0, dupa se tot retin coordonatele)
	 make_banane2_macro 'A', area, 225, b2_old
	 make_banane2_macro 'A', area, 125, b3_old
	 make_banane2_macro 'A', area, 320, b4_old
	 make_banane2_macro 'A', area, 415, b5_old
	
	 make_banane2_macro 'A', area, 225, c2_old
	 make_banane2_macro 'A', area, 125, c3_old
	 make_banane2_macro 'A', area, 320, c4_old
	 make_banane2_macro 'A', area, 25, c1_old
	
	 make_blocaj_macro 'B', area, 42, a         ;BLOCAJUL1 --la fiecare blocaj se intampla acelasi lucru
	 make_blocaj_macro 'B', area, 10, a         ;se deseneaza blocajul
	 mov eax,a
	 mov a_old,eax
	 add eax,const                            ; urmatorul blocaj va fi desenat la distanta const (const=10 initial), const arata cat de repede se deplaseaza blocajul
     mov a,eax                                ;vechiul blocaj va fi sters chiar la inceput
	 cmp eax,590                              ; se verifica daca y<=590
     jle next
     
	
	make_blocaj2_macro 'B', area, 42, a_old   ;daca y>590 se sterge blocajul si se schimba coordonata a=0 (pentru ca urmatoru blocaj sa vina de sus)
    make_blocaj2_macro 'B', area, 10, a_old   ;daca era y<=590 se continua programul
	mov a,0
	
	next:
	 mov eax,a
	 mov ebx, y_old                          ;se compara coordonatele minionului cu cele ale blocajului si daca sunt apropiate
	 sub ebx, eax                            ;=> minionul s-a lovit de blocaj =>se termina programul si scrie GAME OVER
	 cmp ebx, 30
	 jg g1
	 mov eax,96
	 cmp x_old, eax
	 jle g
	
	g1:                                       ;altfel programul se continua
	 make_blocaj_macro 'B', area, 238, a2     ;BLOCAJUL2  --ca si la BLOCAJUL1
	 make_blocaj_macro 'B', area, 206, a2
	 mov eax,a2
	 mov a2_old,eax
	 add eax,const
     mov a2,eax
	 cmp eax,590
     jle next2
	
	make_blocaj2_macro 'B', area, 238, a2_old
    make_blocaj2_macro 'B', area, 206, a2_old
	mov a2,0
	
	next2:
	 mov eax,a2
	 mov ebx, y_old
	 sub ebx, eax
	 cmp ebx, 30
	 jg g2
	 mov eax,192
	 cmp x_old, eax
	 jle g2
	 mov eax,288
	 cmp x_old, eax
	 jle g
	
	g2:
	 make_blocaj_macro 'B', area, 141, a3      ;BLOCAJUL3  --ca si la BLOCAJUL1
	 make_blocaj_macro 'B', area, 109, a3
	 mov eax,a3
	 mov a3_old,eax
	 add eax,const
     mov a3,eax
	 cmp eax,590
     jle next3
	
	make_blocaj2_macro 'B', area, 141, a3_old
    make_blocaj2_macro 'B', area, 109, a3_old
	mov a3,0
	
	next3:
	 mov eax,a3
	 mov ebx, y_old
	 sub ebx, eax
	 cmp ebx, 30
	 jg g3
	 mov eax,96
	 cmp x_old, eax
	 jle g3
	 mov eax,192
	 cmp x_old, eax
	 jle g
	
	g3:
	 make_blocaj_macro 'B', area, 335, a4          ;BLOCAJUL4  --ca si la BLOCAJUL1
	 make_blocaj_macro 'B', area, 302, a4
	 mov eax,a4
	 mov a4_old,eax
	 add eax,const
     mov a4,eax
	 cmp eax,590
     jle next4
	 
	
	make_blocaj2_macro 'B', area, 335, a4_old
    make_blocaj2_macro 'B', area, 302, a4_old
	mov a4,0
	
	next4:
	 mov eax,a4
	 mov ebx, y_old
	 sub ebx, eax
	 cmp ebx, 30
	 jg g4
	 mov eax,288
	 cmp x_old, eax
	 jle g4
	 mov eax,384
	 cmp x_old, eax
	 jle g
	
	g4:
	 make_blocaj_macro 'B', area, 426, a5         ;BLOCAJUL5  --ca si la BLOCAJUL1
	 make_blocaj_macro 'B', area, 394, a5
	 mov eax,a5
	 mov a5_old,eax
	 add eax,const
     mov a5,eax
	 cmp eax,590
     jle next5
	 
	 
	make_blocaj2_macro 'B', area, 426, a5_old
    make_blocaj2_macro 'B', area, 394, a5_old
	mov a5,0
	 
	next5:
	 mov eax,a5
	 mov ebx, y_old
	 sub ebx, eax
	 cmp ebx, 30
	 jg g5
	 mov eax,384
	 cmp x_old, eax
	 jg g
	
	g5:
	 make_banane_macro 'A', area, 25,b        ;BANANA1   --la fel se intampla si la celelalte banane
	 mov eax,b                                ; se desenaza banana 
	 mov b_old,eax                            
	 add eax,const                            ; apoi se va redesena la distanta const care arata viteza de deplasare --fosta banana se va sterge la inceput
     mov b,eax
	 cmp eax,590                              ;se compara coordonata y cu 590
     jle next6	
   
	make_banane2_macro 'A', area, 25, b_old    ;daca y>590 se sterge banana si b se face 0--pentru a incepe desenarea ei de la inceput
	mov b,0                                    ;daca y era <=590 programul se continua normal
	
	next6:
	
	mov eax,b                              ;se compara coordonate bananei cu cele ale minionului
	mov ebx, y_old                         ;daca sunt pe aproape, banana se sterge si se deseneaza de la inceput, iar la scor se adauga 1
	sub ebx, eax
	cmp ebx, 50
	jg punct1
	mov eax,96
	cmp x_old, eax
	jg punct1
	inc counter2
	mov b,0
	
	
	punct1:
	make_banane_macro 'A', area, 225, b2       ;BANANA2 --la fel ca si la BANANA1
	 mov eax,b2
	 mov b2_old,eax
	 add eax, const
     mov b2,eax
	 cmp eax,590
     jle next7
    
	
	make_banane2_macro 'A', area, 225, b2_old
	mov b2,0
	 
	next7:
	mov eax,b2
	mov ebx, y_old
	sub ebx, eax
	cmp ebx, 50
	jg punct2
	mov eax,288
	cmp x_old, eax
	jg punct2
	mov eax,192
	cmp x_old, eax
	jl punct2
	inc counter2
	mov b2,0
	
	punct2:
	make_banane_macro 'A', area, 125, b3           ;BANANA3 --la fel ca si la BANANA1
	 mov eax,b3
	 mov b3_old,eax
	 add eax, const
     mov b3,eax
	 cmp eax,590
     jle next8
    
	
	make_banane2_macro 'A', area, 125, b3_old
	mov b3,0
	
	next8:
	mov eax,b3
	mov ebx, y_old
	sub ebx, eax
	cmp ebx, 50
	jg punct3
	mov eax,192
	cmp x_old, eax
	jg punct3
	mov eax,96
	cmp x_old, eax
	jl punct3
	inc counter2
	mov b3,0
	
	punct3:
	make_banane_macro 'A', area, 320, b4               ;BANANA4 --la fel ca si la BANANA1
	 mov eax,b4
	 mov b4_old,eax
	 add eax, const 
     mov b4,eax
	 cmp eax,590
     jle next9
    
	
	make_banane2_macro 'A', area, 320, b4_old
	mov b4,0
	
	next9:
	mov eax,b4
	mov ebx, y_old
	sub ebx, eax
	cmp ebx, 50
	jg punct4
	mov eax,384
	cmp x_old, eax
	jg punct4
	mov eax,288
	cmp x_old, eax
	jl punct4
	inc counter2
	mov b4,0
	
	punct4:
	make_banane_macro 'A', area, 415, b5         ;BANANA5 --la fel ca si la BANANA1
	 mov eax,b5
	 mov b5_old,eax
	 add eax, const
     mov b5,eax
	 cmp eax,590
     jle next10
    
	
	make_banane2_macro 'A', area, 415, b5_old
	mov b5,0
	
	next10:
	mov eax,b5
	mov ebx, y_old
	sub ebx, eax
	cmp ebx, 50
	jg punct5
	mov eax,384
	cmp x_old, eax
	jl punct5
	inc counter2
	mov b5,0
	
	punct5:
	make_banane_macro 'A', area, 225, c2            ;BANANA6 --la fel ca si la BANANA1
	 mov eax,c2
	 mov c2_old,eax
	 add eax, const
     mov c2,eax
	 cmp eax,590
     jle next11
    
	
	make_banane2_macro 'A', area, 225, c2_old
	mov c2,0
	
	next11:
	mov eax,c2
	mov ebx, y_old
	sub ebx, eax
	cmp ebx, 50
	jg punct6
	mov eax,288
	cmp x_old, eax
	jg punct6
	mov eax,192
	cmp x_old, eax
	jl punct6
	inc counter2
	mov c2,0
	
	punct6:
	make_banane_macro 'A', area, 125, c3         ;BANANA7 --la fel ca si la BANANA1
	 mov eax,c3
	 mov c3_old,eax
	 add eax, const 
     mov c3,eax
	 cmp eax,590
     jle next12
    
	
	make_banane2_macro 'A', area, 125, c3_old
	mov c3,0
	
	next12:
	mov eax,c3
	mov ebx, y_old
	sub ebx, eax
	cmp ebx, 50
	jg punct7
	mov eax,192
	cmp x_old, eax
	jg punct7
	mov eax,96
	cmp x_old, eax
	jl punct7
	inc counter2
	mov c3,0
	
	punct7:
	make_banane_macro 'A', area, 320, c4        ;BANANA8 --la fel ca si la BANANA1
	 mov eax,c4
	 mov c4_old,eax
	 add eax, const
     mov c4,eax
	 cmp eax,590
     jle next13
    
	
	make_banane2_macro 'A', area, 320, c4_old
	mov c4,0
	
	next13:
	mov eax,c4
	mov ebx, y_old
	sub ebx, eax
	cmp ebx, 50
	jg punct8
	mov eax,384
	cmp x_old, eax
	jg punct8
	mov eax,288
	cmp x_old, eax
	jl punct8
	inc counter2
	mov c4,0
	
	punct8:
	make_banane_macro 'A', area, 25, c1         ;BANANA9 --la fel ca si la BANANA1
	 mov eax,c1
	 mov c1_old,eax
	 add eax, const
     mov c1,eax
	 cmp eax,590
     jle next14
    
	
	make_banane2_macro 'A', area, 25, c1_old
	mov c1,0
	
	next14:
	mov eax,c1
	mov ebx, y_old
	sub ebx, eax
	cmp ebx, 50
	jg punct9
	mov eax,384
	cmp x_old, eax
	jl punct9
	inc counter2
	mov c1,0
	
	punct9:
	mov eax,counter         ;se verifica cat timp o trecut, iar daca o trecut timp=50 se creste viteaza ( const creste cu 2 de fiecare data)
	mov ebx,timp             
	cmp eax,ebx
	jne afisare_litere
    add timp,100            ;timpul creste cu 100 (verificam cand mai trece timp=100 si crestem viteza)
	add const,2             ;const creste cu 2
	
afisare_litere:
	
	
	;afisam valoarea counter-ului curent (sute, zeci si unitati)
	mov ebx, 10
	mov eax, counter2
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 30, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 20, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 10, 10
	
	;desenam minionul o singura data (cand sta=0)
	mov eax,sta
	cmp eax,0
	jne continuare
	make_mini_macro 'M', area, 220, 580
	
    continuare:
	add eax,1      ;dupa ce l-am desenat o data, sta va tot creste si nu va mai fi 0 (nu mai desenam minionul de inceput)
    mov sta,eax	
	
    
	;desenam cele 5 linii 
	line_vertical  96, 0, 640, 0
	line_vertical  192, 0, 640, 0
	line_vertical  288, 0, 640, 0
	line_vertical  384, 0, 640, 0
	
	
final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	g:           ;aici se intra daca am pierdut jocul
	push offset text    ;se afiseaza GAME OVER
	call printf
	;terminarea programului
	push 0
	call exit
end start