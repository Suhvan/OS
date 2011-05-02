#include <stdio.h>
#include <stdlib.h>

int compare (const void *a, const void *b)
{
     return *(int*)a - *(int*)b;
}

int main(int argc, char *argv[])
{

    char state = 0;

    int count = 0,tmp,i=1;
    FILE *in,*out;

    int *all_num = NULL,*tmp_array;

    while(1)
    {
        switch(state)
        {
            case 0://проверка аргументов
                if (argc < 3)
                {
                    state =  99;
                }
                else
                {
                    state = 1;
                }
                break;
            case 1://ввод
                if(i=argc-1)
                {
                    state = 3;
                }
                else
                {
                    in = fopen(argv[i], "r");
                    if (!in)
                    {
                        state =  99;
                    }
                    else
                    {
                        state = 2;
                    }

                }
            break;
            case 2://чтение файла
                if(feof(in))
                {
                    fclose(in);
                    i++;
                    state = 1;
                }
                else
                {
                    int number;
                    tmp = fscanf(in, "%d", &number);
                    if (!tmp)
                    {
                       fclose (in);
                       state = 99;
                    }
                    else
                    {
                        tmp_array = (int*) realloc(all_num,(count+1)*sizeof(int));
                        if (!tmp_array)
                        {
                            free(all_num);
                            fclose(in);
                            state = 99;
                        }
                        else
                        {
                            all_num = tmp_array;
                            all_num[count] = number;
                            count ++;
                        }
                    }
                }
                break;

            case 3://сортируем, готовимся к выводу
                qsort (all_num, count, sizeof(int), compare);
                out = fopen(argv[argc - 1], "w");
                if (!out)
                {
                    state = 99;
                }
                else
                {
                    state = 4;
                    i=0;
                }
                break;

            case 4://вывод
            if(i = count)
            {
                fclose (out);
                free (all_num);
                state = 100;

            }
            else
            {
                tmp = fprintf(out, "%d\n", all_num[i]);
                if (!tmp)
                {
                    state = 99;
                }
                else
                {
                    i++;
                }

            }

            break;


            case 99:
            case 100:
                return 100-state;

        }
    }


}
//на выходе 0 - все успешно
//на выходе 1 - была ошибка