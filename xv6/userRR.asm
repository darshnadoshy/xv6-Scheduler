
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
  int user_timeslice, iterations, job_count;
  char *job[64];

  if(argc > 5 || argc < 5 ){
  1a:	83 39 05             	cmpl   $0x5,(%ecx)
  1d:	74 14                	je     33 <main+0x33>
    printf(2, "Usage:  userRR <user-level-timeslice> <iterations> <job> <jobcount>\n");
  1f:	83 ec 08             	sub    $0x8,%esp
  22:	68 44 07 00 00       	push   $0x744
  27:	6a 02                	push   $0x2
  29:	e8 5e 04 00 00       	call   48c <printf>
    exit();
  2e:	e8 ff 02 00 00       	call   332 <exit>
  }
  
  // Initialize the values from cmd line args
  user_timeslice = atoi(argv[1]);
  33:	83 ec 0c             	sub    $0xc,%esp
  36:	ff 77 04             	pushl  0x4(%edi)
  39:	e8 96 02 00 00       	call   2d4 <atoi>
  3e:	89 85 e0 fd ff ff    	mov    %eax,-0x220(%ebp)
  iterations = atoi(argv[2]);
  44:	83 c4 04             	add    $0x4,%esp
  47:	ff 77 08             	pushl  0x8(%edi)
  4a:	e8 85 02 00 00       	call   2d4 <atoi>
  4f:	89 85 e4 fd ff ff    	mov    %eax,-0x21c(%ebp)
  job_count = atoi(argv[4]);
  55:	83 c4 04             	add    $0x4,%esp
  58:	ff 77 10             	pushl  0x10(%edi)
  5b:	e8 74 02 00 00       	call   2d4 <atoi>
  60:	89 c3                	mov    %eax,%ebx

   for(int i = 0; i < job_count; i++)
  62:	83 c4 10             	add    $0x10,%esp
  65:	be 00 00 00 00       	mov    $0x0,%esi
  6a:	eb 18                	jmp    84 <main+0x84>
    {
      strcpy(job[i], argv[3]);
  6c:	83 ec 08             	sub    $0x8,%esp
  6f:	ff 77 0c             	pushl  0xc(%edi)
  72:	ff b4 b5 e8 fe ff ff 	pushl  -0x118(%ebp,%esi,4)
  79:	e8 27 01 00 00       	call   1a5 <strcpy>
   for(int i = 0; i < job_count; i++)
  7e:	83 c6 01             	add    $0x1,%esi
  81:	83 c4 10             	add    $0x10,%esp
  84:	39 de                	cmp    %ebx,%esi
  86:	7c e4                	jl     6c <main+0x6c>
    }
    
    struct proc *np[64];
    // struct proc *curproc = myproc();
    
    for(int i = 0; i < 64; i++) {
  88:	b8 00 00 00 00       	mov    $0x0,%eax
  8d:	eb 0e                	jmp    9d <main+0x9d>
      np[i] = 0;
  8f:	c7 84 85 e8 fd ff ff 	movl   $0x0,-0x218(%ebp,%eax,4)
  96:	00 00 00 00 
    for(int i = 0; i < 64; i++) {
  9a:	83 c0 01             	add    $0x1,%eax
  9d:	83 f8 3f             	cmp    $0x3f,%eax
  a0:	7e ed                	jle    8f <main+0x8f>
    }
    // setpri(curproc->pid, 3);
    setpri(getpid(), 3);
  a2:	e8 0b 03 00 00       	call   3b2 <getpid>
  a7:	83 ec 08             	sub    $0x8,%esp
  aa:	6a 03                	push   $0x3
  ac:	50                   	push   %eax
  ad:	e8 30 03 00 00       	call   3e2 <setpri>
    for(int i = 0; i < job_count; i++)
  b2:	83 c4 10             	add    $0x10,%esp
  b5:	85 db                	test   %ebx,%ebx
  b7:	7f 0a                	jg     c3 <main+0xc3>
          printf(2, "Exec failed!\n");
        }
        exit();
    }

    for(int i = 0; i < iterations; i++)
  b9:	bf 00 00 00 00       	mov    $0x0,%edi
  be:	e9 b2 00 00 00       	jmp    175 <main+0x175>
      np[i]->pid = fork2(0);
  c3:	8b 9d e8 fd ff ff    	mov    -0x218(%ebp),%ebx
  c9:	83 ec 0c             	sub    $0xc,%esp
  cc:	6a 00                	push   $0x0
  ce:	e8 ff 02 00 00       	call   3d2 <fork2>
  d3:	89 43 10             	mov    %eax,0x10(%ebx)
      if(np[i]->pid < 0) {
  d6:	83 c4 10             	add    $0x10,%esp
  d9:	85 c0                	test   %eax,%eax
  db:	78 21                	js     fe <main+0xfe>
      if(exec(job[0], job) < 0)
  dd:	83 ec 08             	sub    $0x8,%esp
  e0:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
  e6:	50                   	push   %eax
  e7:	ff b5 e8 fe ff ff    	pushl  -0x118(%ebp)
  ed:	e8 78 02 00 00       	call   36a <exec>
  f2:	83 c4 10             	add    $0x10,%esp
  f5:	85 c0                	test   %eax,%eax
  f7:	78 19                	js     112 <main+0x112>
        exit();
  f9:	e8 34 02 00 00       	call   332 <exit>
        printf(2, "Could not fork\n");
  fe:	83 ec 08             	sub    $0x8,%esp
 101:	68 8c 07 00 00       	push   $0x78c
 106:	6a 02                	push   $0x2
 108:	e8 7f 03 00 00       	call   48c <printf>
        exit();
 10d:	e8 20 02 00 00       	call   332 <exit>
          printf(2, "Exec failed!\n");
 112:	83 ec 08             	sub    $0x8,%esp
 115:	68 9c 07 00 00       	push   $0x79c
 11a:	6a 02                	push   $0x2
 11c:	e8 6b 03 00 00       	call   48c <printf>
 121:	83 c4 10             	add    $0x10,%esp
 124:	eb d3                	jmp    f9 <main+0xf9>
    {
      for(int j = 0; j < job_count; j++)
      {
        setpri(np[j]->pid, 2);
 126:	8b 84 b5 e8 fd ff ff 	mov    -0x218(%ebp,%esi,4),%eax
 12d:	83 ec 08             	sub    $0x8,%esp
 130:	6a 02                	push   $0x2
 132:	89 85 dc fd ff ff    	mov    %eax,-0x224(%ebp)
 138:	ff 70 10             	pushl  0x10(%eax)
 13b:	e8 a2 02 00 00       	call   3e2 <setpri>
        sleep(user_timeslice);
 140:	83 c4 04             	add    $0x4,%esp
 143:	ff b5 e0 fd ff ff    	pushl  -0x220(%ebp)
 149:	e8 74 02 00 00       	call   3c2 <sleep>
        setpri(np[j]->pid, 0);
 14e:	83 c4 08             	add    $0x8,%esp
 151:	6a 00                	push   $0x0
 153:	8b 85 dc fd ff ff    	mov    -0x224(%ebp),%eax
 159:	ff 70 10             	pushl  0x10(%eax)
 15c:	e8 81 02 00 00       	call   3e2 <setpri>
      for(int j = 0; j < job_count; j++)
 161:	83 c6 01             	add    $0x1,%esi
 164:	83 c4 10             	add    $0x10,%esp
 167:	eb 05                	jmp    16e <main+0x16e>
 169:	be 00 00 00 00       	mov    $0x0,%esi
 16e:	39 de                	cmp    %ebx,%esi
 170:	7c b4                	jl     126 <main+0x126>
    for(int i = 0; i < iterations; i++)
 172:	83 c7 01             	add    $0x1,%edi
 175:	3b bd e4 fd ff ff    	cmp    -0x21c(%ebp),%edi
 17b:	7c ec                	jl     169 <main+0x169>
      }
    }

    for(int i = 0; i < job_count; i++)
 17d:	be 00 00 00 00       	mov    $0x0,%esi
 182:	39 de                	cmp    %ebx,%esi
 184:	7c 05                	jl     18b <main+0x18b>
    {
      kill(np[i]->pid);
    }
  
  exit();
 186:	e8 a7 01 00 00       	call   332 <exit>
      kill(np[i]->pid);
 18b:	8b 84 b5 e8 fd ff ff 	mov    -0x218(%ebp,%esi,4),%eax
 192:	83 ec 0c             	sub    $0xc,%esp
 195:	ff 70 10             	pushl  0x10(%eax)
 198:	e8 c5 01 00 00       	call   362 <kill>
    for(int i = 0; i < job_count; i++)
 19d:	83 c6 01             	add    $0x1,%esi
 1a0:	83 c4 10             	add    $0x10,%esp
 1a3:	eb dd                	jmp    182 <main+0x182>

000001a5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1a5:	55                   	push   %ebp
 1a6:	89 e5                	mov    %esp,%ebp
 1a8:	53                   	push   %ebx
 1a9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ac:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1af:	89 c2                	mov    %eax,%edx
 1b1:	0f b6 19             	movzbl (%ecx),%ebx
 1b4:	88 1a                	mov    %bl,(%edx)
 1b6:	8d 52 01             	lea    0x1(%edx),%edx
 1b9:	8d 49 01             	lea    0x1(%ecx),%ecx
 1bc:	84 db                	test   %bl,%bl
 1be:	75 f1                	jne    1b1 <strcpy+0xc>
    ;
  return os;
}
 1c0:	5b                   	pop    %ebx
 1c1:	5d                   	pop    %ebp
 1c2:	c3                   	ret    

