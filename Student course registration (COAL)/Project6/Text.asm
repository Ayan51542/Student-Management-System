INCLUDE irvine32.inc
INCLUDE macros.inc
BUFFER_SIZE = 5001

.data
bool byte ?
username byte 30 dup (0)
password byte 60 dup (0)
un byte  "project",0
pw byte  "admin",0

choice dword 0
x byte  ?

name_ byte 20 dup (0)
name_string byte "NAME:",0
roll_no byte 9 dup (0)
roll_no_string byte "ROLL NUMBER:",0
course  byte 10 dup (0)
course_string byte "COURSE:",0
address byte 10 dup (0)
address_string byte "STUDENT ADDRESS:",0
email_id byte 30 dup (0)
email_id_string byte "EMAIL ID:",0;
contact_no byte 11 dup(0)
contact_no_string byte"CONTACT INFO:",0

buffer BYTE BUFFER_SIZE DUP(0)
buffStr BYTE BUFFER_SIZE DUP(?)
fileName BYTE 8 DUP (?)
fileHandle HANDLE ?
strLen DWORD 0
txt BYTE ".txt",0

menu PROTO
insert PROTO
search PROTO
deleted PROTO
modify PROTO
ISloggedIN PROTO

.code
;calls login function if true within 3 tries moves to display orelse end
main PROC
mov eax, red + (black*16)
call SetTextColor
call ISloggedIN
mov al,bool
cmp al,"f"
je _end
call menu
_end:      
    exit
main endp


menu PROC
pushad
call Clrscr
start:           
     mov dl,40
     mov dh,0
     call gotoxy
     mWrite "||||||||||Student Management System||||||||||"     
     mov dl,45
     mov dh,2
     call gotoxy
     mWrite "Select[1]->Enter New Record"     
     mov dl,45
     mov dh,3
     call gotoxy
     mWrite "Select[2]->Search Record"    
     mov dl,45
     mov dh,4
     call gotoxy
     mWrite "Select[3]->Delete Record"     
     mov dl,45
     mov dh,5
     call gotoxy
     mWrite "Select[4]->Modify Record"     
     mov dl,45
     mov dh,6
     call gotoxy
     mWrite "Select[5]->Exit"         
     mov dl,45
     mov dh,7
     call gotoxy
     mWrite "Enter your choice: "     
     call ReadDec
     mov choice,eax
     cmp eax,1
     je call_insert     
     cmp eax,2
     je call_search
     cmp eax,3
     je call_deleted
     cmp eax,4
     je call_modify
     cmp eax,5
     je exitt     
     mov dl,45
     mov dh,8
     call gotoxy
     mWrite "Invalid choice... Please Try Again.."
     jmp break


call_insert:
           call insert
           mov dl,43
           mov dh,11
           call gotoxy
           mWrite "Add Another Student Record? (Press Y/N): "
           mov eax,0
           call ReadChar
           mov x,al
           cmp al,'Y'
           je call_insert
           cmp al,'y'
           je call_insert
           call Clrscr
           jmp start

call_search:
           call search
           call crlf           
           mWrite "Search Another Student Record? (Press Y/N): "
           mov eax,0
           call ReadChar
           mov x,al
           cmp al,'y'
           je call_search
           cmp al,'Y'
           je call_search
           call Clrscr
           jmp start

call_deleted:
           call deleted
           mov dl,40
           mov dh,7
           call gotoxy          
           mWrite "Delete Another Student Record? (Press Y/N): "
           mov eax,0
           call ReadChar
           mov x,al
           cmp al,'y'
           je call_deleted
           cmp al,'Y'
           je call_deleted
           call Clrscr
           jmp start

call_modify:
           call modify
           mov dl,43
           mov dh,11
           call gotoxy          
           mWrite "Modify Another Student Record? (Press Y/N): "
           mov eax,0
           call ReadChar
           mov x,al
           cmp al,'y'
           je call_modify
           cmp al,'Y'
           je call_modify
           call Clrscr
           jmp start


