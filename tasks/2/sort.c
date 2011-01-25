#include <stdio.h>
#include <stdlib.h>

int compare (const void *a, const void *b)
{
     return *(int*)a - *(int*)b;
}

int main(int argc, char *argv[])
{

	if (argc < 3)
    {
             return 1;
    }
	
    int count = 0,tmp,i;
    FILE *in,*out;    
    
    int *all_num = NULL,*tmp_array;
	
    for (i = 1; i < argc - 1; i++)
    {
        in = fopen(argv[i], "r");
        if (!in)
        {
                return 1;
        }
        while (!feof(in))
        {
              int number;
              tmp = fscanf(in, "%d", &number);
              if (!tmp)
              {
                       fclose (in);
                       return 1;
              }
              tmp_array = (int*) realloc(all_num,(count+1)*sizeof(int));
              if (!tmp_array)
              {
                       free(all_num);
                       fclose(in);
                       return 1;
              }
              all_num = tmp_array;
              all_num[count] = number;
              count ++;
        }
        fclose(in);
    }
    qsort (all_num, count, sizeof(int), compare);
    out = fopen(argv[argc - 1], "w");
    if (!out)
    {
             return 1;
    }
    for (i = 0; i < count; i++) 
	{
        tmp = fprintf(out, "%d\n", all_num[i]);
		if (!tmp) 
		{
			return 1;
		}
	}
	fclose (out);
	free (all_num);
    return 0;
}
//на выходе 0 - все успешно
//на выходе 1 - была ошибка