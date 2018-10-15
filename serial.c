#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<sys/types.h>

int main(int argc, char *argv[])  //argv[1] = - for prev. episode;0 or nothing for same episode; + for next episode and . for next season
{
	int season, episode;
	char buffer[20];
	FILE *fp;

	if(argc  == 3 && isdigit(*argv[1]) && isdigit(*argv[2]))   //directly getting season and episode number from the command line argunment
	{
		season = atoi(argv[1]);
		episode = atoi(argv[2]);
		fp = fopen("serial.txt","w");
	}
	else
	{
		fp = fopen("serial.txt","r");//"se.txt" has last opened season and episode number resp.
		fscanf(fp, "%d %d",&season, &episode),
		fclose(fp);

		fp = fopen("serial.txt","w");

		if(argc ==	2)			//choosing video with +, - and .
		{
			if(*argv[1] == '.')
				season++,episode=1;

			else if(*argv[1] == '+')
				episode++;

			else if(*argv[1] == '-')
				if(episode == 1)
					printf("ITS THE FIRST EPISODE OF THE SEASON"),
					fprintf(fp, "%d %d", season, episode),
					exit(0);
				else
					episode--;
		}
	}

	fprintf(fp, "%d %d", season, episode);

	fclose(fp);

	snprintf(buffer, sizeof(buffer), "./serial.sh %d %d", season, episode);

	system(buffer);

}
