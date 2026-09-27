.global reverse
# list in %rdi (array of char*), n in %esi
reverse:
  movl $0, %edx     # %edx = i = 0
  movl %esi, %ecx   # %ecx = n 
  shrl $1, %ecx     # ecx >> 1 (divide by 2)

.Loop:
  cmpl %ecx, %edx   # i - n/2
  jae .L1           # go to .L1 if i - n/2 >= 0

  movq (%rdi, %rdx, 8), %r9     # temp = list[i]

  movl %esi, %r8d     # %r8d = n 
  subl %edx, %r8d     # -i 
  decl %r8d           # - 1

  movq (%rdi, %r8, 8), %r10    # %r10 = list[n-i-1]
  movq %r10, (%rdi, %rdx, 8)   # list[i] = list[n-i-1]
  movq %r9, (%rdi, %r8, 8)     # list[n-i-1] = temp

  incl %edx   # i++
  jmp .Loop
  

.L1:
  retq


# void reverse(char **list, unsigned n){
#     unsigned i = 0;
#     while (i < n/2){
#      char *temp = list[i];
#      list[i] = list[n-i-1];
#      list[n-i-1] = temp;
#      i++;
#     }
# }
