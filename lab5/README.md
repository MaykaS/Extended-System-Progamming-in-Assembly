Function calls in assembly.
System calls in assembly.
Handling command line arguments in assembly.
Addressing modes.
Using the stack.

# task 1a-
complete the calls for the Unix system calls, complete the implementation of the _start label in the start.asm file
your code will mimic the gcc behavior.
# task 1b-
mplement the function utoa_s in assembly. 
The function receives an int (one digit or more) and converts it into a string. 
Change your c program to use the function you just implemented instead of utoa, and make sure it runs as expected.
# task 2a-
Write a pure assembly code that reads the content of the file using a buffer of size>=50 
and writes each buffer it reads to the standard output (stdout).
# task 2b-
Write a pure assembly code that reads the content of a file in a buffer of size>= 50, 
like in task 2a, if '-w' is received, counts the number of words that appear in the file and outputs it to the standard output. 
You can assume that '-w' comes before the filename (if -w is not received - execute task 2a).
