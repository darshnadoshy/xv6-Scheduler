
_userRR:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "syscall.h"
#include "pstat.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec 18 02 00 00    	sub    $0x218,%esp
  17:	8b 79 04             	mov    0x4(%ecx),%edi
  int user_timeslice, job_count; //, iterations;
  char *job[64];
  //struct pstat ps;
  
  if(argc > 5 || argc < 5 ){
  1a:	83 39 05             	cmpl   $0x5,(%ecx)
  1d:	74 14                	je     33 <main+0x33>
    printf(2, "Usage:  userRR <user-level-timeslice> <iterations> <job> <jobcount>\n");
  1f:	83 ec 08             	sub    $0x8,%esp
  22:	68 dc 06 00 00       	push   $0x6dc
  27:	6a 02                	push   $0x2
  29:	e8 f4 03 00 00       	call   422 <printf>
    exit();
  2e:	e8 95 02 00 00       	call   2c8 <exit>
  }
  
  // Initialize the values from cmd line args
  user_timeslice = atoi(argv[1]);
  33:	83 ec 0c             	sub    $0xc,%esp
  36:	ff 77 04             	pushl  0x4(%edi)
  39:	e8 2c 02 00 00       	call   26a <atoi>
  3e:	89 85 e4 fd ff ff    	mov    %eax,-0x21c(%ebp)
  // iterations = atoi(argv[2]);
  job_count = atoi(argv[4]);
  44:	83 c4 04             	add    $0x4,%esp
  47:	ff 77 10             	pushl  0x10(%edi)
  4a:	e8 1b 02 00 00       	call   26a <atoi>
  4f:	89 c6                	mov    %eax,%esi

   for(int i = 0; i < job_count; i++)
  51:	83 c4 10             	add    $0x10,%esp
  54:	bb 00 00 00 00       	mov    $0x0,%ebx
  59:	eb 18                	jmp    73 <main+0x73>
    {
      strcpy(job[i], argv[3]);
  5b:	83 ec 08             	sub    $0x8,%esp
  5e:	ff 77 0c             	pushl  0xc(%edi)
  61:	ff b4 9d e8 fe ff ff 	pushl  -0x118(%ebp,%ebx,4)
  68:	e8 ce 00 00 00       	call   13b <strcpy>
   for(int i = 0; i < job_count; i++)
  6d:	83 c3 01             	add    $0x1,%ebx
  70:	83 c4 10             	add    $0x10,%esp
  73:	39 f3                	cmp    %esi,%ebx
  75:	7c e4                	jl     5b <main+0x5b>
    }
    
    struct proc *np[64];
    // struct proc *curproc = myproc();
    
    for(int i = 0; i < 64; i++) {
  77:	b8 00 00 00 00       	mov    $0x0,%eax
  7c:	eb 0e                	jmp    8c <main+0x8c>
      np[i] = 0;
  7e:	c7 84 85 e8 fd ff ff 	movl   $0x0,-0x218(%ebp,%eax,4)
  85:	00 00 00 00 
    for(int i = 0; i < 64; i++) {
  89:	83 c0 01             	add    $0x1,%eax
  8c:	83 f8 3f             	cmp    $0x3f,%eax
  8f:	7e ed                	jle    7e <main+0x7e>
    }
    setpri(getpid(), 3);
  91:	e8 b2 02 00 00       	call   348 <getpid>
  96:	83 ec 08             	sub    $0x8,%esp
  99:	6a 03                	push   $0x3
  9b:	50                   	push   %eax
  9c:	e8 d7 02 00 00       	call   378 <setpri>

    for(int i = 0; i < job_count ; i++)
  a1:	83 c4 10             	add    $0x10,%esp
  a4:	bb 00 00 00 00       	mov    $0x0,%ebx
  a9:	eb 30                	jmp    db <main+0xdb>
    {
      np[i]->pid = fork2(0);
      //printf(1, "np[%d]->pid = %d\n", i, np[i]->pid);
      if(np[i]->pid < 0) {
        printf(2, "Could not fork!\n");
  ab:	83 ec 08             	sub    $0x8,%esp
  ae:	68 24 07 00 00       	push   $0x724
  b3:	6a 02                	push   $0x2
  b5:	e8 68 03 00 00       	call   422 <printf>
        exit();
  ba:	e8 09 02 00 00       	call   2c8 <exit>
      }
      if(np[i]->pid == 0)
      {
        if(exec(job[0], job) < 0)
        {
          printf(2, "Exec failed!\n");
  bf:	83 ec 08             	sub    $0x8,%esp
  c2:	68 35 07 00 00       	push   $0x735
  c7:	6a 02                	push   $0x2
  c9:	e8 54 03 00 00       	call   422 <printf>
  ce:	83 c4 10             	add    $0x10,%esp
  d1:	eb 47                	jmp    11a <main+0x11a>
        exit();
      }
      else
      {
        //sleep(user_timeslice);
        wait();
  d3:	e8 f8 01 00 00       	call   2d0 <wait>
    for(int i = 0; i < job_count ; i++)
  d8:	83 c3 01             	add    $0x1,%ebx
  db:	39 f3                	cmp    %esi,%ebx
  dd:	7d 40                	jge    11f <main+0x11f>
      np[i]->pid = fork2(0);
  df:	8b bc 9d e8 fd ff ff 	mov    -0x218(%ebp,%ebx,4),%edi
  e6:	83 ec 0c             	sub    $0xc,%esp
  e9:	6a 00                	push   $0x0
  eb:	e8 78 02 00 00       	call   368 <fork2>
  f0:	89 47 10             	mov    %eax,0x10(%edi)
      if(np[i]->pid < 0) {
  f3:	83 c4 10             	add    $0x10,%esp
  f6:	85 c0                	test   %eax,%eax
  f8:	78 b1                	js     ab <main+0xab>
      if(np[i]->pid == 0)
  fa:	85 c0                	test   %eax,%eax
  fc:	75 d5                	jne    d3 <main+0xd3>
        if(exec(job[0], job) < 0)
  fe:	83 ec 08             	sub    $0x8,%esp
 101:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
 107:	50                   	push   %eax
 108:	ff b5 e8 fe ff ff    	pushl  -0x118(%ebp)
 10e:	e8 ed 01 00 00       	call   300 <exec>
 113:	83 c4 10             	add    $0x10,%esp
 116:	85 c0                	test   %eax,%eax
 118:	78 a5                	js     bf <main+0xbf>
        exit();
 11a:	e8 a9 01 00 00       	call   2c8 <exit>
    //      setpri(np[j]->pid, 0);
    //      printf(1, "jobcount = %d %d\n", j, job_count);
    //   }
    // }

    for(int i = 0; i < user_timeslice; i++)
 11f:	bb 00 00 00 00       	mov    $0x0,%ebx
 124:	eb 08                	jmp    12e <main+0x12e>
    {
      wait();
 126:	e8 a5 01 00 00       	call   2d0 <wait>
    for(int i = 0; i < user_timeslice; i++)
 12b:	83 c3 01             	add    $0x1,%ebx
 12e:	3b 9d e4 fd ff ff    	cmp    -0x21c(%ebp),%ebx
 134:	7c f0                	jl     126 <main+0x126>
    //     printf(1, "Ticks: %d\n", ps.ticks[i][j]);
    //     printf(1, "Qtail: %d\n", ps.qtail[i][j]);
    //   }    
    // }
  
  exit();
 136:	e8 8d 01 00 00       	call   2c8 <exit>

0000013b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 13b:	55                   	push   %ebp
 13c:	89 e5                	mov    %esp,%ebp
 13e:	53                   	push   %ebx
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 145:	89 c2                	mov    %eax,%edx
 147:	0f b6 19             	movzbl (%ecx),%ebx
 14a:	88 1a                	mov    %bl,(%edx)
 14c:	8d 52 01             	lea    0x1(%edx),%edx
 14f:	8d 49 01             	lea    0x1(%ecx),%ecx
 152:	84 db                	test   %bl,%bl
 154:	75 f1                	jne    147 <strcpy+0xc>
    ;
  return os;
}
 156:	5b                   	pop    %ebx
 157:	5d                   	pop    %ebp
 158:	c3                   	ret    

00000159 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 159:	55                   	push   %ebp
 15a:	89 e5                	mov    %esp,%ebp
 15c:	8b 4d 08             	mov    0x8(%ebp),%ecx
 15f:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 162:	eb 06                	jmp    16a <strcmp+0x11>
    p++, q++;
 164:	83 c1 01             	add    $0x1,%ecx
 167:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 16a:	0f b6 01             	movzbl (%ecx),%eax
 16d:	84 c0                	test   %al,%al
 16f:	74 04                	je     175 <strcmp+0x1c>
 171:	3a 02                	cmp    (%edx),%al
 173:	74 ef                	je     164 <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 175:	0f b6 c0             	movzbl %al,%eax
 178:	0f b6 12             	movzbl (%edx),%edx
 17b:	29 d0                	sub    %edx,%eax
}
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret    

0000017f <strlen>:

uint
strlen(const char *s)
{
 17f:	55                   	push   %ebp
 180:	89 e5                	mov    %esp,%ebp
 182:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 185:	ba 00 00 00 00       	mov    $0x0,%edx
 18a:	eb 03                	jmp    18f <strlen+0x10>
 18c:	83 c2 01             	add    $0x1,%edx
 18f:	89 d0                	mov    %edx,%eax
 191:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 195:	75 f5                	jne    18c <strlen+0xd>
    ;
  return n;
}
 197:	5d                   	pop    %ebp
 198:	c3                   	ret    

00000199 <memset>:

void*
memset(void *dst, int c, uint n)
{
 199:	55                   	push   %ebp
 19a:	89 e5                	mov    %esp,%ebp
 19c:	57                   	push   %edi
 19d:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a0:	89 d7                	mov    %edx,%edi
 1a2:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a8:	fc                   	cld    
 1a9:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1ab:	89 d0                	mov    %edx,%eax
 1ad:	5f                   	pop    %edi
 1ae:	5d                   	pop    %ebp
 1af:	c3                   	ret    

000001b0 <strchr>:

char*
strchr(const char *s, char c)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ba:	0f b6 10             	movzbl (%eax),%edx
 1bd:	84 d2                	test   %dl,%dl
 1bf:	74 09                	je     1ca <strchr+0x1a>
    if(*s == c)
 1c1:	38 ca                	cmp    %cl,%dl
 1c3:	74 0a                	je     1cf <strchr+0x1f>
  for(; *s; s++)
 1c5:	83 c0 01             	add    $0x1,%eax
 1c8:	eb f0                	jmp    1ba <strchr+0xa>
      return (char*)s;
  return 0;
 1ca:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1cf:	5d                   	pop    %ebp
 1d0:	c3                   	ret    

000001d1 <gets>:

char*
gets(char *buf, int max)
{
 1d1:	55                   	push   %ebp
 1d2:	89 e5                	mov    %esp,%ebp
 1d4:	57                   	push   %edi
 1d5:	56                   	push   %esi
 1d6:	53                   	push   %ebx
 1d7:	83 ec 1c             	sub    $0x1c,%esp
 1da:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1dd:	bb 00 00 00 00       	mov    $0x0,%ebx
 1e2:	8d 73 01             	lea    0x1(%ebx),%esi
 1e5:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1e8:	7d 2e                	jge    218 <gets+0x47>
    cc = read(0, &c, 1);
 1ea:	83 ec 04             	sub    $0x4,%esp
 1ed:	6a 01                	push   $0x1
 1ef:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1f2:	50                   	push   %eax
 1f3:	6a 00                	push   $0x0
 1f5:	e8 e6 00 00 00       	call   2e0 <read>
    if(cc < 1)
 1fa:	83 c4 10             	add    $0x10,%esp
 1fd:	85 c0                	test   %eax,%eax
 1ff:	7e 17                	jle    218 <gets+0x47>
      break;
    buf[i++] = c;
 201:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 205:	88 04 1f             	mov    %al,(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 208:	3c 0a                	cmp    $0xa,%al
 20a:	0f 94 c2             	sete   %dl
 20d:	3c 0d                	cmp    $0xd,%al
 20f:	0f 94 c0             	sete   %al
    buf[i++] = c;
 212:	89 f3                	mov    %esi,%ebx
    if(c == '\n' || c == '\r')
 214:	08 c2                	or     %al,%dl
 216:	74 ca                	je     1e2 <gets+0x11>
      break;
  }
  buf[i] = '\0';
 218:	c6 04 1f 00          	movb   $0x0,(%edi,%ebx,1)
  return buf;
}
 21c:	89 f8                	mov    %edi,%eax
 21e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 221:	5b                   	pop    %ebx
 222:	5e                   	pop    %esi
 223:	5f                   	pop    %edi
 224:	5d                   	pop    %ebp
 225:	c3                   	ret    

00000226 <stat>:

int
stat(const char *n, struct stat *st)
{
 226:	55                   	push   %ebp
 227:	89 e5                	mov    %esp,%ebp
 229:	56                   	push   %esi
 22a:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 22b:	83 ec 08             	sub    $0x8,%esp
 22e:	6a 00                	push   $0x0
 230:	ff 75 08             	pushl  0x8(%ebp)
 233:	e8 d0 00 00 00       	call   308 <open>
  if(fd < 0)
 238:	83 c4 10             	add    $0x10,%esp
 23b:	85 c0                	test   %eax,%eax
 23d:	78 24                	js     263 <stat+0x3d>
 23f:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 241:	83 ec 08             	sub    $0x8,%esp
 244:	ff 75 0c             	pushl  0xc(%ebp)
 247:	50                   	push   %eax
 248:	e8 d3 00 00 00       	call   320 <fstat>
 24d:	89 c6                	mov    %eax,%esi
  close(fd);
 24f:	89 1c 24             	mov    %ebx,(%esp)
 252:	e8 99 00 00 00       	call   2f0 <close>
  return r;
 257:	83 c4 10             	add    $0x10,%esp
}
 25a:	89 f0                	mov    %esi,%eax
 25c:	8d 65 f8             	lea    -0x8(%ebp),%esp
 25f:	5b                   	pop    %ebx
 260:	5e                   	pop    %esi
 261:	5d                   	pop    %ebp
 262:	c3                   	ret    
    return -1;
 263:	be ff ff ff ff       	mov    $0xffffffff,%esi
 268:	eb f0                	jmp    25a <stat+0x34>

0000026a <atoi>:

int
atoi(const char *s)
{
 26a:	55                   	push   %ebp
 26b:	89 e5                	mov    %esp,%ebp
 26d:	53                   	push   %ebx
 26e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 271:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 276:	eb 10                	jmp    288 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 278:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
 27b:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
 27e:	83 c1 01             	add    $0x1,%ecx
 281:	0f be d2             	movsbl %dl,%edx
 284:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  while('0' <= *s && *s <= '9')
 288:	0f b6 11             	movzbl (%ecx),%edx
 28b:	8d 5a d0             	lea    -0x30(%edx),%ebx
 28e:	80 fb 09             	cmp    $0x9,%bl
 291:	76 e5                	jbe    278 <atoi+0xe>
  return n;
}
 293:	5b                   	pop    %ebx
 294:	5d                   	pop    %ebp
 295:	c3                   	ret    

00000296 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 296:	55                   	push   %ebp
 297:	89 e5                	mov    %esp,%ebp
 299:	56                   	push   %esi
 29a:	53                   	push   %ebx
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2a1:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 2a4:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 2a6:	eb 0d                	jmp    2b5 <memmove+0x1f>
    *dst++ = *src++;
 2a8:	0f b6 13             	movzbl (%ebx),%edx
 2ab:	88 11                	mov    %dl,(%ecx)
 2ad:	8d 5b 01             	lea    0x1(%ebx),%ebx
 2b0:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 2b3:	89 f2                	mov    %esi,%edx
 2b5:	8d 72 ff             	lea    -0x1(%edx),%esi
 2b8:	85 d2                	test   %edx,%edx
 2ba:	7f ec                	jg     2a8 <memmove+0x12>
  return vdst;
}
 2bc:	5b                   	pop    %ebx
 2bd:	5e                   	pop    %esi
 2be:	5d                   	pop    %ebp
 2bf:	c3                   	ret    

000002c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c0:	b8 01 00 00 00       	mov    $0x1,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <exit>:
SYSCALL(exit)
 2c8:	b8 02 00 00 00       	mov    $0x2,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <wait>:
SYSCALL(wait)
 2d0:	b8 03 00 00 00       	mov    $0x3,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <pipe>:
SYSCALL(pipe)
 2d8:	b8 04 00 00 00       	mov    $0x4,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <read>:
SYSCALL(read)
 2e0:	b8 05 00 00 00       	mov    $0x5,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <write>:
SYSCALL(write)
 2e8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <close>:
SYSCALL(close)
 2f0:	b8 15 00 00 00       	mov    $0x15,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <kill>:
SYSCALL(kill)
 2f8:	b8 06 00 00 00       	mov    $0x6,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <exec>:
SYSCALL(exec)
 300:	b8 07 00 00 00       	mov    $0x7,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <open>:
SYSCALL(open)
 308:	b8 0f 00 00 00       	mov    $0xf,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <mknod>:
SYSCALL(mknod)
 310:	b8 11 00 00 00       	mov    $0x11,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <unlink>:
SYSCALL(unlink)
 318:	b8 12 00 00 00       	mov    $0x12,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <fstat>:
SYSCALL(fstat)
 320:	b8 08 00 00 00       	mov    $0x8,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <link>:
SYSCALL(link)
 328:	b8 13 00 00 00       	mov    $0x13,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <mkdir>:
SYSCALL(mkdir)
 330:	b8 14 00 00 00       	mov    $0x14,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <chdir>:
SYSCALL(chdir)
 338:	b8 09 00 00 00       	mov    $0x9,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <dup>:
SYSCALL(dup)
 340:	b8 0a 00 00 00       	mov    $0xa,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <getpid>:
SYSCALL(getpid)
 348:	b8 0b 00 00 00       	mov    $0xb,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <sbrk>:
SYSCALL(sbrk)
 350:	b8 0c 00 00 00       	mov    $0xc,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <sleep>:
SYSCALL(sleep)
 358:	b8 0d 00 00 00       	mov    $0xd,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <uptime>:
SYSCALL(uptime)
 360:	b8 0e 00 00 00       	mov    $0xe,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <fork2>:
SYSCALL(fork2)
 368:	b8 18 00 00 00       	mov    $0x18,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <getpri>:
SYSCALL(getpri)
 370:	b8 17 00 00 00       	mov    $0x17,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <setpri>:
SYSCALL(setpri)
 378:	b8 16 00 00 00       	mov    $0x16,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <getpinfo>:
SYSCALL(getpinfo)
 380:	b8 19 00 00 00       	mov    $0x19,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 388:	55                   	push   %ebp
 389:	89 e5                	mov    %esp,%ebp
 38b:	83 ec 1c             	sub    $0x1c,%esp
 38e:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 391:	6a 01                	push   $0x1
 393:	8d 55 f4             	lea    -0xc(%ebp),%edx
 396:	52                   	push   %edx
 397:	50                   	push   %eax
 398:	e8 4b ff ff ff       	call   2e8 <write>
}
 39d:	83 c4 10             	add    $0x10,%esp
 3a0:	c9                   	leave  
 3a1:	c3                   	ret    

000003a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3a2:	55                   	push   %ebp
 3a3:	89 e5                	mov    %esp,%ebp
 3a5:	57                   	push   %edi
 3a6:	56                   	push   %esi
 3a7:	53                   	push   %ebx
 3a8:	83 ec 2c             	sub    $0x2c,%esp
 3ab:	89 c7                	mov    %eax,%edi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 3b1:	0f 95 c3             	setne  %bl
 3b4:	89 d0                	mov    %edx,%eax
 3b6:	c1 e8 1f             	shr    $0x1f,%eax
 3b9:	84 c3                	test   %al,%bl
 3bb:	74 10                	je     3cd <printint+0x2b>
    neg = 1;
    x = -xx;
 3bd:	f7 da                	neg    %edx
    neg = 1;
 3bf:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3c6:	be 00 00 00 00       	mov    $0x0,%esi
 3cb:	eb 0b                	jmp    3d8 <printint+0x36>
  neg = 0;
 3cd:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 3d4:	eb f0                	jmp    3c6 <printint+0x24>
  do{
    buf[i++] = digits[x % base];
 3d6:	89 c6                	mov    %eax,%esi
 3d8:	89 d0                	mov    %edx,%eax
 3da:	ba 00 00 00 00       	mov    $0x0,%edx
 3df:	f7 f1                	div    %ecx
 3e1:	89 c3                	mov    %eax,%ebx
 3e3:	8d 46 01             	lea    0x1(%esi),%eax
 3e6:	0f b6 92 4c 07 00 00 	movzbl 0x74c(%edx),%edx
 3ed:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
  }while((x /= base) != 0);
 3f1:	89 da                	mov    %ebx,%edx
 3f3:	85 db                	test   %ebx,%ebx
 3f5:	75 df                	jne    3d6 <printint+0x34>
 3f7:	89 c3                	mov    %eax,%ebx
  if(neg)
 3f9:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 3fd:	74 16                	je     415 <printint+0x73>
    buf[i++] = '-';
 3ff:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 404:	8d 5e 02             	lea    0x2(%esi),%ebx
 407:	eb 0c                	jmp    415 <printint+0x73>

  while(--i >= 0)
    putc(fd, buf[i]);
 409:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 40e:	89 f8                	mov    %edi,%eax
 410:	e8 73 ff ff ff       	call   388 <putc>
  while(--i >= 0)
 415:	83 eb 01             	sub    $0x1,%ebx
 418:	79 ef                	jns    409 <printint+0x67>
}
 41a:	83 c4 2c             	add    $0x2c,%esp
 41d:	5b                   	pop    %ebx
 41e:	5e                   	pop    %esi
 41f:	5f                   	pop    %edi
 420:	5d                   	pop    %ebp
 421:	c3                   	ret    

00000422 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 422:	55                   	push   %ebp
 423:	89 e5                	mov    %esp,%ebp
 425:	57                   	push   %edi
 426:	56                   	push   %esi
 427:	53                   	push   %ebx
 428:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 42b:	8d 45 10             	lea    0x10(%ebp),%eax
 42e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 431:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 436:	bb 00 00 00 00       	mov    $0x0,%ebx
 43b:	eb 14                	jmp    451 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 43d:	89 fa                	mov    %edi,%edx
 43f:	8b 45 08             	mov    0x8(%ebp),%eax
 442:	e8 41 ff ff ff       	call   388 <putc>
 447:	eb 05                	jmp    44e <printf+0x2c>
      }
    } else if(state == '%'){
 449:	83 fe 25             	cmp    $0x25,%esi
 44c:	74 25                	je     473 <printf+0x51>
  for(i = 0; fmt[i]; i++){
 44e:	83 c3 01             	add    $0x1,%ebx
 451:	8b 45 0c             	mov    0xc(%ebp),%eax
 454:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 458:	84 c0                	test   %al,%al
 45a:	0f 84 23 01 00 00    	je     583 <printf+0x161>
    c = fmt[i] & 0xff;
 460:	0f be f8             	movsbl %al,%edi
 463:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 466:	85 f6                	test   %esi,%esi
 468:	75 df                	jne    449 <printf+0x27>
      if(c == '%'){
 46a:	83 f8 25             	cmp    $0x25,%eax
 46d:	75 ce                	jne    43d <printf+0x1b>
        state = '%';
 46f:	89 c6                	mov    %eax,%esi
 471:	eb db                	jmp    44e <printf+0x2c>
      if(c == 'd'){
 473:	83 f8 64             	cmp    $0x64,%eax
 476:	74 49                	je     4c1 <printf+0x9f>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 478:	83 f8 78             	cmp    $0x78,%eax
 47b:	0f 94 c1             	sete   %cl
 47e:	83 f8 70             	cmp    $0x70,%eax
 481:	0f 94 c2             	sete   %dl
 484:	08 d1                	or     %dl,%cl
 486:	75 63                	jne    4eb <printf+0xc9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 488:	83 f8 73             	cmp    $0x73,%eax
 48b:	0f 84 84 00 00 00    	je     515 <printf+0xf3>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 491:	83 f8 63             	cmp    $0x63,%eax
 494:	0f 84 b7 00 00 00    	je     551 <printf+0x12f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 49a:	83 f8 25             	cmp    $0x25,%eax
 49d:	0f 84 cc 00 00 00    	je     56f <printf+0x14d>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4a3:	ba 25 00 00 00       	mov    $0x25,%edx
 4a8:	8b 45 08             	mov    0x8(%ebp),%eax
 4ab:	e8 d8 fe ff ff       	call   388 <putc>
        putc(fd, c);
 4b0:	89 fa                	mov    %edi,%edx
 4b2:	8b 45 08             	mov    0x8(%ebp),%eax
 4b5:	e8 ce fe ff ff       	call   388 <putc>
      }
      state = 0;
 4ba:	be 00 00 00 00       	mov    $0x0,%esi
 4bf:	eb 8d                	jmp    44e <printf+0x2c>
        printint(fd, *ap, 10, 1);
 4c1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4c4:	8b 17                	mov    (%edi),%edx
 4c6:	83 ec 0c             	sub    $0xc,%esp
 4c9:	6a 01                	push   $0x1
 4cb:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4d0:	8b 45 08             	mov    0x8(%ebp),%eax
 4d3:	e8 ca fe ff ff       	call   3a2 <printint>
        ap++;
 4d8:	83 c7 04             	add    $0x4,%edi
 4db:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 4de:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4e1:	be 00 00 00 00       	mov    $0x0,%esi
 4e6:	e9 63 ff ff ff       	jmp    44e <printf+0x2c>
        printint(fd, *ap, 16, 0);
 4eb:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 4ee:	8b 17                	mov    (%edi),%edx
 4f0:	83 ec 0c             	sub    $0xc,%esp
 4f3:	6a 00                	push   $0x0
 4f5:	b9 10 00 00 00       	mov    $0x10,%ecx
 4fa:	8b 45 08             	mov    0x8(%ebp),%eax
 4fd:	e8 a0 fe ff ff       	call   3a2 <printint>
        ap++;
 502:	83 c7 04             	add    $0x4,%edi
 505:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 508:	83 c4 10             	add    $0x10,%esp
      state = 0;
 50b:	be 00 00 00 00       	mov    $0x0,%esi
 510:	e9 39 ff ff ff       	jmp    44e <printf+0x2c>
        s = (char*)*ap;
 515:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 518:	8b 30                	mov    (%eax),%esi
        ap++;
 51a:	83 c0 04             	add    $0x4,%eax
 51d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 520:	85 f6                	test   %esi,%esi
 522:	75 28                	jne    54c <printf+0x12a>
          s = "(null)";
 524:	be 43 07 00 00       	mov    $0x743,%esi
 529:	8b 7d 08             	mov    0x8(%ebp),%edi
 52c:	eb 0d                	jmp    53b <printf+0x119>
          putc(fd, *s);
 52e:	0f be d2             	movsbl %dl,%edx
 531:	89 f8                	mov    %edi,%eax
 533:	e8 50 fe ff ff       	call   388 <putc>
          s++;
 538:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 53b:	0f b6 16             	movzbl (%esi),%edx
 53e:	84 d2                	test   %dl,%dl
 540:	75 ec                	jne    52e <printf+0x10c>
      state = 0;
 542:	be 00 00 00 00       	mov    $0x0,%esi
 547:	e9 02 ff ff ff       	jmp    44e <printf+0x2c>
 54c:	8b 7d 08             	mov    0x8(%ebp),%edi
 54f:	eb ea                	jmp    53b <printf+0x119>
        putc(fd, *ap);
 551:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 554:	0f be 17             	movsbl (%edi),%edx
 557:	8b 45 08             	mov    0x8(%ebp),%eax
 55a:	e8 29 fe ff ff       	call   388 <putc>
        ap++;
 55f:	83 c7 04             	add    $0x4,%edi
 562:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 565:	be 00 00 00 00       	mov    $0x0,%esi
 56a:	e9 df fe ff ff       	jmp    44e <printf+0x2c>
        putc(fd, c);
 56f:	89 fa                	mov    %edi,%edx
 571:	8b 45 08             	mov    0x8(%ebp),%eax
 574:	e8 0f fe ff ff       	call   388 <putc>
      state = 0;
 579:	be 00 00 00 00       	mov    $0x0,%esi
 57e:	e9 cb fe ff ff       	jmp    44e <printf+0x2c>
    }
  }
}
 583:	8d 65 f4             	lea    -0xc(%ebp),%esp
 586:	5b                   	pop    %ebx
 587:	5e                   	pop    %esi
 588:	5f                   	pop    %edi
 589:	5d                   	pop    %ebp
 58a:	c3                   	ret    