000001c3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c3:	55                   	push   %ebp
 1c4:	89 e5                	mov    %esp,%ebp
 1c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1cc:	eb 06                	jmp    1d4 <strcmp+0x11>
    p++, q++;
 1ce:	83 c1 01             	add    $0x1,%ecx
 1d1:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1d4:	0f b6 01             	movzbl (%ecx),%eax
 1d7:	84 c0                	test   %al,%al
 1d9:	74 04                	je     1df <strcmp+0x1c>
 1db:	3a 02                	cmp    (%edx),%al
 1dd:	74 ef                	je     1ce <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 1df:	0f b6 c0             	movzbl %al,%eax
 1e2:	0f b6 12             	movzbl (%edx),%edx
 1e5:	29 d0                	sub    %edx,%eax
}
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    

000001e9 <strlen>:

uint
strlen(const char *s)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1ef:	ba 00 00 00 00       	mov    $0x0,%edx
 1f4:	eb 03                	jmp    1f9 <strlen+0x10>
 1f6:	83 c2 01             	add    $0x1,%edx
 1f9:	89 d0                	mov    %edx,%eax
 1fb:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1ff:	75 f5                	jne    1f6 <strlen+0xd>
    ;
  return n;
}
 201:	5d                   	pop    %ebp
 202:	c3                   	ret    

