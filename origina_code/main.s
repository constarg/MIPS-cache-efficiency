.data

# input matrix A
arrayA: .word 2,-2, 4,-4, 6,-6, 8,-8,-9, 9,-7, 7,-5, 5,-3, 3
# input matrix Β
arrayB: .word 8, 7, 6, 5, 4, 3, 2, 1,-1,-2,-3,-4,-5,-6,-7,-8
# output matrix AM
arrayAM: .word 0:16
# output matrix BM
arrayBM: .word 0:16
# size of the array
size: .word 16

    .text
main:
   la     $t0, size              # Store the address of size in R1.
   la     $s0, arrayA            # Store the address of A[i] in $s0.
   la     $s1, arrayB            # Store the address of B[i] in $s1.
   lw     $t0, 0($t0)            # Load the size in $t0.
   sll    $t0, $t0,2             # Translate the size into the addresses.
   add    $s2, $t0,$s0           # Find the last address of A[].
   la     $s3, arrayAM           # Base address for AM[i].
   la     $s4, arrayBM           # Base address for BM[i].
   add    $s5, $zero,$s0         # Store address of A[j] in $s5.
   add    $s6, $zero,$s1         # Store address of B[j] in $s6.
Loop_i:
   lw     $t1, 0($s0)            # Get the value of A[i].
   lw     $t2, 0($s1)            # Get the value of B[i].
Loop_j:
   lw     $t3, 0($s5)            # Get the value of A[j].
   lw     $t4, 0($s6)            # Get the value of B[j].
   lw     $t5, 0($s3)            # Get the value of AM[i].
   lw     $t6, 0($s4)            # Get the value of BM[i].
   mul    $t7, $t1,$t4           # Multiple A[i] and B[j] and store it in $t7.
   slt    $t8, $t5,$t7           # if AM[i] < (A[i] * B[j]).
   beq    $t8, $zero,false_am    # Check if the above statement is true or false.
   sw     $t7, 0($s3)            # if the statement is true, then store the value in the AM[i].
false_am:                        # if the statemnt is false, then continue.
   mul    $t7, $t3,$t2            # Multiple A[j] and B[i] and store it in $t7.
   slt    $t8, $t6,$t7           # if BM[i] < A[j]*B[i]. 
   beq    $t8, $zero, false_amm  # Check if the above statement is true or false.
   sw     $t7, 0($s4)            # if the statement is true, then store the value in the BM[i].
false_amm:                       # if the statemnt is false, then continue.
   addi   $s5, $s5, 4            # Increace the A[j].
   addi   $s6, $s6, 4            # Increase the B[j].
   bne    $s5, $s2, Loop_j       # if j < n.
   la     $s5, arrayA            # A[j].
   la     $s6, arrayB            # B[j].
   addi   $s0, $s0, 4            # increase the A[i].
   addi   $s1, $s1, 4            # increase the B[i].
   addi   $s3, $s3, 4            # increase the AM[i].
   addi   $s4, $s4, 4            # increase the BM[i].
   bne    $s0, $s2, Loop_i       # if i < n.