0000058b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 58b:	55                   	push   %ebp
 58c:	89 e5                	mov    %esp,%ebp
 58e:	57                   	push   %edi
 58f:	56                   	push   %esi
 590:	53                   	push   %ebx
 591:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 594:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 597:	a1 f0 09 00 00       	mov    0x9f0,%eax
 59c:	eb 02                	jmp    5a0 <free+0x15>
 59e:	89 d0                	mov    %edx,%eax
 5a0:	39 c8                	cmp    %ecx,%eax
 5a2:	73 04                	jae    5a8 <free+0x1d>
 5a4:	39 08                	cmp    %ecx,(%eax)
 5a6:	77 12                	ja     5ba <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a8:	8b 10                	mov    (%eax),%edx
 5aa:	39 c2                	cmp    %eax,%edx
 5ac:	77 f0                	ja     59e <free+0x13>
 5ae:	39 c8                	cmp    %ecx,%eax
 5b0:	72 08                	jb     5ba <free+0x2f>
 5b2:	39 ca                	cmp    %ecx,%edx
 5b4:	77 04                	ja     5ba <free+0x2f>
 5b6:	89 d0                	mov    %edx,%eax
 5b8:	eb e6                	jmp    5a0 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5ba:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5bd:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 5c0:	8b 10                	mov    (%eax),%edx
 5c2:	39 d7                	cmp    %edx,%edi
 5c4:	74 19                	je     5df <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5c6:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5c9:	8b 50 04             	mov    0x4(%eax),%edx
 5cc:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5cf:	39 ce                	cmp    %ecx,%esi
 5d1:	74 1b                	je     5ee <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5d3:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5d5:	a3 f0 09 00 00       	mov    %eax,0x9f0
}
 5da:	5b                   	pop    %ebx
 5db:	5e                   	pop    %esi
 5dc:	5f                   	pop    %edi
 5dd:	5d                   	pop    %ebp
 5de:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 5df:	03 72 04             	add    0x4(%edx),%esi
 5e2:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5e5:	8b 10                	mov    (%eax),%edx
 5e7:	8b 12                	mov    (%edx),%edx
 5e9:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5ec:	eb db                	jmp    5c9 <free+0x3e>
    p->s.size += bp->s.size;
 5ee:	03 53 fc             	add    -0x4(%ebx),%edx
 5f1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5f4:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5f7:	89 10                	mov    %edx,(%eax)
 5f9:	eb da                	jmp    5d5 <free+0x4a>