00000203 <memset>:

void*
memset(void *dst, int c, uint n)
{
 203:	55                   	push   %ebp
 204:	89 e5                	mov    %esp,%ebp
 206:	57                   	push   %edi
 207:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 20a:	89 d7                	mov    %edx,%edi
 20c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 20f:	8b 45 0c             	mov    0xc(%ebp),%eax
 212:	fc                   	cld    
 213:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 215:	89 d0                	mov    %edx,%eax
 217:	5f                   	pop    %edi
 218:	5d                   	pop    %ebp
 219:	c3                   	ret    

0000021a <strchr>:

char*
strchr(const char *s, char c)
{
 21a:	55                   	push   %ebp
 21b:	89 e5                	mov    %esp,%ebp
 21d:	8b 45 08             	mov    0x8(%ebp),%eax
 220:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 224:	0f b6 10             	movzbl (%eax),%edx
 227:	84 d2                	test   %dl,%dl
 229:	74 09                	je     234 <strchr+0x1a>
    if(*s == c)
 22b:	38 ca                	cmp    %cl,%dl
 22d:	74 0a                	je     239 <strchr+0x1f>
  for(; *s; s++)
 22f:	83 c0 01             	add    $0x1,%eax
 232:	eb f0                	jmp    224 <strchr+0xa>
      return (char*)s;
  return 0;
 234:	b8 00 00 00 00       	mov    $0x0,%eax
}
 239:	5d                   	pop    %ebp
 23a:	c3                   	ret    

0000023b <gets>:

char*
gets(char *buf, int max)
{
 23b:	55                   	push   %ebp
 23c:	89 e5                	mov    %esp,%ebp
 23e:	57                   	push   %edi
 23f:	56                   	push   %esi
 240:	53                   	push   %ebx
 241:	83 ec 1c             	sub    $0x1c,%esp
 244:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 247:	bb 00 00 00 00       	mov    $0x0,%ebx
 24c:	8d 73 01             	lea    0x1(%ebx),%esi
 24f:	3b 75 0c             	cmp    0xc(%ebp),%esi
 252:	7d 2e                	jge    282 <gets+0x47>
    cc = read(0, &c, 1);
 254:	83 ec 04             	sub    $0x4,%esp
 257:	6a 01                	push   $0x1
 259:	8d 45 e7             	lea    -0x19(%ebp),%eax
 25c:	50                   	push   %eax
 25d:	6a 00                	push   $0x0
 25f:	e8 e6 00 00 00       	call   34a <read>
    if(cc < 1)
 264:	83 c4 10             	add    $0x10,%esp
 267:	85 c0                	test   %eax,%eax
 269:	7e 17                	jle    282 <gets+0x47>
      break;
    buf[i++] = c;
 26b:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 26f:	88 04 1f             	mov    %al,(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 272:	3c 0a                	cmp    $0xa,%al
 274:	0f 94 c2             	sete   %dl
 277:	3c 0d                	cmp    $0xd,%al
 279:	0f 94 c0             	sete   %al
    buf[i++] = c;
 27c:	89 f3                	mov    %esi,%ebx
    if(c == '\n' || c == '\r')
 27e:	08 c2                	or     %al,%dl
 280:	74 ca                	je     24c <gets+0x11>
      break;
  }
  buf[i] = '\0';
 282:	c6 04 1f 00          	movb   $0x0,(%edi,%ebx,1)
  return buf;
}
 286:	89 f8                	mov    %edi,%eax
 288:	8d 65 f4             	lea    -0xc(%ebp),%esp
 28b:	5b                   	pop    %ebx
 28c:	5e                   	pop    %esi
 28d:	5f                   	pop    %edi
 28e:	5d                   	pop    %ebp
 28f:	c3                   	ret    

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 295:	83 ec 08             	sub    $0x8,%esp
 298:	6a 00                	push   $0x0
 29a:	ff 75 08             	pushl  0x8(%ebp)
 29d:	e8 d0 00 00 00       	call   372 <open>
  if(fd < 0)
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	78 24                	js     2cd <stat+0x3d>
 2a9:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2ab:	83 ec 08             	sub    $0x8,%esp
 2ae:	ff 75 0c             	pushl  0xc(%ebp)
 2b1:	50                   	push   %eax
 2b2:	e8 d3 00 00 00       	call   38a <fstat>
 2b7:	89 c6                	mov    %eax,%esi
  close(fd);
 2b9:	89 1c 24             	mov    %ebx,(%esp)
 2bc:	e8 99 00 00 00       	call   35a <close>
  return r;
 2c1:	83 c4 10             	add    $0x10,%esp
}
 2c4:	89 f0                	mov    %esi,%eax
 2c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
    return -1;
 2cd:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2d2:	eb f0                	jmp    2c4 <stat+0x34>

