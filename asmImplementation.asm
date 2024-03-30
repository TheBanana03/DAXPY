; Dane Chan, S16
%include "io64.inc"

section .data
A dq 2.0
X dq 1.0, 2.0, 3.0
Y dq 11.0, 12.0, 13.0
Z dq 0.0, 0.0, 0.0

n dq 3
temp dq 0

msg dq "Answer: %1f", 0
msgExt dq ", %1f", 0

section .text
extern printf

global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    sub rsp, 8*5
    mov r8, [n]
    sub r8, 0x1
    
    L1:
        cmp r8, 0x0
        jl printFirst
                    
        movsd xmm1, [A + r8*8]
        movsd xmm2, [X + r8*8]
        movsd xmm3, [Y + r8*8]
        
        mulsd xmm2, xmm1
        addsd xmm2, xmm3
        
        movsd [Z + r8*8], xmm2
        
        dec r8
        
        jmp L1
   
    printFirst:
        mov r8, [n]
        
        movsd xmm1, [Z]
        movq rdx, xmm1
        lea rcx, [msg]
        
        call printf
        
        add rsp, 8*5
        
        mov qword [temp], 0x1
        mov r9, [temp]
        
        jmp Print
    
    Print:
        mov r9, [temp]
    
        cmp r9, [n]
        jge Tapos
        
        sub rsp, 8*5
        
        mov r9, [temp]
        movsd xmm1, [Z + r9*8]
        movq rdx, xmm1
        lea rcx, [msgExt]
        call printf
        
        add rsp, 8*5
        
        mov r9, [temp]
        inc r9
        mov qword [temp], r9
        
        jmp Print
        
    Tapos:
        ;add rsp, 8*5
        
    xor rax, rax
    ret