break:     
     call ReadChar;holding the screen until any key is pressed
     call Clrscr
     jmp start

exitt:
     popad
     ret
menu endp
 

insert PROC
Pushad
call Clrscr
mov dl,40
mov dh,0
call gotoxy
mWrite "||||||||||Add Student Details||||||||||"

mov dl,50
mov dh,3
call gotoxy
mWrite "Enter Name: "
mov edx,offset name_
mov ecx,20
call ReadString

mov dl,50
mov dh,4
call gotoxy
mWrite "Enter Roll No: "
mov edx,offset roll_no
mov ecx,8
call ReadString

mov dl,50
mov dh,5
call gotoxy
mWrite "Enter Course: "
mov edx,offset course
mov ecx,11
call ReadString

mov dl,50
mov dh,6
call gotoxy
mWrite "Enter Email Id: "
mov edx,offset email_id
mov ecx,31
call ReadString

mov dl,50
mov dh,7
call gotoxy
mWrite "Enter Contact No: "
mov edx,offset contact_no
mov ecx,12
call ReadString

mov dl,50
mov dh,8
call gotoxy
mWrite "Enter Address: "
mov edx,offset address
mov ecx,11
call ReadString

mov esi, offset roll_no
mov edi, offset fileName
mov ecx, LENGTHOF roll_no
CLD
rep movsb

mov esi, offset txt
mov edi, offset fileName
add edi, LENGTHOF roll_no
CLD
mov ecx, LENGTHOF txt
rep movsb

mov edx, OFFSET fileName
call CreateOutputFile
mov fileHandle, eax

mov esi, offset name_string
mov edi, offset buffStr
mov strlen, LENGTHOF name_string
CLD
mov ecx, LENGTHOF name_string
rep movsb

mov esi, offset name_
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF name_
add strLen,LENGTHOF name_
rep movsb

mov esi, offset roll_no_string
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF roll_no_string
add strLen, LENGTHOF roll_no_string
rep movsb

mov esi, offset roll_no
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF roll_no
add strLen, LENGTHOF roll_no
rep movsb

mov esi, offset course_string
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF course_string
add strLen, LENGTHOF course_string
rep movsb

mov esi, offset course
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF course
add strLen, LENGTHOF course
rep movsb

mov esi, offset contact_no_string
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF contact_no_string
add strLen, LENGTHOF contact_no_string
rep movsb

mov esi, offset contact_no
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF contact_no
add strLen, LENGTHOF contact_no
rep movsb

mov esi, offset address_string
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF address_string
add strLen, LENGTHOF address_string
rep movsb

mov esi, offset address
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF address
add strLen, LENGTHOF address
rep movsb

mov esi, offset email_id_string
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF email_id_string
add strLen, LENGTHOF email_id_string
rep movsb

mov esi, offset email_id
mov edi, offset buffStr
add edi, strLen
CLD
mov ecx, LENGTHOF email_id
add strLen, LENGTHOF email_id
rep movsb

mov eax, fileHandle
mov edx, OFFSET buffStr
mov ecx, LENGTHOF buffStr
call WriteToFile

mov eax, fileHandle
call CloseFile
call Crlf
popad
ret
insert endp


search PROC
pushad
mov eax,0
call Clrscr
call crlf
mWrite "||||||||||Search Student Details||||||||||"
call crlf
mWrite "Enter Roll No to be Search: "
mov edx, OFFSET fileName
mov ecx, LENGTHOF fileName
call ReadString

mov esi, offset txt
mov edi, offset fileName
add edi, LENGTHOF fileName
CLD
mov ecx, LENGTHOF txt
rep movsb

mov edx, offset fileName
call OpenInputFile
jnc read_
mWrite "No Student of that Roll No"
jmp endd

