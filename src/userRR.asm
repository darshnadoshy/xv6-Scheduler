
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
  11:	81 ec 18 0e 00 00    	sub    $0xe18,%esp
  17:	8b 71 04             	mov    0x4(%ecx),%esi
  int user_timeslice, job_count; //, iterations;
  char *job[64];
  struct pstat ps;
  
  if(argc > 5 || argc < 5 ){
  1a:	83 39 05             	cmpl   $0x5,(%ecx)
  1d:	74 14                	je     33 <main+0x33>
    printf(2, "Usage:  userRR <user-level-timeslice> <iterations> <job> <jobcount>\n");
  1f:	83 ec 08             	sub    $0x8,%esp
  22:	68 84 07 00 00       	push   $0x784
  27:	6a 02                	push   $0x2
  29:	e8 9c 04 00 00       	call   4ca <printf>
    exit();
  2e:	e8 3d 03 00 00       	call   370 <exit>
  }
  
  // Initialize the values from cmd line args
  user_timeslice = atoi(argv[1]);
  33:	83 ec 0c             	sub    $0xc,%esp
  36:	ff 76 04             	pushl  0x4(%esi)
  39:	e8 d4 02 00 00       	call   312 <atoi>
  3e:	89 c7                	mov    %eax,%edi
  // iterations = atoi(argv[2]);
  job_count = atoi(argv[4]);
  40:	83 c4 04             	add    $0x4,%esp
  43:	ff 76 10             	pushl  0x10(%esi)
  46:	e8 c7 02 00 00       	call   312 <atoi>
  4b:	89 85 e4 f1 ff ff    	mov    %eax,-0xe1c(%ebp)

   for(int i = 0; i < job_count; i++)
  51:	83 c4 10             	add    $0x10,%esp
  54:	bb 00 00 00 00       	mov    $0x0,%ebx
  59:	eb 18                	jmp    73 <main+0x73>
    {
      strcpy(job[i], argv[3]);
  5b:	83 ec 08             	sub    $0x8,%esp
  5e:	ff 76 0c             	pushl  0xc(%esi)
  61:	ff b4 9d e8 fe ff ff 	pushl  -0x118(%ebp,%ebx,4)
  68:	e8 76 01 00 00       	call   1e3 <strcpy>
   for(int i = 0; i < job_count; i++)
  6d:	83 c3 01             	add    $0x1,%ebx
  70:	83 c4 10             	add    $0x10,%esp
  73:	3b 9d e4 f1 ff ff    	cmp    -0xe1c(%ebp),%ebx
  79:	7c e0                	jl     5b <main+0x5b>
    }
    
    struct proc *np[64];
    // struct proc *curproc = myproc();
    
    for(int i = 0; i < 64; i++) {
  7b:	b8 00 00 00 00       	mov    $0x0,%eax
  80:	eb 0e                	jmp    90 <main+0x90>
      np[i] = 0;
  82:	c7 84 85 e8 f1 ff ff 	movl   $0x0,-0xe18(%ebp,%eax,4)
  89:	00 00 00 00 
    for(int i = 0; i < 64; i++) {
  8d:	83 c0 01             	add    $0x1,%eax
  90:	83 f8 3f             	cmp    $0x3f,%eax
  93:	7e ed                	jle    82 <main+0x82>
    }
    setpri(getpid(), 3);
  95:	e8 56 03 00 00       	call   3f0 <getpid>
  9a:	83 ec 08             	sub    $0x8,%esp
  9d:	6a 03                	push   $0x3
  9f:	50                   	push   %eax
  a0:	e8 7b 03 00 00       	call   420 <setpri>

    for(int i = 0; i < job_count ; i++)
  a5:	83 c4 10             	add    $0x10,%esp
  a8:	bb 00 00 00 00       	mov    $0x0,%ebx
  ad:	eb 30                	jmp    df <main+0xdf>
    {
      np[i]->pid = fork2(0);
      printf(1, "np[%d]->pid = %d\n", i, np[i]->pid);
      if(np[i]->pid < 0) {
        printf(2, "Could not fork!\n");
  af:	83 ec 08             	sub    $0x8,%esp
  b2:	68 de 07 00 00       	push   $0x7de
  b7:	6a 02                	push   $0x2
  b9:	e8 0c 04 00 00       	call   4ca <printf>
        exit();
  be:	e8 ad 02 00 00       	call   370 <exit>
      }
      if(np[i]->pid == 0)
      {
        if(exec(job[0], job) < 0)
        {
          printf(2, "Exec failed!\n");
  c3:	83 ec 08             	sub    $0x8,%esp
  c6:	68 ef 07 00 00       	push   $0x7ef
  cb:	6a 02                	push   $0x2
  cd:	e8 f8 03 00 00       	call   4ca <printf>
  d2:	83 c4 10             	add    $0x10,%esp
  d5:	eb 5c                	jmp    133 <main+0x133>
        exit();
      }
      else
      {
        //sleep(user_timeslice);
        wait();
  d7:	e8 9c 02 00 00       	call   378 <wait>
    for(int i = 0; i < job_count ; i++)
  dc:	83 c3 01             	add    $0x1,%ebx
  df:	3b 9d e4 f1 ff ff    	cmp    -0xe1c(%ebp),%ebx
  e5:	7d 51                	jge    138 <main+0x138>
      np[i]->pid = fork2(0);
  e7:	8b b4 9d e8 f1 ff ff 	mov    -0xe18(%ebp,%ebx,4),%esi
  ee:	83 ec 0c             	sub    $0xc,%esp
  f1:	6a 00                	push   $0x0
  f3:	e8 18 03 00 00       	call   410 <fork2>
  f8:	89 46 10             	mov    %eax,0x10(%esi)
      printf(1, "np[%d]->pid = %d\n", i, np[i]->pid);
  fb:	50                   	push   %eax
  fc:	53                   	push   %ebx
  fd:	68 cc 07 00 00       	push   $0x7cc
 102:	6a 01                	push   $0x1
 104:	e8 c1 03 00 00       	call   4ca <printf>
      if(np[i]->pid < 0) {
 109:	8b 46 10             	mov    0x10(%esi),%eax
 10c:	83 c4 20             	add    $0x20,%esp
 10f:	85 c0                	test   %eax,%eax
 111:	78 9c                	js     af <main+0xaf>
      if(np[i]->pid == 0)
 113:	85 c0                	test   %eax,%eax
 115:	75 c0                	jne    d7 <main+0xd7>
        if(exec(job[0], job) < 0)
 117:	83 ec 08             	sub    $0x8,%esp
 11a:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
 120:	50                   	push   %eax
 121:	ff b5 e8 fe ff ff    	pushl  -0x118(%ebp)
 127:	e8 7c 02 00 00       	call   3a8 <exec>
 12c:	83 c4 10             	add    $0x10,%esp
 12f:	85 c0                	test   %eax,%eax
 131:	78 90                	js     c3 <main+0xc3>
        exit();
 133:	e8 38 02 00 00       	call   370 <exit>
    //      setpri(np[j]->pid, 0);
    //      printf(1, "jobcount = %d %d\n", j, job_count);
    //   }
    // }

    for(int i = 0; i < user_timeslice; i++)
 138:	bb 00 00 00 00       	mov    $0x0,%ebx
 13d:	eb 08                	jmp    147 <main+0x147>
    {
      wait();
 13f:	e8 34 02 00 00       	call   378 <wait>
    for(int i = 0; i < user_timeslice; i++)
 144:	83 c3 01             	add    $0x1,%ebx
 147:	39 fb                	cmp    %edi,%ebx
 149:	7c f4                	jl     13f <main+0x13f>
    }
    getpinfo(&ps);
 14b:	83 ec 0c             	sub    $0xc,%esp
 14e:	8d 85 e8 f2 ff ff    	lea    -0xd18(%ebp),%eax
 154:	50                   	push   %eax
 155:	e8 ce 02 00 00       	call   428 <getpinfo>
    for(int i = 0; i < job_count + 3; i++)
 15a:	83 c4 10             	add    $0x10,%esp
 15d:	bf 00 00 00 00       	mov    $0x0,%edi
 162:	eb 4d                	jmp    1b1 <main+0x1b1>
      printf(1, "Pid: %d\n", ps.pid[i]);
      
      //printf(1, "State: %d\n", ps.state[i]);
      for(int j = 0; j < 4; j++)
      {
        printf(1, "Priority: %d\n", j); // ps.priority[j]);
 164:	83 ec 04             	sub    $0x4,%esp
 167:	53                   	push   %ebx
 168:	68 06 08 00 00       	push   $0x806
 16d:	6a 01                	push   $0x1
 16f:	e8 56 03 00 00       	call   4ca <printf>
        printf(1, "Ticks: %d\n", ps.ticks[i][j]);
 174:	83 c4 0c             	add    $0xc,%esp
 177:	8d 34 bb             	lea    (%ebx,%edi,4),%esi
 17a:	ff b4 b5 e8 f6 ff ff 	pushl  -0x918(%ebp,%esi,4)
 181:	68 14 08 00 00       	push   $0x814
 186:	6a 01                	push   $0x1
 188:	e8 3d 03 00 00       	call   4ca <printf>
        printf(1, "Qtail: %d\n", ps.qtail[i][j]);
 18d:	83 c4 0c             	add    $0xc,%esp
 190:	ff b4 b5 e8 fa ff ff 	pushl  -0x518(%ebp,%esi,4)
 197:	68 1f 08 00 00       	push   $0x81f
 19c:	6a 01                	push   $0x1
 19e:	e8 27 03 00 00       	call   4ca <printf>
      for(int j = 0; j < 4; j++)
 1a3:	83 c3 01             	add    $0x1,%ebx
 1a6:	83 c4 10             	add    $0x10,%esp
 1a9:	83 fb 03             	cmp    $0x3,%ebx
 1ac:	7e b6                	jle    164 <main+0x164>
    for(int i = 0; i < job_count + 3; i++)
 1ae:	83 c7 01             	add    $0x1,%edi
 1b1:	8b 85 e4 f1 ff ff    	mov    -0xe1c(%ebp),%eax
 1b7:	83 c0 03             	add    $0x3,%eax
 1ba:	39 f8                	cmp    %edi,%eax
 1bc:	7e 20                	jle    1de <main+0x1de>
      printf(1, "Pid: %d\n", ps.pid[i]);
 1be:	83 ec 04             	sub    $0x4,%esp
 1c1:	ff b4 bd e8 f3 ff ff 	pushl  -0xc18(%ebp,%edi,4)
 1c8:	68 fd 07 00 00       	push   $0x7fd
 1cd:	6a 01                	push   $0x1
 1cf:	e8 f6 02 00 00       	call   4ca <printf>
      for(int j = 0; j < 4; j++)
 1d4:	83 c4 10             	add    $0x10,%esp
 1d7:	bb 00 00 00 00       	mov    $0x0,%ebx
 1dc:	eb cb                	jmp    1a9 <main+0x1a9>
      }    
    }
  
  exit();
 1de:	e8 8d 01 00 00       	call   370 <exit>

000001e3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
 1e6:	53                   	push   %ebx
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ea:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ed:	89 c2                	mov    %eax,%edx
 1ef:	0f b6 19             	movzbl (%ecx),%ebx
 1f2:	88 1a                	mov    %bl,(%edx)
 1f4:	8d 52 01             	lea    0x1(%edx),%edx
 1f7:	8d 49 01             	lea    0x1(%ecx),%ecx
 1fa:	84 db                	test   %bl,%bl
 1fc:	75 f1                	jne    1ef <strcpy+0xc>
    ;
  return os;
}
 1fe:	5b                   	pop    %ebx
 1ff:	5d                   	pop    %ebp
 200:	c3                   	ret    

00000201 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	8b 4d 08             	mov    0x8(%ebp),%ecx
 207:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 20a:	eb 06                	jmp    212 <strcmp+0x11>
    p++, q++;
 20c:	83 c1 01             	add    $0x1,%ecx
 20f:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 212:	0f b6 01             	movzbl (%ecx),%eax
 215:	84 c0                	test   %al,%al
 217:	74 04                	je     21d <strcmp+0x1c>
 219:	3a 02                	cmp    (%edx),%al
 21b:	74 ef                	je     20c <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 21d:	0f b6 c0             	movzbl %al,%eax
 220:	0f b6 12             	movzbl (%edx),%edx
 223:	29 d0                	sub    %edx,%eax
}
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    

00000227 <strlen>:

uint
strlen(const char *s)
{
 227:	55                   	push   %ebp
 228:	89 e5                	mov    %esp,%ebp
 22a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 22d:	ba 00 00 00 00       	mov    $0x0,%edx
 232:	eb 03                	jmp    237 <strlen+0x10>
 234:	83 c2 01             	add    $0x1,%edx
 237:	89 d0                	mov    %edx,%eax
 239:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 23d:	75 f5                	jne    234 <strlen+0xd>
    ;
  return n;
}
 23f:	5d                   	pop    %ebp
 240:	c3                   	ret    

00000241 <memset>:

void*
memset(void *dst, int c, uint n)
{
 241:	55                   	push   %ebp
 242:	89 e5                	mov    %esp,%ebp
 244:	57                   	push   %edi
 245:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 248:	89 d7                	mov    %edx,%edi
 24a:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24d:	8b 45 0c             	mov    0xc(%ebp),%eax
 250:	fc                   	cld    
 251:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 253:	89 d0                	mov    %edx,%eax
 255:	5f                   	pop    %edi
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    

00000258 <strchr>:

char*
strchr(const char *s, char c)
{
 258:	55                   	push   %ebp
 259:	89 e5                	mov    %esp,%ebp
 25b:	8b 45 08             	mov    0x8(%ebp),%eax
 25e:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 262:	0f b6 10             	movzbl (%eax),%edx
 265:	84 d2                	test   %dl,%dl
 267:	74 09                	je     272 <strchr+0x1a>
    if(*s == c)
 269:	38 ca                	cmp    %cl,%dl
 26b:	74 0a                	je     277 <strchr+0x1f>
  for(; *s; s++)
 26d:	83 c0 01             	add    $0x1,%eax
 270:	eb f0                	jmp    262 <strchr+0xa>
      return (char*)s;
  return 0;
 272:	b8 00 00 00 00       	mov    $0x0,%eax
}
 277:	5d                   	pop    %ebp
 278:	c3                   	ret    

00000279 <gets>:

char*
gets(char *buf, int max)
{
 279:	55                   	push   %ebp
 27a:	89 e5                	mov    %esp,%ebp
 27c:	57                   	push   %edi
 27d:	56                   	push   %esi
 27e:	53                   	push   %ebx
 27f:	83 ec 1c             	sub    $0x1c,%esp
 282:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 285:	bb 00 00 00 00       	mov    $0x0,%ebx
 28a:	8d 73 01             	lea    0x1(%ebx),%esi
 28d:	3b 75 0c             	cmp    0xc(%ebp),%esi
 290:	7d 2e                	jge    2c0 <gets+0x47>
    cc = read(0, &c, 1);
 292:	83 ec 04             	sub    $0x4,%esp
 295:	6a 01                	push   $0x1
 297:	8d 45 e7             	lea    -0x19(%ebp),%eax
 29a:	50                   	push   %eax
 29b:	6a 00                	push   $0x0
 29d:	e8 e6 00 00 00       	call   388 <read>
    if(cc < 1)
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	7e 17                	jle    2c0 <gets+0x47>
      break;
    buf[i++] = c;
 2a9:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2ad:	88 04 1f             	mov    %al,(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 2b0:	3c 0a                	cmp    $0xa,%al
 2b2:	0f 94 c2             	sete   %dl
 2b5:	3c 0d                	cmp    $0xd,%al
 2b7:	0f 94 c0             	sete   %al
    buf[i++] = c;
 2ba:	89 f3                	mov    %esi,%ebx
    if(c == '\n' || c == '\r')
 2bc:	08 c2                	or     %al,%dl
 2be:	74 ca                	je     28a <gets+0x11>
      break;
  }
  buf[i] = '\0';
 2c0:	c6 04 1f 00          	movb   $0x0,(%edi,%ebx,1)
  return buf;
}
 2c4:	89 f8                	mov    %edi,%eax
 2c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5f                   	pop    %edi
 2cc:	5d                   	pop    %ebp
 2cd:	c3                   	ret    

000002ce <stat>:

int
stat(const char *n, struct stat *st)
{
 2ce:	55                   	push   %ebp
 2cf:	89 e5                	mov    %esp,%ebp
 2d1:	56                   	push   %esi
 2d2:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d3:	83 ec 08             	sub    $0x8,%esp
 2d6:	6a 00                	push   $0x0
 2d8:	ff 75 08             	pushl  0x8(%ebp)
 2db:	e8 d0 00 00 00       	call   3b0 <open>
  if(fd < 0)
 2e0:	83 c4 10             	add    $0x10,%esp
 2e3:	85 c0                	test   %eax,%eax
 2e5:	78 24                	js     30b <stat+0x3d>
 2e7:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	pushl  0xc(%ebp)
 2ef:	50                   	push   %eax
 2f0:	e8 d3 00 00 00       	call   3c8 <fstat>
 2f5:	89 c6                	mov    %eax,%esi
  close(fd);
 2f7:	89 1c 24             	mov    %ebx,(%esp)
 2fa:	e8 99 00 00 00       	call   398 <close>
  return r;
 2ff:	83 c4 10             	add    $0x10,%esp
}
 302:	89 f0                	mov    %esi,%eax
 304:	8d 65 f8             	lea    -0x8(%ebp),%esp
 307:	5b                   	pop    %ebx
 308:	5e                   	pop    %esi
 309:	5d                   	pop    %ebp
 30a:	c3                   	ret    
    return -1;
 30b:	be ff ff ff ff       	mov    $0xffffffff,%esi
 310:	eb f0                	jmp    302 <stat+0x34>

00000312 <atoi>:

int
atoi(const char *s)
{
 312:	55                   	push   %ebp
 313:	89 e5                	mov    %esp,%ebp
 315:	53                   	push   %ebx
 316:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 319:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 31e:	eb 10                	jmp    330 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 320:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
 323:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
 326:	83 c1 01             	add    $0x1,%ecx
 329:	0f be d2             	movsbl %dl,%edx
 32c:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  while('0' <= *s && *s <= '9')
 330:	0f b6 11             	movzbl (%ecx),%edx
 333:	8d 5a d0             	lea    -0x30(%edx),%ebx
 336:	80 fb 09             	cmp    $0x9,%bl
 339:	76 e5                	jbe    320 <atoi+0xe>
  return n;
}
 33b:	5b                   	pop    %ebx
 33c:	5d                   	pop    %ebp
 33d:	c3                   	ret    

0000033e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 33e:	55                   	push   %ebp
 33f:	89 e5                	mov    %esp,%ebp
 341:	56                   	push   %esi
 342:	53                   	push   %ebx
 343:	8b 45 08             	mov    0x8(%ebp),%eax
 346:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 349:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 34c:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 34e:	eb 0d                	jmp    35d <memmove+0x1f>
    *dst++ = *src++;
 350:	0f b6 13             	movzbl (%ebx),%edx
 353:	88 11                	mov    %dl,(%ecx)
 355:	8d 5b 01             	lea    0x1(%ebx),%ebx
 358:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 35b:	89 f2                	mov    %esi,%edx
 35d:	8d 72 ff             	lea    -0x1(%edx),%esi
 360:	85 d2                	test   %edx,%edx
 362:	7f ec                	jg     350 <memmove+0x12>
  return vdst;
}
 364:	5b                   	pop    %ebx
 365:	5e                   	pop    %esi
 366:	5d                   	pop    %ebp
 367:	c3                   	ret    

00000368 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 368:	b8 01 00 00 00       	mov    $0x1,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <exit>:
SYSCALL(exit)
 370:	b8 02 00 00 00       	mov    $0x2,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <wait>:
SYSCALL(wait)
 378:	b8 03 00 00 00       	mov    $0x3,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <pipe>:
SYSCALL(pipe)
 380:	b8 04 00 00 00       	mov    $0x4,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <read>:
SYSCALL(read)
 388:	b8 05 00 00 00       	mov    $0x5,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <write>:
SYSCALL(write)
 390:	b8 10 00 00 00       	mov    $0x10,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <close>:
SYSCALL(close)
 398:	b8 15 00 00 00       	mov    $0x15,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <kill>:
SYSCALL(kill)
 3a0:	b8 06 00 00 00       	mov    $0x6,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <exec>:
SYSCALL(exec)
 3a8:	b8 07 00 00 00       	mov    $0x7,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <open>:
SYSCALL(open)
 3b0:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <mknod>:
SYSCALL(mknod)
 3b8:	b8 11 00 00 00       	mov    $0x11,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <unlink>:
SYSCALL(unlink)
 3c0:	b8 12 00 00 00       	mov    $0x12,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <fstat>:
SYSCALL(fstat)
 3c8:	b8 08 00 00 00       	mov    $0x8,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <link>:
SYSCALL(link)
 3d0:	b8 13 00 00 00       	mov    $0x13,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <mkdir>:
SYSCALL(mkdir)
 3d8:	b8 14 00 00 00       	mov    $0x14,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <chdir>:
SYSCALL(chdir)
 3e0:	b8 09 00 00 00       	mov    $0x9,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <dup>:
SYSCALL(dup)
 3e8:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <getpid>:
SYSCALL(getpid)
 3f0:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f5:	cd 40                	int    $0x40
 3f7:	c3                   	ret    

000003f8 <sbrk>:
SYSCALL(sbrk)
 3f8:	b8 0c 00 00 00       	mov    $0xc,%eax
 3fd:	cd 40                	int    $0x40
 3ff:	c3                   	ret    

00000400 <sleep>:
SYSCALL(sleep)
 400:	b8 0d 00 00 00       	mov    $0xd,%eax
 405:	cd 40                	int    $0x40
 407:	c3                   	ret    

00000408 <uptime>:
SYSCALL(uptime)
 408:	b8 0e 00 00 00       	mov    $0xe,%eax
 40d:	cd 40                	int    $0x40
 40f:	c3                   	ret    

00000410 <fork2>:
SYSCALL(fork2)
 410:	b8 18 00 00 00       	mov    $0x18,%eax
 415:	cd 40                	int    $0x40
 417:	c3                   	ret    

00000418 <getpri>:
SYSCALL(getpri)
 418:	b8 17 00 00 00       	mov    $0x17,%eax
 41d:	cd 40                	int    $0x40
 41f:	c3                   	ret    

00000420 <setpri>:
SYSCALL(setpri)
 420:	b8 16 00 00 00       	mov    $0x16,%eax
 425:	cd 40                	int    $0x40
 427:	c3                   	ret    

00000428 <getpinfo>:
SYSCALL(getpinfo)
 428:	b8 19 00 00 00       	mov    $0x19,%eax
 42d:	cd 40                	int    $0x40
 42f:	c3                   	ret    

00000430 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	83 ec 1c             	sub    $0x1c,%esp
 436:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 439:	6a 01                	push   $0x1
 43b:	8d 55 f4             	lea    -0xc(%ebp),%edx
 43e:	52                   	push   %edx
 43f:	50                   	push   %eax
 440:	e8 4b ff ff ff       	call   390 <write>
}
 445:	83 c4 10             	add    $0x10,%esp
 448:	c9                   	leave  
 449:	c3                   	ret    

0000044a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 44a:	55                   	push   %ebp
 44b:	89 e5                	mov    %esp,%ebp
 44d:	57                   	push   %edi
 44e:	56                   	push   %esi
 44f:	53                   	push   %ebx
 450:	83 ec 2c             	sub    $0x2c,%esp
 453:	89 c7                	mov    %eax,%edi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 455:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 459:	0f 95 c3             	setne  %bl
 45c:	89 d0                	mov    %edx,%eax
 45e:	c1 e8 1f             	shr    $0x1f,%eax
 461:	84 c3                	test   %al,%bl
 463:	74 10                	je     475 <printint+0x2b>
    neg = 1;
    x = -xx;
 465:	f7 da                	neg    %edx
    neg = 1;
 467:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 46e:	be 00 00 00 00       	mov    $0x0,%esi
 473:	eb 0b                	jmp    480 <printint+0x36>
  neg = 0;
 475:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 47c:	eb f0                	jmp    46e <printint+0x24>
  do{
    buf[i++] = digits[x % base];
 47e:	89 c6                	mov    %eax,%esi
 480:	89 d0                	mov    %edx,%eax
 482:	ba 00 00 00 00       	mov    $0x0,%edx
 487:	f7 f1                	div    %ecx
 489:	89 c3                	mov    %eax,%ebx
 48b:	8d 46 01             	lea    0x1(%esi),%eax
 48e:	0f b6 92 34 08 00 00 	movzbl 0x834(%edx),%edx
 495:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
  }while((x /= base) != 0);
 499:	89 da                	mov    %ebx,%edx
 49b:	85 db                	test   %ebx,%ebx
 49d:	75 df                	jne    47e <printint+0x34>
 49f:	89 c3                	mov    %eax,%ebx
  if(neg)
 4a1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 4a5:	74 16                	je     4bd <printint+0x73>
    buf[i++] = '-';
 4a7:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 4ac:	8d 5e 02             	lea    0x2(%esi),%ebx
 4af:	eb 0c                	jmp    4bd <printint+0x73>

  while(--i >= 0)
    putc(fd, buf[i]);
 4b1:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 4b6:	89 f8                	mov    %edi,%eax
 4b8:	e8 73 ff ff ff       	call   430 <putc>
  while(--i >= 0)
 4bd:	83 eb 01             	sub    $0x1,%ebx
 4c0:	79 ef                	jns    4b1 <printint+0x67>
}
 4c2:	83 c4 2c             	add    $0x2c,%esp
 4c5:	5b                   	pop    %ebx
 4c6:	5e                   	pop    %esi
 4c7:	5f                   	pop    %edi
 4c8:	5d                   	pop    %ebp
 4c9:	c3                   	ret    

