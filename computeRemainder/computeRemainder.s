global _start

section .data
    msg db "Remainder is %d", 0x0a, 0

section .text
    global _start
    extern printf

;rdi - first num
;rsi - second num
;rax - rdi % rsi
computeRemainder:
    push rbp
    mov rbp, rsp
    cmp rsi, 0
    je .return_0

;Enter division loop
.divLoop:
    cmp rdi, rsi
    jb .return
    sub rdi,rsi
    jmp .divLoop

.return:
    mov rax, rdi
    pop rbp
    ret

.return_0:
    xor rax, rax
    pop rbp
    ret

_start:
    mov rdi, 9
    mov rsi, 4
    call computeRemainder

print:
    mov     rdi, msg
    mov     rsi, rax
    xor     rax, rax    ; printf expects rax to be 0 for variadic functions
    call    printf

    mov     rax, 60     ; syscall: exit
    xor     rdi, rdi    ; status 0
    syscall
