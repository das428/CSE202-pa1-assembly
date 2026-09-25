.global area
# a in %edi, b in %esi, c in %edx; result in %eax
area:
    movl %edi, %ecx      # p = a
    addl %esi, %ecx      # p = a + b
    addl %edx, %ecx      # p = a + b + c
    sarl $1, %ecx        # p / 2

    movl %ecx, %eax      # move p to return register

    movl %ecx, %r9d      # store p in a new register
    subl %edi, %r9d      # subtract by a

    movl %ecx, %r10d     # store p in a new register
    subl %esi, %r10d     # subtract by b

    movl %ecx, %r11d     # store p in a new register
    subl %edx, %r11d     # subtract by c

    imull %r9d, %eax     # multiply by (p-a)
    imull %r10d, %eax    # multiply by (p-b)
    imull %r11d, %eax    # multiply by (p-c)

    movl %eax, %edi      # move p to %edi (1st argument to r_sqrt)
    call r_sqrt          # %eax = sqrt(p)
    retq

r_sqrt:
    movl $0, %r12d      # = 0
    cmpl %r12d, %edi    # x - 0
    js .L1              # go to .L1 if x < 0
    addl $2, %r12d      # 0 += 2
    cmpl %r12d, %edi    # x - 2
    js .L2              # go to .L2 if x < 2
    
    pushq %rbx          # push old value of %rbx on the stack
    movl %edi, %ebx     # %ebx = x 

    sarl $2, %edi       # right shift by 2
    call r_sqrt         # r_sqrt(x >> 2)
    shll $1, %eax       # small_cand = result << 1

    leal 1(%rax), %ecx  # large_cand = small_cand + 1
    movl %ecx, %edx     # copy large_cand
    imull %edx, %edx    # %edx = large_cand * large_cand
    cmpl %ebx, %edx     # large_cand^2 - x
    jg .L3              # if greater, return small_cand
    movl %ecx, %eax     # else return large_cand

.L3:
    popq %rbx           # restore the caller's %rbx
    retq

.L1:
    movl $-1, %eax
    retq

.L2:
    movl %edi, %eax
    retq


# int area(int a, int b, int c){
#     int p = (a + b + c)/2;
#     p = p * (p-a) * (p-b) * (p-c);
#     return sqrt(p);
# }
# calculate recursively the square root of an int (in C)
# int r_sqrt(int x){
#    if(x < 0)
#        return -1;
#    if (x < 2)
#        return x;
#   /* recursive call */
#    int small_cand = r_sqrt(x >> 2) << 1;
#    int large_cand = small_cand + 1;
#    if (large_cand * large_cand > x)
#        return small_cand;
#    else
#        return large_cand;
# }
