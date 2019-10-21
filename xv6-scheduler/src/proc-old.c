#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
//#include "mmu.h"
#include "x86.h"
#include "pstat.h"
#include "spinlock.h"

// Make the queue that will hold process in MLQ
typedef struct queue {
    int procid[NPROC]; //pid
    int match[NPROC];
    int front;
    int rear;
    int itemCount;
    int timeslice;
}Queue;

// Declare the queue for each level of priority q
Queue priorityQ[4];

void createQueue(Queue *q) 
{ 
	 
    for(int i = 0; i < 4; i++) {
    //   for(int j = 0; j < NPROC; j++)
    //   {  
    //     q[i].procid[j] = 0;
    //     q[i].match[j] = 0;
    //   }
        q[i].front = 0;
        q[i].rear = -1;
        q[i].itemCount = 0;
        switch(i)
        {
          case 0:
            q[i].timeslice = 20;
            break;
          case 1:
            q[i].timeslice = 16;
            break;
          case 2:
            q[i].timeslice = 12;
            break;
          case 3:
            q[i].timeslice = 8;
            break;
          default:
            break;
        }
    }
} 

int peek(Queue *q, int i) {
    return q[i].procid[q[i].front];
}

int accessProc(Queue *q, int i, int n)
{
  return q[i].procid[n];
}

int isEmpty(Queue *q, int i) {
    if(q[i].itemCount == 0) { //is empty
        return 1;
    } else {
        return 0; // not empty
    }
}

int isFull(Queue *q, int i) {
    if(q[i].itemCount == NPROC) { // is full
        return 1;
    } else {
        return 0; //not full
    }
}


int size(Queue *q, int i) {
   return q[i].itemCount;
}  

void insert(Queue *q, int data, int i) { //inserts pid to the rear of the queue
   // // // cprintf("In insert: value of data = %d and rear = %d\n", data, q[i].rear);
   if(!isFull(q, i)) {
	
      if(q[i].rear == NPROC-1) {
         q[i].rear = -1;            
      }       
      q[i].procid[++q[i].rear] = data;
      q[i].itemCount++;
      // q[i].match = 1;
   }
}



void deleteQ(Queue *q, int data, int i) { // data = pid; remove stuff from anywhere in between
    int pos = -1;
    if(!isEmpty(q, i))
    {
        for(int k = 0; k <= q[i].rear; k++)
        {
            if(q[i].procid[k] == data)
            {
                pos = k;
                break;
            }
        }
        if(pos != -1)
        {
            for (int c = pos; c <= q[i].rear -1; c++)
            {
                q[i].procid[c] = q[i].procid[c+1];
                q[i].procid[c+1] = -1;
                
            }
            q[i].rear--;
            q[i].itemCount--;
        }
    } 
}

int dequeue(Queue *q, int i) { //removes stuff from the front of the queue and shifts all other elements
   if (!isEmpty(q, i)) {
        int data = q[i].procid[q[i].front];
	      deleteQ(q, data, i);
        if(q[i].front == NPROC) {
            q[i].front = 0;
        }
        return data;
   }
   return -1;
}

void flushQ(Queue *q) {
  for(int i = 0; i < 4; i++)
  {
    while(q[i].itemCount > 0)
    {
      dequeue(q, i);
    }
    q[i].front = 0;
    q[i].rear = -1;
    q[i].itemCount = 0;
  }
}
// End of queue implementation

// Global pstat struct pointer for our reference
struct pstat *stat;

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

static struct proc *initproc;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  // cprintf("I am in allocproc!\n");

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;

  // Check if the process is initcode or something else
  // if(p->pid != 1)
  //   p->priority = p->parent->priority;
  // else
  //   p->priority = 3;

  // insert(priorityQ, p->pid, p->priority);
  // // cprintf("Inserted in q[%d]: name = %s, pid = %d\n", p->priority, p->name, p->pid);
  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  createQueue(priorityQ);

  // cprintf("I am in userinit1!\n");

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;
  p->priority = 3;
  p->present[p->priority] = 0; // lallu
  insert(priorityQ, p->pid, p->priority);
  p->present[p->priority] = 1;
  // cprintf("Inserted in q[%d]: name = %s, pid = %d\n", p->priority, p->name, p->pid);
  p->ticks[p->priority] = 0;
  p->qtail[p->priority] = 1;
  release(&ptable.lock);
  // cprintf("I am in userinit2!\n");
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  struct proc *curproc = myproc();

  // cprintf("I am in fork!\n");

  return fork2(getpri(curproc->pid));

}

