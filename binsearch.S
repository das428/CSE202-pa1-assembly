.global binsearch
# arr in %rdi, n in %esi, target in %edx
binsearch:
  movl $0, %ecx     # int lo = 0
  movl %esi, %r8d   # int hi = n
  decl %r8d         # hi--

.Loop:
  cmpl %ecx, %r8d   # hi - lo
  jl .Lnotfound     # if hi < lo

  movl %r8d, %r9d   # mid = hi
  subl %ecx, %r9d   # hi - lo
  sarl $1, %r9d     # / 2
  addl %ecx, %r9d   # + lo

  movl (%rdi, %r9, 4), %r10d   # %r10d = arr[mid]

  cmpl %edx, %r10d  # arr[mid] - target
  je .L1            # arr[mid] == target
  jl .L2            # arr[mid] < target

  leal -1(%r9), %r8d  # else, hi = mid - 1
  jmp .Loop

.L1:
  movl %r9d, %eax   #return mid
  ret

.L2:
  leal 1(%r9), %ecx   # lo = mid + 1
  jmp .Loop
  
.Lnotfound:
  movl $-1, %eax
  ret



# binary search over a sorted int array; returns the index of target, or -1
# int binsearch(int *arr, unsigned n, int target){
#     int lo = 0;
#     int hi = (int)n - 1;
#     while(lo <= hi){
#         int mid = lo + (hi - lo) / 2;
#         if(arr[mid] == target)
#             return mid;
#         else if(arr[mid] < target)
#             lo = mid + 1;
#         else
#             hi = mid - 1;
#     }
#     return -1;
# }