read_:
      mov fileHandle, eax
      mov edx, offset buffStr
      mov ecx, sizeof buffStr     
      call ReadFromFile          
      mov buffStr[eax],0              
      mov eax,fileHandle
      call CloseFile      
      mov ecx,lengthof buffStr
      mov ebx,0
      l1:
         mov al,buffStr[ebx]
         inc ebx
         call writechar
         loop l1
endd:
    popad
    ret
search endp


modify PROC
pushad
mov eax,0
call Clrscr
mov dl,40
mov dh,0
call gotoxy
mWrite "||||||||||Modify Student Details||||||||||"
mov dl,50
mov dh,3
call gotoxy
mWrite "Enter Roll No to be Modify: "
mov edx, OFFSET fileName
mov ecx, LENGTHOF fileName
call ReadString

mov esi, offset txt
mov edi, offset fileName
add edi, LENGTHOF fileName
CLD
mov ecx, LENGTHOF txt
rep movsb

mov edx, OFFSET filename
call CreateOutputFile
mov fileHandle, eax

mov eax, fileHandle
mov edx, OFFSET buffer
mov ecx, BUFFER_SIZE
call WriteToFile

mov eax, fileHandle
call CloseFile
call Crlf

endd:
    popad
    call insert
    ret
modify endp


deleted PROC
pushad
mov eax,0
call Clrscr
mov dl,40
mov dh,0
call gotoxy
mWrite "||||||||||Delete Student Details||||||||||"
mov dl,50
mov dh,3
call gotoxy
mWrite "Enter Roll No to be Deleted: "
mov edx, OFFSET fileName
mov ecx, LENGTHOF fileName
call ReadString

mov esi, offset txt
mov edi, offset fileName
add edi, LENGTHOF fileName
CLD
mov ecx, LENGTHOF txt
rep movsb

mov edx, OFFSET filename
call CreateOutputFile
mov fileHandle, eax

mov eax, fileHandle
mov edx, OFFSET buffer
mov ecx, BUFFER_SIZE
call WriteToFile

mov eax, fileHandle
call CloseFile
mov dl,45
mov dh,4
call gotoxy
mWrite"!!!Student details deleted!!!"
call Crlf

endd:
    popad
    ret
deleted endp


ISloggedIN proc
pushad
mov ebx,3
start:     
     mov dl,40
     mov dh,3
     call gotoxy
     mWrite "Enter Username: "
     mov edx,offset username
     mov ecx,30
     call ReadString
     mov dl,40
     mov dh,4
     call gotoxy
     mWrite  "Enter Password: "     
     mov edx,offset password
     mov ecx,60
     call ReadString

     CLD
     mov esi,offset un
     mov edi,offset username
     mov ecx,lengthof un
     repe cmpsb
     je check_password
     jmp errr


check_password:
              CLD
              mov esi,offset pw
              mov edi,offset password
              mov ecx,lengthof pw
              repe cmpsb
              je succ
              jmp errr

errr:
    mov dl,38
    mov dh,6
    call gotoxy
    mWrite "////Invalid Login////"    
    mov dl,"f"
    mov bool,dl
    dec ebx
    cmp ebx,0
    jne j1   
    jmp j2

j2:
   mov dl,41
   mov dh,7
   call gotoxy
   mov eax,ebx
   call writedec
   mov dl,42
   mov dh,7
   call gotoxy
   mWrite " Attempts left"
   call Crlf
   jmp rett

j1:
   mov dl,43
   mov dh,7
   call gotoxy
   mWrite "/Try Again\"
   mov dl,41
   mov dh,8
   call gotoxy
   mov eax,ebx
   call writedec
   mov dl,42
   mov dh,8
   call gotoxy
   mWrite " Attempts left"
   call readchar
   call Crlf
   call Clrscr
   jmp start

succ:
     mov dl,36
     mov dh,6
     call gotoxy
     mWrite "////LogIn Successful////"     
     mov dl,"t"
     mov bool,dl
     jmp rett

rett:
    popad
ret
ISloggedIN endp
end main