int
fork2(int pri)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // cprintf("I am in fork2-1!\n");

  if(pri < 0 || pri > 3)
  {
    return -1;
  }

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // cprintf("I am in fork2-2!\n");

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // cprintf("I am in fork2-3!\n");

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  // cprintf("I am in fork2-4!\n");

  acquire(&ptable.lock);
  
  np->priority = pri;
  // cprintf("Parent's priority = %d %d\n", np->parent->priority, curproc->priority);
  // cprintf("My priority = %d\n", np->priority);
  np->state = RUNNABLE;

  for(int i = 3; i > -1; i--)
  { 
    // // cprintf("iteration: %d: \n", i);
    np->qtail[i] = 0;
    np->ticks[i] = 0;
  }
  // cprintf("Before insert: Inserted in q[%d]: name = %s, pid = %d\n", np->priority, np->name, np->pid);
    np->present[np->priority] = 0;
    insert(priorityQ, np->pid, np->priority);
    np->present[np->priority] = 1;
    np->qtail[np->priority]++;
  // cprintf("After insert: Inserted in q[%d]: name = %s, pid = %d\n", np->priority, np->name, np->pid);
  // cprintf("I am in fork2-5!\n");
  
  release(&ptable.lock);

  // cprintf("I am in fork2-6!\n");

  return pid;
}

int getpri(int PID)
{
  int flag = -1;
  struct proc *p;

  // cprintf("I am in getpri!\n");
  //acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if(p->pid == PID)
    {
      flag = p->priority;  
    }
  }
  //release(&ptable.lock);
  if(flag != -1)
  {
    return flag;
  }
  return -1;
}

int setpri(int PID, int pri)
{
  struct proc *p;
  int flag = 0;

  // cprintf("I am in setpri!\n");

  if(pri < 0 || pri > 3)
    return -1;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if(p->pid == PID)
    {
      flag = 1;
      // if(p->priority == pri)
      // {
      //   p->qtail[p->priority]++;
      //   cprintf("qtail incremented in setpri()\n");
      // }
      deleteQ(priorityQ, p->pid, p->priority);
      p->present[p->priority] = 0; // lallu
      p->priority = pri;
      p->qtail[p->priority]++;
      p->ticks[p->priority] = 0;
      insert(priorityQ, p->pid, p->priority); 
      p->present[p->priority] = 1;
      // cprintf("Inserted in q[%d]: name = %s, pid = %d\n", p->priority, p->name, p->pid);
    }
  }
  release(&ptable.lock);
  if(flag == 0)
  {
    return -1;
  }
  return 0;
}