000004ca <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4ca:	55                   	push   %ebp
 4cb:	89 e5                	mov    %esp,%ebp
 4cd:	57                   	push   %edi
 4ce:	56                   	push   %esi
 4cf:	53                   	push   %ebx
 4d0:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4d3:	8d 45 10             	lea    0x10(%ebp),%eax
 4d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 4d9:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 4de:	bb 00 00 00 00       	mov    $0x0,%ebx
 4e3:	eb 14                	jmp    4f9 <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4e5:	89 fa                	mov    %edi,%edx
 4e7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ea:	e8 41 ff ff ff       	call   430 <putc>
 4ef:	eb 05                	jmp    4f6 <printf+0x2c>
      }
    } else if(state == '%'){
 4f1:	83 fe 25             	cmp    $0x25,%esi
 4f4:	74 25                	je     51b <printf+0x51>
  for(i = 0; fmt[i]; i++){
 4f6:	83 c3 01             	add    $0x1,%ebx
 4f9:	8b 45 0c             	mov    0xc(%ebp),%eax
 4fc:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 500:	84 c0                	test   %al,%al
 502:	0f 84 23 01 00 00    	je     62b <printf+0x161>
    c = fmt[i] & 0xff;
 508:	0f be f8             	movsbl %al,%edi
 50b:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 50e:	85 f6                	test   %esi,%esi
 510:	75 df                	jne    4f1 <printf+0x27>
      if(c == '%'){
 512:	83 f8 25             	cmp    $0x25,%eax
 515:	75 ce                	jne    4e5 <printf+0x1b>
        state = '%';
 517:	89 c6                	mov    %eax,%esi
 519:	eb db                	jmp    4f6 <printf+0x2c>
      if(c == 'd'){
 51b:	83 f8 64             	cmp    $0x64,%eax
 51e:	74 49                	je     569 <printf+0x9f>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 520:	83 f8 78             	cmp    $0x78,%eax
 523:	0f 94 c1             	sete   %cl
 526:	83 f8 70             	cmp    $0x70,%eax
 529:	0f 94 c2             	sete   %dl
 52c:	08 d1                	or     %dl,%cl
 52e:	75 63                	jne    593 <printf+0xc9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 530:	83 f8 73             	cmp    $0x73,%eax
 533:	0f 84 84 00 00 00    	je     5bd <printf+0xf3>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 539:	83 f8 63             	cmp    $0x63,%eax
 53c:	0f 84 b7 00 00 00    	je     5f9 <printf+0x12f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 542:	83 f8 25             	cmp    $0x25,%eax
 545:	0f 84 cc 00 00 00    	je     617 <printf+0x14d>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 54b:	ba 25 00 00 00       	mov    $0x25,%edx
 550:	8b 45 08             	mov    0x8(%ebp),%eax
 553:	e8 d8 fe ff ff       	call   430 <putc>
        putc(fd, c);
 558:	89 fa                	mov    %edi,%edx
 55a:	8b 45 08             	mov    0x8(%ebp),%eax
 55d:	e8 ce fe ff ff       	call   430 <putc>
      }
      state = 0;
 562:	be 00 00 00 00       	mov    $0x0,%esi
 567:	eb 8d                	jmp    4f6 <printf+0x2c>
        printint(fd, *ap, 10, 1);
 569:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 56c:	8b 17                	mov    (%edi),%edx
 56e:	83 ec 0c             	sub    $0xc,%esp
 571:	6a 01                	push   $0x1
 573:	b9 0a 00 00 00       	mov    $0xa,%ecx
 578:	8b 45 08             	mov    0x8(%ebp),%eax
 57b:	e8 ca fe ff ff       	call   44a <printint>
        ap++;
 580:	83 c7 04             	add    $0x4,%edi
 583:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 586:	83 c4 10             	add    $0x10,%esp
      state = 0;
 589:	be 00 00 00 00       	mov    $0x0,%esi
 58e:	e9 63 ff ff ff       	jmp    4f6 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 593:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 596:	8b 17                	mov    (%edi),%edx
 598:	83 ec 0c             	sub    $0xc,%esp
 59b:	6a 00                	push   $0x0
 59d:	b9 10 00 00 00       	mov    $0x10,%ecx
 5a2:	8b 45 08             	mov    0x8(%ebp),%eax
 5a5:	e8 a0 fe ff ff       	call   44a <printint>
        ap++;
 5aa:	83 c7 04             	add    $0x4,%edi
 5ad:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 5b0:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5b3:	be 00 00 00 00       	mov    $0x0,%esi
 5b8:	e9 39 ff ff ff       	jmp    4f6 <printf+0x2c>
        s = (char*)*ap;
 5bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c0:	8b 30                	mov    (%eax),%esi
        ap++;
 5c2:	83 c0 04             	add    $0x4,%eax
 5c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 5c8:	85 f6                	test   %esi,%esi
 5ca:	75 28                	jne    5f4 <printf+0x12a>
          s = "(null)";
 5cc:	be 2a 08 00 00       	mov    $0x82a,%esi
 5d1:	8b 7d 08             	mov    0x8(%ebp),%edi
 5d4:	eb 0d                	jmp    5e3 <printf+0x119>
          putc(fd, *s);
 5d6:	0f be d2             	movsbl %dl,%edx
 5d9:	89 f8                	mov    %edi,%eax
 5db:	e8 50 fe ff ff       	call   430 <putc>
          s++;
 5e0:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 5e3:	0f b6 16             	movzbl (%esi),%edx
 5e6:	84 d2                	test   %dl,%dl
 5e8:	75 ec                	jne    5d6 <printf+0x10c>
      state = 0;
 5ea:	be 00 00 00 00       	mov    $0x0,%esi
 5ef:	e9 02 ff ff ff       	jmp    4f6 <printf+0x2c>
 5f4:	8b 7d 08             	mov    0x8(%ebp),%edi
 5f7:	eb ea                	jmp    5e3 <printf+0x119>
        putc(fd, *ap);
 5f9:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 5fc:	0f be 17             	movsbl (%edi),%edx
 5ff:	8b 45 08             	mov    0x8(%ebp),%eax
 602:	e8 29 fe ff ff       	call   430 <putc>
        ap++;
 607:	83 c7 04             	add    $0x4,%edi
 60a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 60d:	be 00 00 00 00       	mov    $0x0,%esi
 612:	e9 df fe ff ff       	jmp    4f6 <printf+0x2c>
        putc(fd, c);
 617:	89 fa                	mov    %edi,%edx
 619:	8b 45 08             	mov    0x8(%ebp),%eax
 61c:	e8 0f fe ff ff       	call   430 <putc>
      state = 0;
 621:	be 00 00 00 00       	mov    $0x0,%esi
 626:	e9 cb fe ff ff       	jmp    4f6 <printf+0x2c>
    }
  }
}
 62b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 62e:	5b                   	pop    %ebx
 62f:	5e                   	pop    %esi
 630:	5f                   	pop    %edi
 631:	5d                   	pop    %ebp
 632:	c3                   	ret    

