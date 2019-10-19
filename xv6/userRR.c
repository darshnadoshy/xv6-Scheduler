#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  if(argc > 5 || argc < 5 ){
    printf(2, "Usage:  userRR <user-level-timeslice> <iterations> <job> <jobcount>\n");
    exit();
  }
  // Initialize the values from cmd line args
  int user_timeslice = atoi(argv[1]);
  int iterations = atoi(argv[2]);
  char job[16];
  strcpy(job, argv[3]);
  int job_count = atoi(argv[4]);
  
  

  exit();
}
