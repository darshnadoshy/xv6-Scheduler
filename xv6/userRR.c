#include "types.h"
#include "user.h"
#include "syscall.h"


int
main(int argc, char *argv[])
{
  int user_timeslice, iterations, job_count;
  char job[100];

  if(argc > 5 || argc < 5 ){
    printf(2, "Usage:  userRR <user-level-timeslice> <iterations> <job> <jobcount>\n");
    exit();
  }
  
  // Initialize the values from cmd line args
  user_timeslice = atoi(argv[1]);
  iterations = atoi(argv[2]);
  strcpy(job, argv[3]);
  job_count = atoi(argv[4]);
  
  

  exit();
}