00000633 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 633:	55                   	push   %ebp
 634:	89 e5                	mov    %esp,%ebp
 636:	57                   	push   %edi
 637:	56                   	push   %esi
 638:	53                   	push   %ebx
 639:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 63c:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63f:	a1 d8 0a 00 00       	mov    0xad8,%eax
 644:	eb 02                	jmp    648 <free+0x15>
 646:	89 d0                	mov    %edx,%eax
 648:	39 c8                	cmp    %ecx,%eax
 64a:	73 04                	jae    650 <free+0x1d>
 64c:	39 08                	cmp    %ecx,(%eax)
 64e:	77 12                	ja     662 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 650:	8b 10                	mov    (%eax),%edx
 652:	39 c2                	cmp    %eax,%edx
 654:	77 f0                	ja     646 <free+0x13>
 656:	39 c8                	cmp    %ecx,%eax
 658:	72 08                	jb     662 <free+0x2f>
 65a:	39 ca                	cmp    %ecx,%edx
 65c:	77 04                	ja     662 <free+0x2f>
 65e:	89 d0                	mov    %edx,%eax
 660:	eb e6                	jmp    648 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 662:	8b 73 fc             	mov    -0x4(%ebx),%esi
 665:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 668:	8b 10                	mov    (%eax),%edx
 66a:	39 d7                	cmp    %edx,%edi
 66c:	74 19                	je     687 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 66e:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 671:	8b 50 04             	mov    0x4(%eax),%edx
 674:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 677:	39 ce                	cmp    %ecx,%esi
 679:	74 1b                	je     696 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 67b:	89 08                	mov    %ecx,(%eax)
  freep = p;
 67d:	a3 d8 0a 00 00       	mov    %eax,0xad8
}
 682:	5b                   	pop    %ebx
 683:	5e                   	pop    %esi
 684:	5f                   	pop    %edi
 685:	5d                   	pop    %ebp
 686:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 687:	03 72 04             	add    0x4(%edx),%esi
 68a:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 68d:	8b 10                	mov    (%eax),%edx
 68f:	8b 12                	mov    (%edx),%edx
 691:	89 53 f8             	mov    %edx,-0x8(%ebx)
 694:	eb db                	jmp    671 <free+0x3e>
    p->s.size += bp->s.size;
 696:	03 53 fc             	add    -0x4(%ebx),%edx
 699:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 69c:	8b 53 f8             	mov    -0x8(%ebx),%edx
 69f:	89 10                	mov    %edx,(%eax)
 6a1:	eb da                	jmp    67d <free+0x4a>

