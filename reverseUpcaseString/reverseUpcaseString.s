global _start

section .data
    msg db "%s", 0x0a
    arr db "this Is A string", 0

section .text
    global _start
    extern printf

;rdi = str pointer
;rax = pointer to the string (same address)
reverseUpcaseString:
    push rbp
    mov rbp, rsp
    xor rcx, rcx
    mov rax, rdi
    push 0

.reversePushLoop:
    mov bl, [rax + rcx]
    cmp bl, 0
    je .reversePopEntry
    cmp rbx, 'a'
    jb .not_uppercase
    cmp rbx, 'z'
    ja .not_uppercase
    sub bl, 0x20
    push rbx
    inc rcx
    jmp .reversePushLoop

.not_uppercase:
    push rbx
    inc rcx
    jmp .reversePushLoop

.reversePopEntry:
    xor rcx, rcx
    mov rax, rdi

.reversePop:
    pop rbx
    mov [rax + rcx], bl
    inc rcx
    cmp bl, 0
    je .return
    jmp .reversePop


.return:
    mov rax, rdi
    pop rbp
    ret   

_start:
    mov rdi, arr
    call reverseUpcaseString

print:
    mov     rdi, msg
    mov     rsi, rax
    xor     rax, rax    ; printf expects rax to be 0 for variadic functions
    call    printf

    mov     rax, 60     ; syscall: exit
    xor     rdi, rdi    ; status 0
    syscall
