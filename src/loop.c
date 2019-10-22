#include "types.h"
#include "user.h"
#include "syscall.h"


int
main(int argc, char *argv[])
{
  // for(int i = 0; i < 10; i++)
  // {
  //   sleep(10);
  // }
  sleep(10);
  printf(1,"%d\n", getpid());
  exit();
}