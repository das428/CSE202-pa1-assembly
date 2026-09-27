.global commonPrefix
# a in %rdi, b in %rsi; result (prefix length) in %eax
commonPrefix:
  movl $0, %edx    # n = 0

.Loop:
  movb (%rdi, %rdx, 1), %cl      # %ecx = a[n]
  testb %cl, %cl                 # check for \0
  je .L1

  cmpb (%rsi, %rdx, 1), %cl      # a[n] - b[n]

  jne .L1           # not equal
  
  incl %edx         # n++
  jmp .Loop

.L1:
  movl %edx, %eax   #move to return register
  retq


# length of the longest common prefix of two null-terminated strings
# int commonPrefix(char *a, char *b){
#     int n = 0;
#     while(a[n] && a[n] == b[n])
#         n++;
#     return n;
# }
