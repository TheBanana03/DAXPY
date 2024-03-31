; Dane Chan, S16
%include "io64.inc"

section .data
A dq 2.0
X dq 1.0, 2.0, 3.0
Y dq 11.0, 12.0, 13.0
Z dq 0.0, 0.0, 0.0

n dq 3

section .text\

global main
main:
    mov rbp, rsp; for correct debugging
    ;write your code here
    mov r8, [n]
    sub r8, 0x1
    
    L1:
        cmp r8, 0x0
        jl Tapos
                    
        movsd xmm1, [A + r8*8]
        movsd xmm2, [X + r8*8]
        movsd xmm3, [Y + r8*8]
        
        mulsd xmm2, xmm1
        addsd xmm2, xmm3
        
        movsd [Z + r8*8], xmm2
        
        dec r8
        
        jmp L1
    Tapos:
        
    xor rax, rax
    ret