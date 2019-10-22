#include "types.h"
#include "user.h"
#include "syscall.h"
#include "pstat.h"

int
main(int argc, char *argv[])
{
  int user_timeslice, job_count; //, iterations;
  char *job[64];
  struct pstat ps;
  
  if(argc > 5 || argc < 5 ){
    printf(2, "Usage:  userRR <user-level-timeslice> <iterations> <job> <jobcount>\n");
    exit();
  }
  
  // Initialize the values from cmd line args
  user_timeslice = atoi(argv[1]);
  // iterations = atoi(argv[2]);
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
    setpri(getpid(), 3);

    for(int i = 0; i < job_count ; i++)
    {
      np[i]->pid = fork2(0);
      printf(1, "np[%d]->pid = %d\n", i, np[i]->pid);
      if(np[i]->pid < 0) {
        printf(2, "Could not fork!\n");
        exit();
      }
      if(np[i]->pid == 0)
      {
        if(exec(job[0], job) < 0)
        {
          printf(2, "Exec failed!\n");
        }
        exit();
      }
      else
      {
        //sleep(user_timeslice);
        wait();
      }
    }

    // for(int i = 0; i < iterations; i++)
    // {
    //   for(int j = 0; j < job_count; j++)
    //   {
    //      setpri(np[j]->pid, 2);
    //      sleep(user_timeslice);
    //      setpri(np[j]->pid, 0);
    //      printf(1, "jobcount = %d %d\n", j, job_count);
    //   }
    // }

    for(int i = 0; i < user_timeslice; i++)
    {
      wait();
    }
    getpinfo(&ps);
    for(int i = 0; i < job_count + 3; i++)
    {
      //printf(1, "Inuse: %d\n", ps.inuse[i]);
      printf(1, "Pid: %d\n", ps.pid[i]);
      
      //printf(1, "State: %d\n", ps.state[i]);
      for(int j = 0; j < 4; j++)
      {
        printf(1, "Priority: %d\n", j); // ps.priority[j]);
        printf(1, "Ticks: %d\n", ps.ticks[i][j]);
        printf(1, "Qtail: %d\n", ps.qtail[i][j]);
      }    
    }
  
  exit();
}
