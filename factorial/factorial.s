global _start

section .data
    msg db "%d", 0x0a
    num db 6

section .text
    global _start
    extern printf

;rdi = num to factorial
factorial:
    push rbp
    mov rbp, rsp
    cmp rdi, 0
    je .return
    mul rdi
    dec rdi
    call factorial

.return:
    pop rbp
    ret   

_start:
    mov rax, 1
    mov rdi, [num]
    call factorial

print:
    mov     rdi, msg
    mov     rsi, rax 
    xor     rax, rax    ; printf expects rax to be 0 for variadic functions
    call    printf

    mov     rax, 60     ; syscall: exit
    xor     rdi, rdi    ; status 0
    syscall
