; An assembly source file is broken into the following sections:
; .model directive is used to indicate the size of the .data & .text sections.

; .stack The .stack directive marks the beginning of the stack section and is
; used to indicate the size of the stack in bytes.

; .data The .data directive marks the beginning of the data section and is used
; to define the variables, both initialized and uninitialized.

; .text The .text directive is used to hold the program’s commands.

section .text   ;mandatory section declaration
                ;export the entry point to the ELF linker or
global _start   ;loaders conventionally recognize
                ; _start as their entry point

	_syscall:
		int 80h
		ret

	_start:
                ;now, write our string to stdout
                ;notice how arguments are loaded in reverse

		; do not modify
		mov		ax, 0xdead
		push	ax
		
		; print hello message and clean-up stack
		; _syscall(len, msg, 0x1) 
		; 0x1 == file descriptor STDOUT
		; eax register must contain 0x4 -- sys_write
		; place your hello code here
				
		
		; do not modify
		pop		ax
		cmp		ax, 0xdead
		jnz		exit
		
		; print success message
		push 	dword success_len
		push 	dword success
		push 	dword 1
		mov 	eax, 0x4				
		call 	_syscall
		
		; exit
	exit:
		push	dword 0
		mov		eax, 0x1
		call	_syscall

section .data                                           ;section declaration

hello     		db      "Hello, world!",0xa     ;hello string with newline
hello_len   	equ     $ - hello                       ;length of our string, $ means here
success     	db      "Success!",0xa                  ;hello string with newline
success_len		equ     $ - success             ;length of our string, $ means here

;mov edx,len    ;third argument (message length)
;mov ecx,msg    ;second argument (pointer to message to write)
;mov ebx,1      ;load first argument (file handle (stdout))
;mov eax,4      ;system call number (4=sys_write)
;int 0x80       ;call kernel interrupt and exit
;mov ebx,0      ;load first syscall argument (exit code)
;mov eax,1      ;system call number (1=sys_exit)
;int 0x80       ;call kernel interrupt and exit

; The first step in assembling is to make the object code:
; $ nasm -f -g elf hello.asm
; Next, you invoke the linker to make the executable:
; $ ld -s -o hello hello.o


; nasm -fmacho -g <file>
; ld fn.o
; ./a.out