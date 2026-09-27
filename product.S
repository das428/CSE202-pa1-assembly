.global product
# a in %rdi, b in %rsi, c in %rdx, size in %ecx
product:
    movl $0, %r8d     # %r8d = i = 0

.Loop:
    cmpl %r8d, %ecx     # size - i
    jle .L1             # if size - i <= 0

    vmovss (%rdi, %r8, 4), %xmm0    # xxm0 = a[i]
    vmulss (%rsi, %r8, 4), %xmm0, %xmm0    # xmm0 = a[i] * b[i]
    vmovss %xmm0, (%rdx, %r8, 4)    # c[i] = xmm0

    incl %r8d       # i++
    jmp .Loop


.L1:
    ret

# Product of two vectors in C
# void product(float *a, float *b, float *c, unsigned size){
#    for(int i=0; i<size; i++){
#        c[i] = a[i] * b[i];
#    }
# }
