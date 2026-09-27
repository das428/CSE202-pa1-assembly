.global secondMax
# v1 in %di, v2 in %si, v3 in %dx, v4 in %cx  (signed 16-bit); result in %ax
secondMax:
  cmpw %si, %di   # v1 - v2
  jl .L1    # v1 - v2 < 0

  movw %di, %r8w  # first= v1
  movw %si, %ax   # second = v2
  jmp .L2

.L1:
  movw %si, %r8w    # first = v2
  movw %di, %ax     # second = v1

.L2:
  cmpw %r8w, %dx         # v3 - first
  jle .L3                # if v3 <= first
  movw %r8w, %ax         # second = first
  movw %dx, %r8w         # first = v3
  jmp .L4

.L3:
  cmpw %ax, %dx       # v3 - second
  jle .L4             # if v3 <= second, nothing changes
  movw %dx, %ax       # second = v3

.L4:
  cmpw %r8w, %cx    # v4 - first
  jle .L5                # if v4 <= first
  movw %r8w, %ax         # second = first
  movw %cx, %r8w         # first = v4
  jmp .L6        

.L5:
  cmpw %ax, %cx          # v4 - second
  jle .L6                # if v4 <= second
  movw %cx, %ax          # second = v4

.L6: 
  retq

# short secondMax(short v1, short v2, short v3, short v4){
#     short first, second;
#     if(v1 >= v2){ first = v1; second = v2; }
#     else        { first = v2; second = v1; }
#     if(v3 > first)       { second = first; first = v3; }
#     else if(v3 > second) { second = v3; }
#     if(v4 > first)       { second = first; first = v4; }
#     else if(v4 > second) { second = v4; }
#     return second;
# }