int getpinfo(struct pstat *ps)
{
  int ps_no = 0;  // Counter for pstat number
  int timeslice = 0;
  struct proc *p;

  if(ps == 0)
  {
    return -1;
  }

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    ps->pid[ps_no] = p->pid;
    ps->priority[ps_no] = getpri(p->pid);
    ps->state[ps_no] = p->state;
    if(p->state != ZOMBIE && p->state != EMBRYO && p->state != UNUSED)
      ps->inuse[ps_no] = 1;
    else
      ps->inuse[ps_no] = 0;
    for(int i = 0; i < 4; i++)
    {
      switch(i)
      {
        case 0:
          timeslice = 20;
          break;
        case 1:
          timeslice = 16;
          break;
        case 2:
          timeslice = 12;
          break;
        case 3:
          timeslice = 8;
          break;
        default:
          break;
      }
      // int check=isEmpty(priorityQ, p->priority);
      // if(check == 1) // not empty
      if(p->qtail[i] != 0)
      //ps->ticks[ps_no][i] = p->ticks[i] + ((p->qtail[i] - 1)* timeslice);
      ps->ticks[ps_no][i] = (p->qtail[i]-1) * timeslice;
      else
       ps->ticks[ps_no][i] = p->ticks[i];
      ps->qtail[ps_no][i] = p->qtail[i];
    }
    ps_no++;
  }

  release(&ptable.lock);

  // if(ps == 0)
  //   return -1;

  return 0;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
  
  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;

  deleteQ(priorityQ, curproc-> pid, curproc->priority);
  curproc->present[curproc->priority] = 0;
  curproc->ticks[curproc->priority] = 0;

  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        //deleteQ(priorityQ, p-> pid, p->priority);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        // for(int i = 0; i < 4; i++)   
        // {     
        //   p->present[i] = 0;
        //   p->ticks[i] = 0;
        //   p->qtail[i] = 0;
        // }
        // p->priority = -1;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
  struct proc *p;
  int processid;

  //// cprintf("I am in the scheduler!1\n");

  struct cpu *c = mycpu();
  c->proc = 0;
  
  //// cprintf("I got to mycpu()\n");

  for(;;) {
    // Enable interrupts on this processor.
    sti();
    //// cprintf("I am in the scheduler!2\n");

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    // Populate Queues with processes that are RUNNABLE
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
      if(p->state == RUNNABLE) //What about RUNNING?
      {
        if(p->present[p->priority] != 1) // lallu
        {
          insert(priorityQ, p->pid, p->priority);
          p->present[p->priority] = 1; // lallu
          //p->qtail[p->priority]++;
          // cprintf("qtail incremented in scheduler()1\n");
          // cprintf("Inserted in q[%d]: name = %s, pid = %d\n", p->priority, p->name, p->pid);
        } 
        else
        {
          p->qtail[p->priority]++;
        }    
      }
      else //if p->state!=RUNNABLE
      {
        deleteQ(priorityQ, p->pid, p->priority);  
        p->present[p->priority] = 0;
        p->qtail[p->priority] = 0;
      }
    }
    // Choose process to run and Run
    for(int i = 3; i > -1; i--)
    {
      if(isEmpty(priorityQ, i) == 0) //Queue is not empty
      {
        // map pid of proc to procid of queue to set that to run
         for(int j = priorityQ[i].front; j <= priorityQ[i].rear; j++) {
           processid = accessProc(priorityQ, i, j);
           //cprintf("front = %d, rear = %d, processid = %d\n",priorityQ[i].front, priorityQ[i].rear, processid);
          //processid = peek(priorityQ, i);
           //int count = 0;
          for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
          { //cprintf("iteration = %d pname = %s\n", count, p->name);
          if(processid == p->pid && p->state == RUNNABLE) // && priorityQ[i].timeslice > p->ticks[p->priority]) 
          {  
            if(priorityQ[i].timeslice > p->ticks[p->priority])
            {
              // Switch to chosen process.  It is the process's job
              // to release ptable.lock and then reacquire it
              // before jumping back to us.
              //if (p->state != RUNNABLE) continue;
              // cprintf("I am running in the scheduler!\n");
              // cprintf("My priority = %d, timeslice = %d, ticks = %d, name = %s pid = %d qtail = %d\n", p->priority, priorityQ[i].timeslice, p->ticks[p->priority], p->name, p->pid, p->qtail[p->priority]);

              c->proc = p;
              switchuvm(p);
              p->state = RUNNING;
      
              //Make sure the process runs for the timeslice according to the priority level.

              swtch(&(c->scheduler), p->context);
              switchkvm();

              // Process is done running for now.
              // It should have changed its p->state before coming back.
              c->proc = 0;
              if(p->state != RUNNABLE)
              {
                deleteQ(priorityQ, p->pid, p->priority);  
                p->present[p->priority] = 0;
                p->ticks[p->priority] = 0;
              }
              p->ticks[p->priority] = p->ticks[p->priority] + 1;
              //count++;
              // cprintf("I am done running!\n");
              break;                                            
            }
            else if((priorityQ[i].timeslice) <= (p->ticks[p->priority]))
            {
              //insert(priorityQ, dequeue(priorityQ, i), p->priority);
              deleteQ(priorityQ, p->pid, p->priority);	
              p->ticks[p->priority] = 0;
              //p->qtail[p->priority]++;
              // cprintf("qtail incremented in scheduler()2\n");
              insert(priorityQ, p->pid, p->priority);
              p->present[p->priority] = 1; //lallu
              // cprintf("I have dequeued!\n");
              //count++;
              break;
            }
          }
          else if(processid == p->pid && p->state != RUNNABLE)
          {
            deleteQ(priorityQ, p-> pid, p->priority);
            p->present[p->priority] = 0; //lallu
            p->ticks[p->priority] = 0;
            insert(priorityQ, p->pid, p->priority);
              p->present[p->priority] = 1;
            // Do we delete it from the queue?
            // What about processes that are sleeping? How will they get added back to the queue?
            // Where do we update the queue?
            //continue;
          }
          else
          {
            continue;
          }
        } 
      }
      }
    }

    // Flush entire Queue  
    //flushQ(priorityQ);
    //// cprintf("I have flushed sucessfully!\n");
    release(&ptable.lock);
    //// cprintf("I am done in the scheduler!3\n");
  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();
  //// cprintf("I am in sched!\n");
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  //cprintf("I am in yeild!\n");
  myproc()->state = RUNNABLE;
  // insert(priorityQ, myproc()->pid, myproc()->priority);
  // myproc()->present[myproc()->priority] = 1; // lallu
  // myproc()->qtail[myproc()->priority]++;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;
  //if(p->present[p->priority] != 0)
  //{
  // deleteQ(priorityQ, p-> pid, p->priority);
  // p->present[p->priority] = 0;
  //}
  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if(p->state == SLEEPING && p->chan == chan)
    {
      p->state = RUNNABLE;
      //if(p->present[p->priority] != 1) // lallu
      //{
      //p->present[p->priority] = 0;
         deleteQ(priorityQ, p->pid, p->priority);
         p->ticks[p->priority] = 0;
         insert(priorityQ, p->pid, p->priority);
         p->present[p->priority] = 1; // lallu
         p->qtail[p->priority]++;
      //   // cprintf("Inserted in q[%d]: name = %s, pid = %d\n", p->priority, p->name, p->pid);
       //}
    }
  }  
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
      {
        p->state = RUNNABLE;
        // insert(priorityQ, p->pid, p->priority);
        // p->present[p->priority] = 1; // lallu
        // p->qtail[p->priority]++;
      }
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}