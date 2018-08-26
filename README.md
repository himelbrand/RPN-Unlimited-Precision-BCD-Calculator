# CASPL-172-Ass2
## Assignment Description

You are to write a simple RPN calculator for unlimited-precision unsigned integers, represented in Binary Coded Decimal (BCD).
Reverse Polish notation (RPN) is a mathematical notation in which every operator follows all of its operands, for example "3 + 4 =" would be presented as "3 4 +". For simplicity, each operator or number will appear on a separate line of input. For example, to enter a number 73 and then 80, and then add them, the user should type: 

73 
80 
+ 

Note that "73" will stored as 01110011, the hexadecimal representation of the actual bits is 0x73, and "80" will stored as 10000000, the hexadecimal representation of the actual bits is 0x80.

As shown above, in BCD the ASCII input is read such that each character represents a decimal digit, and each is then represented internally as a separate nibble (4 bits) quantity. The nibbles are then "packed" into bytes (2 nibbles, i.e. 2 BCD digits, per byte). This representation is somewhat wasteful, but simplifies the representation of numbers entered in decimal, because there is no need to do a full "decimal to binary" conversion of the entire number.

Operations are performed as is standard for an RPN calculator: any input number is pushed onto an operand stack, represented as an array (not the 80X86 machine stack), and each operation is performed on operands which are taken (and removed) from the stack. The result, if any, is pushed onto the operand stack. The output should contain no leading zeroes (but the input may have some leading zeroes).
The operand stack size should be 5, specified such that in order to change it to a different number only one line of code should be modified (hint: use EQU). You should print out "Error: Operand Stack Overflow" if the calculation attempts to push too many operands onto the stack, and "Error: Insufficient Number of Arguments on Stack" if an operation attempts to pop an empty stack. 
Note: if an operation was ended with error, The stack state should be the same as before performing the failed operation.
Your program should also count the number of operations (p, d, +, r, l) successfully performed. Number size is not bounded, except by the size of available memory.

The following section suggests a recommended implementation. You must use a linked list of "bytes" as shown below, but the actual implementation of the linked list (e.g. whether highest byte is first or last, singly connected or double connected) is up to you.


## Implementation of Unlimited Precision

In order to support unlimited precision, each operand in the operand stack stores a linked list (of bytes) for each operand. A linked list (of bytes, in this case) is implemented as follows. You should, conceptually, have a "type" consisting of a pointer to next, and a byte of data. Since there are no types in assembly language, any memory block of the requisite size (5 in this case: 4 for the pointer, one for the byte of data) can be seen as an element of this type. To make sure the memory blocks are free before use, you should allocate them from free memory on the heap, using malloc(), just as you would do in C.
If an operation results in a carry from the most significant byte, additional bytes must be allocated to store the results. The operand stack is best implemented as an array of pointers - each pointing to the first element of the list representing the number, or null (a null pointer has value 0). The operand stack size should still be 5.

Example:
123456 could be represented by the following linked list:
![linked list](https://www.cs.bgu.ac.il/~caspl162/wiki.files/ass2_NumberExample.png)

## The required operations

The operations to be supported by your calculator are:
* Quit (q)
* Addition (unsigned) (+)
* Pop-and-print (p)
* Duplicate (d)
* Shift right (r),
* Shift left (l),

The '+', 'r' and 'l' operators each get 2 operands, and provide one result. The "duplicate" operator takes one operand and provides two results - duplicates of its input operand. Note that all operands are implicit, i.e. they are popped from the stack, and not specified in the command line. The result(s) is pushed onto the stack. 
Pop-and-print takes one operand, and provides no result. It just prints the value of the operand to the standard output in decimal, as ASCII characters, of course (e.g. BCD value of 00100011 in memory will be printed as '23'). 'p' print the prefix ">>", no ">>calc:" (see example below). 

The 'r' and 'l' operators, work as follows. They both need two operands, the top of stack (TOS), which we call k, and the next from the TOS, which we call n. For both operators, if k is greater than 99, print an error "Error: exponent too large", and abort the operation. Otherwise, do the following computation (removing the 2 elements from the stack, and pushing the result onto the stack): Executing 'r' computes (n / 2^k). Executing 'l' computes (n * 2^k).


## Run example

An example of user input and program output appears below. Comments (which will not appear in input or output) are preceded by ";". The calculator prompt to the user is "calc: "


\>>calc: 9     ; user inputs a number

\>>calc: 1      ; user inputs another number

\>>calc: d      ; user enters "duplicate" operator

\>>calc: p      ; user enters pop-and-print-operator

\>>1

\>>calc: +      ; user enters "addition" operator, 10 is in top of (and is the sole element in) stack right after

\>>calc: d

\>>calc: p

\>>10 

\>>calc: 23      ; user enters another number 23

\>>calc: +

\>>calc: d

\>>calc: p

\>>33            ; the sum 

\>> calc: +

\>>Error: Insufficient Number of Arguments on Stack

\>>calc: 24      ; user inputs a number

\>>calc: 2     ; user inputs a number

\>>calc: r      ; user enters shift right operator

\>>calc: p 

\>>6      ; 24 / (2^2) = 6 

\>>calc: p

\>>33

\>>calc: q      ; Quit calculator

11      ; Number of operations performed




## Created by:
### Omri Himelbrand - 200863843
### Shahar Nussbaum - 203822309
