#include "types.h"
#include "user.h"
#include "syscall.h"
#include "pstat.h"

int
main(int argc, char *argv[])
{
  int user_timeslice, iterations, job_count;
  char *job[64];

  if(argc > 5 || argc < 5 ){
    printf(2, "Usage:  userRR <user-level-timeslice> <iterations> <job> <jobcount>\n");
    exit();
  }
  
  // Initialize the values from cmd line args
  user_timeslice = atoi(argv[1]);
  iterations = atoi(argv[2]);
  job_count = atoi(argv[4]);

   for(int i = 0; i < job_count; i++)
    {
      strcpy(job[i], argv[3]);
    }
    
    struct proc *np[64];
    // struct proc *curproc = myproc();
    
    for(int i = 0; i < 64; i++) {
      np[i] = 0;
    }
    // setpri(curproc->pid, 3);
    setpri(getpid(), 3);
    for(int i = 0; i < job_count; i++)
    {
      np[i]->pid = fork2(0);
      if(np[i]->pid < 0) {
        printf(2, "Could not fork!\n");
        exit();
      }
      if(exec(job[0], job) < 0)
        {
          printf(2, "Exec failed!\n");
        }
        exit();
    }

    for(int i = 0; i < iterations; i++)
    {
      for(int j = 0; j < job_count; j++)
      {
        setpri(np[j]->pid, 2);
        sleep(user_timeslice);
        setpri(np[j]->pid, 0);
      }
    }

    for(int i = 0; i < job_count; i++)
    {
      kill(np[i]->pid);
    }
  
  exit();
}