000006a3 <morecore>:

static Header*
morecore(uint nu)
{
 6a3:	55                   	push   %ebp
 6a4:	89 e5                	mov    %esp,%ebp
 6a6:	53                   	push   %ebx
 6a7:	83 ec 04             	sub    $0x4,%esp
 6aa:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 6ac:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 6b1:	77 05                	ja     6b8 <morecore+0x15>
    nu = 4096;
 6b3:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 6b8:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 6bf:	83 ec 0c             	sub    $0xc,%esp
 6c2:	50                   	push   %eax
 6c3:	e8 30 fd ff ff       	call   3f8 <sbrk>
  if(p == (char*)-1)
 6c8:	83 c4 10             	add    $0x10,%esp
 6cb:	83 f8 ff             	cmp    $0xffffffff,%eax
 6ce:	74 1c                	je     6ec <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6d0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6d3:	83 c0 08             	add    $0x8,%eax
 6d6:	83 ec 0c             	sub    $0xc,%esp
 6d9:	50                   	push   %eax
 6da:	e8 54 ff ff ff       	call   633 <free>
  return freep;
 6df:	a1 d8 0a 00 00       	mov    0xad8,%eax
 6e4:	83 c4 10             	add    $0x10,%esp
}
 6e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6ea:	c9                   	leave  
 6eb:	c3                   	ret    
    return 0;
 6ec:	b8 00 00 00 00       	mov    $0x0,%eax
 6f1:	eb f4                	jmp    6e7 <morecore+0x44>

