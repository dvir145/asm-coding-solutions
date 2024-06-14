global _start

section .data
    msg db "Max value is %d", 0x0a
    arr db 7,2,3,9,5,8
    arrlen db 6

section .text
    global _start
    extern printf

;rdi = arr pointer
;rsi = arr length
;rax = max value
;al must be 0
;Treating all values as unsigned
maxNumber:
    push rbp
    mov rbp, rsp
    dec rsi
    xor rcx, rcx

.maxLoop:
    cmp [rdi + rcx], al
    ja .setMax
    cmp rcx, rsi
    je .return
    inc rcx
    jmp .maxLoop

.setMax:
    mov al, [rdi + rcx]
    jmp .maxLoop

.return:
    pop rbp
    ret   

_start:
    xor al, al
    mov rdi, arr
    mov rsi, [arrlen]
    call maxNumber

print:
    mov     rdi, msg
    movzx   rsi, al 
    xor     rax, rax    ; printf expects rax to be 0 for variadic functions
    call    printf

    mov     rax, 60     ; syscall: exit
    xor     rdi, rdi    ; status 0
    syscall
