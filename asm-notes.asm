
#-------------------------------------------------------------
     'x86 ASM NOTES' 
#-------------------------------------------------------------
; written by Rick (nanotechz9l) Flores

Assembly is critical because when the source code is unavailable, all you have is the machine instructions

[[SIMPLIFIED CPU ARCHITECTURE]]

+-------------------+
|                   |
| MEMORY            |
|___________________|
|                   | <---- EBP/ESP
| STACK             |
|___________________|
|                   |
|___________________|
|                   |
| HEAP DATA         |
|___________________|
|                   |
|___________________|
|                   |
| CODE              | <- EIP
|___________________|
|                   |
|___________________|


[Memory]
	x86 CPU main memory is split between the stack, and the heap for the data that the application uses, and the code of the program
	
[Stack]
 	Used for local variables in c
	
[Heap] 
	Used for anything allocated with the c malloc, and free functions

[Registers]
 	Single elements of the cpu that store values that are 32-bit long. So they can only store one 32-bit interger in each register
 	
 	-EBP/ESP registers usually point to the stack. ESP is the stack pointer, & shows where the current end of the stack is. When you add data on the stack the ESP register moves down, and when you remove data from the stack it moves up.
 	
 	-EIP is the instruction pointer, & always points to the current instruction being executed (magic 4 bytes). If you have any jumps or if you call a function, EIP moves to the instructions of that function.

 	- General registers like (eax, ebx, ecx, edx, esi, edi) are used to store temporary values & perform operations on them.



#-------------------------------------------------------------
     'ARITHMETIC INSTRUCTIONS' 
#-------------------------------------------------------------

Load a constant into registers, and can add/sub registers values. 

mov eax, 2   ; eax = 2
mov ebx, 3   ; ebx = 3
add eax, ebx ; eax = eax + ebx 
; notice the 2 argv's to the add instruction; the 1st argv (eax) serves both as the argv to the addition & the destination. This is equivalent to a += C operator.

sub ebx, 2   ; ebx = ebx - 2 ; subtract an interger from the register



#-------------------------------------------------------------
     'ACCESSING MEMORY' 
#-------------------------------------------------------------

If you need to work with more data than the registers can store. It is very limited because their is only 8 registers. You need to store the extra values that your going to operate on in memory. To use them you have a series of instructions for loading, and storing data in memory. You cant ususally operate on the data in the memory directly. You have to load it into the register then perform the operations on the registers and then maybe store the result back into memory.

Below are operations that are loading the contents from an address in memory, and storing the contents of a register in that memory position. 

mov eax, [1234]  ; eax = *(int*)1234
mov ebx, 1234    ; ebx = 1234
mov eax, [ebx]   ; eax = *ebx
mov [ebx], eax   ; *ebx = eax



#-------------------------------------------------------------
     'CONDITIONAL BRANCHES' 
#-------------------------------------------------------------

If the program has any loops, they are going to be implemented using branches like below:

cmp eax, 2  ; compare eax with 2
compares two argv's & based on the result, you have a set of conditional jmp instructions. Which perform a jmp somewhere else in the program if the two argv's are (=, greater than, less than, less than or =, does not =) ... etc 

je label1   ; if (eax == 2) goto label1
ja label2   ; if (eax > 2) goto label2  ; greater than
jb label3   ; if (eax < 2) goto label3  ; less than
jbe label4  ; if (eax <= 2) goto label4 ; less than or =
jne label5  ; if (eax !=2 ) goto label5 ; does not =

jmp label6  ; unconditional goto label6
This performs an unconditional jmp, which is the equivalent of goto in C.



#-------------------------------------------------------------
     'FUNCTION CALLS' 
#-------------------------------------------------------------

If you had a function you would call it with a call instruction. 

call func   ; store return address on the stack & jmp to function

When the function is executed, usually the function will save some of the registers on to the stack, and whenever it finishes doing whatever the function does it would restore those registers. This is so that the code can assume that when a function is called, those registers like ESI, are not modified by the function. Becasue the code always shares the same registers. So when you call a function, you dont want that function to mmess with the contents of the registers that you had before you called the function. 

func:
		push esi  ; save esi
		...
		pop esi   ; restore esi

		ret       ; read return address from the stack & jmp to it.

Finally at the end of a function, the function executes a 'rtn' return instruction which reads the return address from the stack, and jmps back to it. It executes a return back to the place where the call instruction was. 



RE: http://pentest.cryptocity.net/reverse-engineering/

