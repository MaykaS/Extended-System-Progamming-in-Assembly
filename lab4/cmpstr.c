#include <stdio.h>


int cmpstr(char *argv1, char *argv2){
    int i = 0;

    /* Iterate untill both strings are equal */
    while(argv1[i] == argv2[i])
    {
        if(argv1[i] == '\0' && argv2[i] == '\0')
            break;

        i++;
    }

    /* Return the difference of current characters. */
    int ans=(argv1[i] - argv2[i]);
    if(ans==(-1))
        ans=2;
    return ans;
}