000002d4 <atoi>:

int
atoi(const char *s)
{
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	53                   	push   %ebx
 2d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 2db:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2e0:	eb 10                	jmp    2f2 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 2e2:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
 2e5:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
 2e8:	83 c1 01             	add    $0x1,%ecx
 2eb:	0f be d2             	movsbl %dl,%edx
 2ee:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  while('0' <= *s && *s <= '9')
 2f2:	0f b6 11             	movzbl (%ecx),%edx
 2f5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2f8:	80 fb 09             	cmp    $0x9,%bl
 2fb:	76 e5                	jbe    2e2 <atoi+0xe>
  return n;
}
 2fd:	5b                   	pop    %ebx
 2fe:	5d                   	pop    %ebp
 2ff:	c3                   	ret    

00000300 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
 305:	8b 45 08             	mov    0x8(%ebp),%eax
 308:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 30b:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 30e:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 310:	eb 0d                	jmp    31f <memmove+0x1f>
    *dst++ = *src++;
 312:	0f b6 13             	movzbl (%ebx),%edx
 315:	88 11                	mov    %dl,(%ecx)
 317:	8d 5b 01             	lea    0x1(%ebx),%ebx
 31a:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 31d:	89 f2                	mov    %esi,%edx
 31f:	8d 72 ff             	lea    -0x1(%edx),%esi
 322:	85 d2                	test   %edx,%edx
 324:	7f ec                	jg     312 <memmove+0x12>
  return vdst;
}
 326:	5b                   	pop    %ebx
 327:	5e                   	pop    %esi
 328:	5d                   	pop    %ebp
 329:	c3                   	ret    

0000032a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32a:	b8 01 00 00 00       	mov    $0x1,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <exit>:
SYSCALL(exit)
 332:	b8 02 00 00 00       	mov    $0x2,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <wait>:
SYSCALL(wait)
 33a:	b8 03 00 00 00       	mov    $0x3,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <pipe>:
SYSCALL(pipe)
 342:	b8 04 00 00 00       	mov    $0x4,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <read>:
SYSCALL(read)
 34a:	b8 05 00 00 00       	mov    $0x5,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <write>:
SYSCALL(write)
 352:	b8 10 00 00 00       	mov    $0x10,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <close>:
SYSCALL(close)
 35a:	b8 15 00 00 00       	mov    $0x15,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <kill>:
SYSCALL(kill)
 362:	b8 06 00 00 00       	mov    $0x6,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <exec>:
SYSCALL(exec)
 36a:	b8 07 00 00 00       	mov    $0x7,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <open>:
SYSCALL(open)
 372:	b8 0f 00 00 00       	mov    $0xf,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <mknod>:
SYSCALL(mknod)
 37a:	b8 11 00 00 00       	mov    $0x11,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <unlink>:
