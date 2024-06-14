global _start

section .data
    msg db "Sum is %u", 0x0a
    arr db 7,2,3,4,5
    arrlen db 5

section .text
    global _start
    extern printf

;rdi = arr pointer
;rsi = arr length
;rax = sum
;rax must be 0
sumNumbers:
    push rbp
    mov rbp, rsp
    xor rcx, rcx
    dec rsi

.sumLoop:
    add al, [rdi + rcx] ; using al (8 bit) to treat 8 bit elements in array
    cmp rcx, rsi
    je .return
    inc rcx
    jmp .sumLoop

.return:
    pop rbp
    mov rbx, rax 
    ret   

_start:
    xor rax, rax
    mov rdi, arr
    mov rsi, [arrlen]
    call sumNumbers

print:
    mov     rdi, msg
    mov     rsi, rbx    ; Sum to print
    xor     rax, rax    ; printf expects rax to be 0 for variadic functions
    call    printf

    mov     rax, 60     ; syscall: exit
    xor     rdi, rdi    ; status 0
    syscall
