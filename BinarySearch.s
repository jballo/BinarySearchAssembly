.data

original_list: .space 100
sorted_list: .space 100

str0: .asciiz "Enter size of list (between 1 and 25): "
str1: .asciiz "Enter one list element: "
str2: .asciiz "Content of original list: "
str3: .asciiz "Enter a key to search for: "
str4: .asciiz "Content of sorted list: "
strYes: .asciiz "Key found!"
strNo: .asciiz "Key not found!"

newLine: .asciiz "\n"


.text

#This is the main program.
#It first asks user to enter the size of a list.
#It then asks user to input the elements of the list, one at a time.
#It then calls printList to print out content of the list.
#It then calls inSort to perform insertion sort
#It then asks user to enter a search key and calls bSearch on the sorted list.
#It then prints out search result based on return value of bSearch
main:
    addi $sp, $sp -8
    sw $ra, 0($sp)        # main's return address is stored in 0($sp)
    li $v0, 4         # call command that we are printing string
    la $a0, str0         # $a0 is loaded with str0
    syscall         # print str0 = "Enter size of list (between 1 and 25): "
    li $v0, 5    #read size of list from user
    syscall
    move $s0, $v0        # length of array is stored in $s0
    move $t0, $0        # reg $t0 is stored with the value $0
    la $s1, original_list   # original_list is stored in $s1
loop_in:
    li $v0, 4         # call command to print "Enter one list element: "
    la $a0, str1         # $a0 is loaded with str1
    syscall         # printed "Enter one list element: "
    sll $t1, $t0, 2        # $t1 = $t0 * 4 ----> $t1 = 4 * i
    add $t1, $t1, $s1       # $t1 = $t1 + $s1 --> $t1 = (4 * i) + orginal_list
    li $v0, 5    #read elements from user
    syscall
    sw $v0, 0($t1)        # input moved to $t1 ---> $v0 ---> A[i]  (?)
    addi $t0, $t0, 1    # $t0 = $t0 + 1 ---> $t0 = i + 1
    bne $t0, $s0, loop_in   # if($t0 != $s0){ jump to loop_in }
    move $a0, $s1        # $s1 ---> $a0   (store original_list into $a0)
    move $a1, $s0        # $s0 ---> $a1   (store list length into $a1)
    
    jal inSort    #Call inSort to perform insertion sort in original list
    
    sw $v0, 4($sp)    # store inSort's return value in 4($sp)
    li $v0, 4     # command to call that we are printing string
    la $a0, str2    # $a0 is loaded with "Content of original list: "
    syscall     # print "Content of original list: "
    la $a0, original_list
    move $a1, $s0
    jal printList    #Print original list
    li $v0, 4
    la $a0, str4
    syscall
    lw $a0, 4($sp)
    jal printList    #Print sorted list
    
    li $v0, 4
    la $a0, str3
    syscall
    li $v0, 5    #read search key from user
    syscall
    move $a3, $v0
    lw $a0, 4($sp)
    jal bSearch    #call bSearch to perform binary search
    
    beq $v0, $0, notFound
    li $v0, 4
    la $a0, strYes
    syscall
    j end
    
notFound:
    li $v0, 4
    la $a0, strNo
    syscall
end:
    lw $ra, 0($sp)
    addi $sp, $sp 8
    li $v0, 10
    syscall
    
    
#printList takes in a list and its size as arguments.
#It prints all the elements in one line.
printList:
    #Your implementation of printList here
    #a0 is holds the address of the original_list
    #a1 holds the length of the array
    
    addi $t0, $0, 0           # i = 0
    move $s3, $a0        #move address of original_list to $s3
    
printElement:
    # ***debug*** print out the current index
    #li $v0, 1
    #move $a0, $t0            # print ( i )
   # syscall
    
    # load the current A[i]
    
    sll $t1, $t0, 2        # $t1 = $t0 * 4 ----> $t1 = 4 * i
    add $t1, $t1, $s3       # $t1 = $t1 + $s3 --> $t1 = (4 * i) + orginal_list
    
    lw $t1, 0($t1)     # t1 = A[i]  ??
    
    
    # print out the current A[i]
    
    li $v0, 1
    move $a0, $t1
    syscall
    
    # print out space character
    li $a0, 32                # decimal character for space is 32
    li $v0, 11                # command to print out char
    syscall                # print out space (aka " ")
    
    # increment out counter
    addi $t0, $t0, 1            # i = i + 1
    
    # check if (  i == arraySize ) { loop printElement }
    bne $t0, $a1, printElement

    jr $ra
    
    
#inSort takes in a list and it size as arguments.
#It performs INSERTION sort in ascending order and returns a new sorted list
#You may use the pre-defined sorted_list to store the result
inSort:
    #Your implementation of inSort here
    
    # $a0 stores the address of original_list
    # $a1 stores list length of array
    
    addi $t0, $0, 0           # i = 0
    move $s3, $a0        #move address of original_list to $s3
    
    #load address of sorted_list into register
    la $s0, sorted_list
    
insertElement:
    # ***debug** print out current index
    
    
    #


    # insert A[i] into B[i]
    
    
    sw $v0, 4($sp)    # store inSort's return value in 4($sp)
    
    jr $ra
    
    
#bSearch takes in a list, its size, and a search key as arguments.
#It performs binary search RECURSIVELY to look for the search key.
#It will return a 1 if the key is found, or a 0 otherwise.y
#Note: you MUST NOT use iterative approach in this function.
bSearch:
    #Your implementation of bSearch here
    
    jr $ra
    