000006f3 <malloc>:

void*
malloc(uint nbytes)
{
 6f3:	55                   	push   %ebp
 6f4:	89 e5                	mov    %esp,%ebp
 6f6:	53                   	push   %ebx
 6f7:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6fa:	8b 45 08             	mov    0x8(%ebp),%eax
 6fd:	8d 58 07             	lea    0x7(%eax),%ebx
 700:	c1 eb 03             	shr    $0x3,%ebx
 703:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 706:	8b 0d d8 0a 00 00    	mov    0xad8,%ecx
 70c:	85 c9                	test   %ecx,%ecx
 70e:	74 04                	je     714 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 710:	8b 01                	mov    (%ecx),%eax
 712:	eb 4d                	jmp    761 <malloc+0x6e>
    base.s.ptr = freep = prevp = &base;
 714:	c7 05 d8 0a 00 00 dc 	movl   $0xadc,0xad8
 71b:	0a 00 00 
 71e:	c7 05 dc 0a 00 00 dc 	movl   $0xadc,0xadc
 725:	0a 00 00 
    base.s.size = 0;
 728:	c7 05 e0 0a 00 00 00 	movl   $0x0,0xae0
 72f:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 732:	b9 dc 0a 00 00       	mov    $0xadc,%ecx
 737:	eb d7                	jmp    710 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 739:	39 da                	cmp    %ebx,%edx
 73b:	74 1a                	je     757 <malloc+0x64>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 73d:	29 da                	sub    %ebx,%edx
 73f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 742:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 745:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 748:	89 0d d8 0a 00 00    	mov    %ecx,0xad8
      return (void*)(p + 1);
 74e:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 751:	83 c4 04             	add    $0x4,%esp
 754:	5b                   	pop    %ebx
 755:	5d                   	pop    %ebp
 756:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 757:	8b 10                	mov    (%eax),%edx
 759:	89 11                	mov    %edx,(%ecx)
 75b:	eb eb                	jmp    748 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 75d:	89 c1                	mov    %eax,%ecx
 75f:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 761:	8b 50 04             	mov    0x4(%eax),%edx
 764:	39 da                	cmp    %ebx,%edx
 766:	73 d1                	jae    739 <malloc+0x46>
    if(p == freep)
 768:	39 05 d8 0a 00 00    	cmp    %eax,0xad8
 76e:	75 ed                	jne    75d <malloc+0x6a>
      if((p = morecore(nunits)) == 0)
 770:	89 d8                	mov    %ebx,%eax
 772:	e8 2c ff ff ff       	call   6a3 <morecore>
 777:	85 c0                	test   %eax,%eax
 779:	75 e2                	jne    75d <malloc+0x6a>
        return 0;
 77b:	b8 00 00 00 00       	mov    $0x0,%eax
 780:	eb cf                	jmp    751 <malloc+0x5e>
