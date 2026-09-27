.global gcd
# a in %edi, b in %esi; result in %eax
gcd:
    testl %esi, %esi     # b & b
    je .L1              # go to .L1 if b == 0

    movl %edi, %eax     # move a to %rax
    
    movq $0, %rdx        # reset rdx to 0

    idivl %esi          # %edx = a % b
    

    movl %esi, %edi     # move b to the first argument
    movl %edx, %esi     # move a to the second argument

    call gcd 
    retq

.L1:
    movl %edi, %eax     #return a
    retq


# greatest common divisor via Euclid's algorithm (recursive)
# int gcd(int a, int b){
#     if(b == 0)
#         return a;
#     /* recursive call */
#     return gcd(b, a % b);
# }
