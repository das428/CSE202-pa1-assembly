.global isPrime
# n in %edi; result in %eax (1 = prime, 0 = not prime)
isPrime:
  cmpl $2, %edi     # n - 2
  js .L1            # go to .L1 if n < 2 

  movl %edi, %ecx   # move n to %ecx
  andl $0x01, %ecx  # n & 1
  cmpl $0x00, %ecx  # (n & 1) - 0
  je .L2            # go to .L2 if n is even

  movl $3, %ecx     # %ecx = i = 3

.Loop:
  movl %ecx, %r8d   # %r8d = i
  imull %r8d, %r8d  # i * i

  cmpl %edi, %r8d   # (i * i) - n 
  jg .L4           # go to .L4 if less than or equal

  movl %edi, %eax   # move n to %eax

  movl $0, %edx     # clear %edx
  idivl %ecx        # n % i goes to %rdx

  testl %edx, %edx  # check if 0
  je .L3            # equal 

  addl $2, %ecx     # i += 2
  jmp .Loop

.L1:
  movl $0, %eax     #return 0
  retq

.L2:
  cmpl $2, %edi     # n - 2
  je .L4            # if n == 2, return 1
  movl $0, %eax     # otherwise return 0
  retq

.L3:
  movl $0, %eax     #return 0
  retq

.L4:
  movl $1, %eax     #return 1
  retq

# int isPrime(int n){
#     if(n < 2)
#         return 0;
#     if(n % 2 == 0)
#         return n == 2;
#     /* only test odd divisors i while i*i <= n */
#     for(int i = 3; i * i <= n; i += 2){
#         if(n % i == 0)
#             return 0;
#     }
#     return 1;
# }