SYSCALL(unlink)
 382:	b8 12 00 00 00       	mov    $0x12,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <fstat>:
SYSCALL(fstat)
 38a:	b8 08 00 00 00       	mov    $0x8,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <link>:
SYSCALL(link)
 392:	b8 13 00 00 00       	mov    $0x13,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <mkdir>:
SYSCALL(mkdir)
 39a:	b8 14 00 00 00       	mov    $0x14,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <chdir>:
SYSCALL(chdir)
 3a2:	b8 09 00 00 00       	mov    $0x9,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <dup>:
SYSCALL(dup)
 3aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <getpid>:
SYSCALL(getpid)
 3b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <sbrk>:
SYSCALL(sbrk)
 3ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <sleep>:
SYSCALL(sleep)
 3c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <uptime>:
SYSCALL(uptime)
 3ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <fork2>:
SYSCALL(fork2)
 3d2:	b8 18 00 00 00       	mov    $0x18,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <getpri>:
SYSCALL(getpri)
 3da:	b8 17 00 00 00       	mov    $0x17,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <setpri>:
SYSCALL(setpri)
 3e2:	b8 16 00 00 00       	mov    $0x16,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <getpinfo>:
SYSCALL(getpinfo)
 3ea:	b8 19 00 00 00       	mov    $0x19,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f2:	55                   	push   %ebp
 3f3:	89 e5                	mov    %esp,%ebp
 3f5:	83 ec 1c             	sub    $0x1c,%esp
 3f8:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 3fb:	6a 01                	push   $0x1
 3fd:	8d 55 f4             	lea    -0xc(%ebp),%edx
 400:	52                   	push   %edx
 401:	50                   	push   %eax
 402:	e8 4b ff ff ff       	call   352 <write>
}
 407:	83 c4 10             	add    $0x10,%esp
 40a:	c9                   	leave  
 40b:	c3                   	ret    

0000040c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 40c:	55                   	push   %ebp
 40d:	89 e5                	mov    %esp,%ebp
 40f:	57                   	push   %edi
 410:	56                   	push   %esi
 411:	53                   	push   %ebx
 412:	83 ec 2c             	sub    $0x2c,%esp
 415:	89 c7                	mov    %eax,%edi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 417:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 41b:	0f 95 c3             	setne  %bl
 41e:	89 d0                	mov    %edx,%eax
 420:	c1 e8 1f             	shr    $0x1f,%eax
 423:	84 c3                	test   %al,%bl
 425:	74 10                	je     437 <printint+0x2b>
    neg = 1;
    x = -xx;
 427:	f7 da                	neg    %edx
    neg = 1;
 429:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 430:	be 00 00 00 00       	mov    $0x0,%esi
 435:	eb 0b                	jmp    442 <printint+0x36>
  neg = 0;
 437:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 43e:	eb f0                	jmp    430 <printint+0x24>
  do{
    buf[i++] = digits[x % base];
 440:	89 c6                	mov    %eax,%esi
 442:	89 d0                	mov    %edx,%eax
 444:	ba 00 00 00 00       	mov    $0x0,%edx
 449:	f7 f1                	div    %ecx
 44b:	89 c3                	mov    %eax,%ebx
 44d:	8d 46 01             	lea    0x1(%esi),%eax
 450:	0f b6 92 b4 07 00 00 	movzbl 0x7b4(%edx),%edx
 457:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
  }while((x /= base) != 0);
 45b:	89 da                	mov    %ebx,%edx
 45d:	85 db                	test   %ebx,%ebx
 45f:	75 df                	jne    440 <printint+0x34>
 461:	89 c3                	mov    %eax,%ebx
  if(neg)
 463:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 467:	74 16                	je     47f <printint+0x73>
    buf[i++] = '-';
 469:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 46e:	8d 5e 02             	lea    0x2(%esi),%ebx
 471:	eb 0c                	jmp    47f <printint+0x73>

  while(--i >= 0)
    putc(fd, buf[i]);
 473:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 478:	89 f8                	mov    %edi,%eax
 47a:	e8 73 ff ff ff       	call   3f2 <putc>
  while(--i >= 0)
 47f:	83 eb 01             	sub    $0x1,%ebx
 482:	79 ef                	jns    473 <printint+0x67>
}
 484:	83 c4 2c             	add    $0x2c,%esp
 487:	5b                   	pop    %ebx
 488:	5e                   	pop    %esi
 489:	5f                   	pop    %edi
 48a:	5d                   	pop    %ebp
 48b:	c3                   	ret    

