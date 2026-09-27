.global mult7div8
# a in %dil (signed char), overflow pointer in %rsi; result in %eax
mult7div8:
  movb %dil, %al    # move a to char mult
  shlb $3, %al      # shift 3 = multiply by 8
  subb %dil, %al    # subtract by one a to get the * 7 
  
  testb %dil, %dil  # test a 
  jg .L1            # go to .L1 if a > 0
  jl .L2            # go to .L2 if a < 0
  jmp .L4           # go to else statement

.L1:
  testb %al, %al    # test mult 
  jl .L3            # go to .L3 if mult < 0
  jmp .L4

.L2:
  testb %al, %al    # test mult 
  jg .L3            # go to .L3 if mult > 0
  jmp .L4

.L3:
  movb $1, (%rsi)     # *overflow = 1
  jmp .L5

.L4:
  movb $0, (%rsi)     # *overflow = 0

.L5:
  testb %al, %al    # test mult
  jns .L6           # if non negative

  addb $7, %al      # bias toward zero for negatives

.L6:
  sarb $3, %al      # divide by 8
  ret


# char mult7div8(char a, char *overflow){
#     char mult = (7 * a);
#     if(a > 0 && mult < 0 || a < 0 && mult > 0)
#       *overflow = 1;
#     else
#       *overflow = 0;
#     return mult/8;
# }
