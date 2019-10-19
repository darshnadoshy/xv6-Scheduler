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
  int user_timeslice = atoi(argv[1]);
  int iterations = atoi(argv[2]);
  

  exit();
}