0000048c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 48c:	55                   	push   %ebp
 48d:	89 e5                	mov    %esp,%ebp
 48f:	57                   	push   %edi
 490:	56                   	push   %esi
 491:	53                   	push   %ebx
 492:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 495:	8d 45 10             	lea    0x10(%ebp),%eax
 498:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 49b:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 4a0:	bb 00 00 00 00       	mov    $0x0,%ebx
 4a5:	eb 14                	jmp    4bb <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4a7:	89 fa                	mov    %edi,%edx
 4a9:	8b 45 08             	mov    0x8(%ebp),%eax
 4ac:	e8 41 ff ff ff       	call   3f2 <putc>
 4b1:	eb 05                	jmp    4b8 <printf+0x2c>
      }
    } else if(state == '%'){
 4b3:	83 fe 25             	cmp    $0x25,%esi
 4b6:	74 25                	je     4dd <printf+0x51>
  for(i = 0; fmt[i]; i++){
 4b8:	83 c3 01             	add    $0x1,%ebx
 4bb:	8b 45 0c             	mov    0xc(%ebp),%eax
 4be:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 4c2:	84 c0                	test   %al,%al
 4c4:	0f 84 23 01 00 00    	je     5ed <printf+0x161>
    c = fmt[i] & 0xff;
 4ca:	0f be f8             	movsbl %al,%edi
 4cd:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 4d0:	85 f6                	test   %esi,%esi
 4d2:	75 df                	jne    4b3 <printf+0x27>
      if(c == '%'){
 4d4:	83 f8 25             	cmp    $0x25,%eax
 4d7:	75 ce                	jne    4a7 <printf+0x1b>
        state = '%';
 4d9:	89 c6                	mov    %eax,%esi
 4db:	eb db                	jmp    4b8 <printf+0x2c>
      if(c == 'd'){
 4dd:	83 f8 64             	cmp    $0x64,%eax
 4e0:	74 49                	je     52b <printf+0x9f>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4e2:	83 f8 78             	cmp    $0x78,%eax
 4e5:	0f 94 c1             	sete   %cl
 4e8:	83 f8 70             	cmp    $0x70,%eax
 4eb:	0f 94 c2             	sete   %dl
 4ee:	08 d1                	or     %dl,%cl
 4f0:	75 63                	jne    555 <printf+0xc9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4f2:	83 f8 73             	cmp    $0x73,%eax
 4f5:	0f 84 84 00 00 00    	je     57f <printf+0xf3>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4fb:	83 f8 63             	cmp    $0x63,%eax
 4fe:	0f 84 b7 00 00 00    	je     5bb <printf+0x12f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 504:	83 f8 25             	cmp    $0x25,%eax
 507:	0f 84 cc 00 00 00    	je     5d9 <printf+0x14d>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 50d:	ba 25 00 00 00       	mov    $0x25,%edx
 512:	8b 45 08             	mov    0x8(%ebp),%eax
 515:	e8 d8 fe ff ff       	call   3f2 <putc>
        putc(fd, c);
 51a:	89 fa                	mov    %edi,%edx
 51c:	8b 45 08             	mov    0x8(%ebp),%eax
 51f:	e8 ce fe ff ff       	call   3f2 <putc>
      }
      state = 0;
 524:	be 00 00 00 00       	mov    $0x0,%esi
 529:	eb 8d                	jmp    4b8 <printf+0x2c>
        printint(fd, *ap, 10, 1);
 52b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 52e:	8b 17                	mov    (%edi),%edx
 530:	83 ec 0c             	sub    $0xc,%esp
 533:	6a 01                	push   $0x1
 535:	b9 0a 00 00 00       	mov    $0xa,%ecx
 53a:	8b 45 08             	mov    0x8(%ebp),%eax
 53d:	e8 ca fe ff ff       	call   40c <printint>
        ap++;
 542:	83 c7 04             	add    $0x4,%edi
 545:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 548:	83 c4 10             	add    $0x10,%esp
      state = 0;
 54b:	be 00 00 00 00       	mov    $0x0,%esi
 550:	e9 63 ff ff ff       	jmp    4b8 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 555:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 558:	8b 17                	mov    (%edi),%edx
 55a:	83 ec 0c             	sub    $0xc,%esp
 55d:	6a 00                	push   $0x0
 55f:	b9 10 00 00 00       	mov    $0x10,%ecx
 564:	8b 45 08             	mov    0x8(%ebp),%eax
 567:	e8 a0 fe ff ff       	call   40c <printint>
        ap++;
 56c:	83 c7 04             	add    $0x4,%edi
 56f:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 572:	83 c4 10             	add    $0x10,%esp
      state = 0;
 575:	be 00 00 00 00       	mov    $0x0,%esi
 57a:	e9 39 ff ff ff       	jmp    4b8 <printf+0x2c>
        s = (char*)*ap;
 57f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 582:	8b 30                	mov    (%eax),%esi
        ap++;
 584:	83 c0 04             	add    $0x4,%eax
 587:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 58a:	85 f6                	test   %esi,%esi
 58c:	75 28                	jne    5b6 <printf+0x12a>
          s = "(null)";
 58e:	be aa 07 00 00       	mov    $0x7aa,%esi
 593:	8b 7d 08             	mov    0x8(%ebp),%edi
 596:	eb 0d                	jmp    5a5 <printf+0x119>
          putc(fd, *s);
 598:	0f be d2             	movsbl %dl,%edx
 59b:	89 f8                	mov    %edi,%eax
 59d:	e8 50 fe ff ff       	call   3f2 <putc>
          s++;
 5a2:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 5a5:	0f b6 16             	movzbl (%esi),%edx
 5a8:	84 d2                	test   %dl,%dl
 5aa:	75 ec                	jne    598 <printf+0x10c>
      state = 0;
 5ac:	be 00 00 00 00       	mov    $0x0,%esi
 5b1:	e9 02 ff ff ff       	jmp    4b8 <printf+0x2c>
 5b6:	8b 7d 08             	mov    0x8(%ebp),%edi
 5b9:	eb ea                	jmp    5a5 <printf+0x119>
        putc(fd, *ap);
 5bb:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 5be:	0f be 17             	movsbl (%edi),%edx
 5c1:	8b 45 08             	mov    0x8(%ebp),%eax
 5c4:	e8 29 fe ff ff       	call   3f2 <putc>
        ap++;
 5c9:	83 c7 04             	add    $0x4,%edi
 5cc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 5cf:	be 00 00 00 00       	mov    $0x0,%esi
 5d4:	e9 df fe ff ff       	jmp    4b8 <printf+0x2c>
        putc(fd, c);
 5d9:	89 fa                	mov    %edi,%edx
 5db:	8b 45 08             	mov    0x8(%ebp),%eax
 5de:	e8 0f fe ff ff       	call   3f2 <putc>
      state = 0;
 5e3:	be 00 00 00 00       	mov    $0x0,%esi
 5e8:	e9 cb fe ff ff       	jmp    4b8 <printf+0x2c>
    }
  }
}
 5ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f0:	5b                   	pop    %ebx
 5f1:	5e                   	pop    %esi
 5f2:	5f                   	pop    %edi
 5f3:	5d                   	pop    %ebp
 5f4:	c3                   	ret    

