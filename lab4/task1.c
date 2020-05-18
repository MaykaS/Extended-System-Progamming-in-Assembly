#include <stdio.h>
#include <stdlib.h>

extern int funcA(char *ch1);

int main(int argc, char **argv){
  int res;
    if (argc != 2){
    fprintf(stderr,"Usage: funcA char1  \n");
    return 0;
  }
  
  char *ch1;
  ch1= argv[1]; /*it is the first*/

  
  res = funcA(ch1);
  printf("%d \n",res);
  
return 0;
}