000005fb <morecore>:

static Header*
morecore(uint nu)
{
 5fb:	55                   	push   %ebp
 5fc:	89 e5                	mov    %esp,%ebp
 5fe:	53                   	push   %ebx
 5ff:	83 ec 04             	sub    $0x4,%esp
 602:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 604:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 609:	77 05                	ja     610 <morecore+0x15>
    nu = 4096;
 60b:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 610:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 617:	83 ec 0c             	sub    $0xc,%esp
 61a:	50                   	push   %eax
 61b:	e8 30 fd ff ff       	call   350 <sbrk>
  if(p == (char*)-1)
 620:	83 c4 10             	add    $0x10,%esp
 623:	83 f8 ff             	cmp    $0xffffffff,%eax
 626:	74 1c                	je     644 <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 628:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 62b:	83 c0 08             	add    $0x8,%eax
 62e:	83 ec 0c             	sub    $0xc,%esp
 631:	50                   	push   %eax
 632:	e8 54 ff ff ff       	call   58b <free>
  return freep;
 637:	a1 f0 09 00 00       	mov    0x9f0,%eax
 63c:	83 c4 10             	add    $0x10,%esp
}
 63f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 642:	c9                   	leave  
 643:	c3                   	ret    
    return 0;
 644:	b8 00 00 00 00       	mov    $0x0,%eax
 649:	eb f4                	jmp    63f <morecore+0x44>