000005f5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f5:	55                   	push   %ebp
 5f6:	89 e5                	mov    %esp,%ebp
 5f8:	57                   	push   %edi
 5f9:	56                   	push   %esi
 5fa:	53                   	push   %ebx
 5fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	a1 58 0a 00 00       	mov    0xa58,%eax
 606:	eb 02                	jmp    60a <free+0x15>
 608:	89 d0                	mov    %edx,%eax
 60a:	39 c8                	cmp    %ecx,%eax
 60c:	73 04                	jae    612 <free+0x1d>
 60e:	39 08                	cmp    %ecx,(%eax)
 610:	77 12                	ja     624 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 612:	8b 10                	mov    (%eax),%edx
 614:	39 c2                	cmp    %eax,%edx
 616:	77 f0                	ja     608 <free+0x13>
 618:	39 c8                	cmp    %ecx,%eax
 61a:	72 08                	jb     624 <free+0x2f>
 61c:	39 ca                	cmp    %ecx,%edx
 61e:	77 04                	ja     624 <free+0x2f>
 620:	89 d0                	mov    %edx,%eax
 622:	eb e6                	jmp    60a <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 624:	8b 73 fc             	mov    -0x4(%ebx),%esi
 627:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 62a:	8b 10                	mov    (%eax),%edx
 62c:	39 d7                	cmp    %edx,%edi
 62e:	74 19                	je     649 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 630:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 633:	8b 50 04             	mov    0x4(%eax),%edx
 636:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 639:	39 ce                	cmp    %ecx,%esi
 63b:	74 1b                	je     658 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 63d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 63f:	a3 58 0a 00 00       	mov    %eax,0xa58
}
 644:	5b                   	pop    %ebx
 645:	5e                   	pop    %esi
 646:	5f                   	pop    %edi
 647:	5d                   	pop    %ebp
 648:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 649:	03 72 04             	add    0x4(%edx),%esi
 64c:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 64f:	8b 10                	mov    (%eax),%edx
 651:	8b 12                	mov    (%edx),%edx
 653:	89 53 f8             	mov    %edx,-0x8(%ebx)
 656:	eb db                	jmp    633 <free+0x3e>
    p->s.size += bp->s.size;
 658:	03 53 fc             	add    -0x4(%ebx),%edx
 65b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 65e:	8b 53 f8             	mov    -0x8(%ebx),%edx
 661:	89 10                	mov    %edx,(%eax)
 663:	eb da                	jmp    63f <free+0x4a>