0000064b <malloc>:

void*
malloc(uint nbytes)
{
 64b:	55                   	push   %ebp
 64c:	89 e5                	mov    %esp,%ebp
 64e:	53                   	push   %ebx
 64f:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 652:	8b 45 08             	mov    0x8(%ebp),%eax
 655:	8d 58 07             	lea    0x7(%eax),%ebx
 658:	c1 eb 03             	shr    $0x3,%ebx
 65b:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 65e:	8b 0d f0 09 00 00    	mov    0x9f0,%ecx
 664:	85 c9                	test   %ecx,%ecx
 666:	74 04                	je     66c <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 668:	8b 01                	mov    (%ecx),%eax
 66a:	eb 4d                	jmp    6b9 <malloc+0x6e>
    base.s.ptr = freep = prevp = &base;
 66c:	c7 05 f0 09 00 00 f4 	movl   $0x9f4,0x9f0
 673:	09 00 00 
 676:	c7 05 f4 09 00 00 f4 	movl   $0x9f4,0x9f4
 67d:	09 00 00 
    base.s.size = 0;
 680:	c7 05 f8 09 00 00 00 	movl   $0x0,0x9f8
 687:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 68a:	b9 f4 09 00 00       	mov    $0x9f4,%ecx
 68f:	eb d7                	jmp    668 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 691:	39 da                	cmp    %ebx,%edx
 693:	74 1a                	je     6af <malloc+0x64>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 695:	29 da                	sub    %ebx,%edx
 697:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 69a:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 69d:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6a0:	89 0d f0 09 00 00    	mov    %ecx,0x9f0
      return (void*)(p + 1);
 6a6:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6a9:	83 c4 04             	add    $0x4,%esp
 6ac:	5b                   	pop    %ebx
 6ad:	5d                   	pop    %ebp
 6ae:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 6af:	8b 10                	mov    (%eax),%edx
 6b1:	89 11                	mov    %edx,(%ecx)
 6b3:	eb eb                	jmp    6a0 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b5:	89 c1                	mov    %eax,%ecx
 6b7:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 6b9:	8b 50 04             	mov    0x4(%eax),%edx
 6bc:	39 da                	cmp    %ebx,%edx
 6be:	73 d1                	jae    691 <malloc+0x46>
    if(p == freep)
 6c0:	39 05 f0 09 00 00    	cmp    %eax,0x9f0
 6c6:	75 ed                	jne    6b5 <malloc+0x6a>
      if((p = morecore(nunits)) == 0)
 6c8:	89 d8                	mov    %ebx,%eax
 6ca:	e8 2c ff ff ff       	call   5fb <morecore>
 6cf:	85 c0                	test   %eax,%eax
 6d1:	75 e2                	jne    6b5 <malloc+0x6a>
        return 0;
 6d3:	b8 00 00 00 00       	mov    $0x0,%eax
 6d8:	eb cf                	jmp    6a9 <malloc+0x5e>