00000665 <morecore>:

static Header*
morecore(uint nu)
{
 665:	55                   	push   %ebp
 666:	89 e5                	mov    %esp,%ebp
 668:	53                   	push   %ebx
 669:	83 ec 04             	sub    $0x4,%esp
 66c:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 66e:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 673:	77 05                	ja     67a <morecore+0x15>
    nu = 4096;
 675:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 67a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 681:	83 ec 0c             	sub    $0xc,%esp
 684:	50                   	push   %eax
 685:	e8 30 fd ff ff       	call   3ba <sbrk>
  if(p == (char*)-1)
 68a:	83 c4 10             	add    $0x10,%esp
 68d:	83 f8 ff             	cmp    $0xffffffff,%eax
 690:	74 1c                	je     6ae <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 692:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 695:	83 c0 08             	add    $0x8,%eax
 698:	83 ec 0c             	sub    $0xc,%esp
 69b:	50                   	push   %eax
 69c:	e8 54 ff ff ff       	call   5f5 <free>
  return freep;
 6a1:	a1 58 0a 00 00       	mov    0xa58,%eax
 6a6:	83 c4 10             	add    $0x10,%esp
}
 6a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6ac:	c9                   	leave  
 6ad:	c3                   	ret    
    return 0;
 6ae:	b8 00 00 00 00       	mov    $0x0,%eax
 6b3:	eb f4                	jmp    6a9 <morecore+0x44>

000006b5 <malloc>:

void*
malloc(uint nbytes)
{
 6b5:	55                   	push   %ebp
 6b6:	89 e5                	mov    %esp,%ebp
 6b8:	53                   	push   %ebx
 6b9:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6bc:	8b 45 08             	mov    0x8(%ebp),%eax
 6bf:	8d 58 07             	lea    0x7(%eax),%ebx
 6c2:	c1 eb 03             	shr    $0x3,%ebx
 6c5:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 6c8:	8b 0d 58 0a 00 00    	mov    0xa58,%ecx
 6ce:	85 c9                	test   %ecx,%ecx
 6d0:	74 04                	je     6d6 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d2:	8b 01                	mov    (%ecx),%eax
 6d4:	eb 4d                	jmp    723 <malloc+0x6e>
    base.s.ptr = freep = prevp = &base;
 6d6:	c7 05 58 0a 00 00 5c 	movl   $0xa5c,0xa58
 6dd:	0a 00 00 
 6e0:	c7 05 5c 0a 00 00 5c 	movl   $0xa5c,0xa5c
 6e7:	0a 00 00 
    base.s.size = 0;
 6ea:	c7 05 60 0a 00 00 00 	movl   $0x0,0xa60
 6f1:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 6f4:	b9 5c 0a 00 00       	mov    $0xa5c,%ecx
 6f9:	eb d7                	jmp    6d2 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6fb:	39 da                	cmp    %ebx,%edx
 6fd:	74 1a                	je     719 <malloc+0x64>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6ff:	29 da                	sub    %ebx,%edx
 701:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 704:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 707:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 70a:	89 0d 58 0a 00 00    	mov    %ecx,0xa58
      return (void*)(p + 1);
 710:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 713:	83 c4 04             	add    $0x4,%esp
 716:	5b                   	pop    %ebx
 717:	5d                   	pop    %ebp
 718:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 719:	8b 10                	mov    (%eax),%edx
 71b:	89 11                	mov    %edx,(%ecx)
 71d:	eb eb                	jmp    70a <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 71f:	89 c1                	mov    %eax,%ecx
 721:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 723:	8b 50 04             	mov    0x4(%eax),%edx
 726:	39 da                	cmp    %ebx,%edx
 728:	73 d1                	jae    6fb <malloc+0x46>
    if(p == freep)
 72a:	39 05 58 0a 00 00    	cmp    %eax,0xa58
 730:	75 ed                	jne    71f <malloc+0x6a>
      if((p = morecore(nunits)) == 0)
 732:	89 d8                	mov    %ebx,%eax
 734:	e8 2c ff ff ff       	call   665 <morecore>
 739:	85 c0                	test   %eax,%eax
 73b:	75 e2                	jne    71f <malloc+0x6a>
        return 0;
 73d:	b8 00 00 00 00       	mov    $0x0,%eax
 742:	eb cf                	jmp    713 <malloc+0x5e>