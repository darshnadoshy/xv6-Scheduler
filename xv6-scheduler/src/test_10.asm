
_test_10:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#endif


int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	81 ec 10 0c 00 00    	sub    $0xc10,%esp
  struct pstat st;
  check(getpinfo(&st) == 0, "getpinfo");
  14:	8d 85 f8 f3 ff ff    	lea    -0xc08(%ebp),%eax
  1a:	50                   	push   %eax
  1b:	e8 a9 02 00 00       	call   2c9 <getpinfo>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	75 29                	jne    50 <main+0x50>

  int fret;

  fret = fork2(-1);
  27:	83 ec 0c             	sub    $0xc,%esp
  2a:	6a ff                	push   $0xffffffff
  2c:	e8 80 02 00 00       	call   2b1 <fork2>

  //int pri = getpri(fret);
  if( fret == -1){
  31:	83 c4 10             	add    $0x10,%esp
  34:	83 f8 ff             	cmp    $0xffffffff,%eax
  37:	74 37                	je     70 <main+0x70>
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
  } else{
    printf(1, "XV6_SCHEDULER\t fork2 FAILED to return correct error code\n");
  39:	83 ec 08             	sub    $0x8,%esp
  3c:	68 80 06 00 00       	push   $0x680
  41:	6a 01                	push   $0x1
  43:	e8 23 03 00 00       	call   36b <printf>
  48:	83 c4 10             	add    $0x10,%esp
  }
  
  exit();
  4b:	e8 c1 01 00 00       	call   211 <exit>
  check(getpinfo(&st) == 0, "getpinfo");
  50:	83 ec 0c             	sub    $0xc,%esp
  53:	68 24 06 00 00       	push   $0x624
  58:	6a 17                	push   $0x17
  5a:	68 2d 06 00 00       	push   $0x62d
  5f:	68 50 06 00 00       	push   $0x650
  64:	6a 01                	push   $0x1
  66:	e8 00 03 00 00       	call   36b <printf>
  6b:	83 c4 20             	add    $0x20,%esp
  6e:	eb b7                	jmp    27 <main+0x27>
    printf(1, "XV6_SCHEDULER\t SUCCESS\n");
  70:	83 ec 08             	sub    $0x8,%esp
  73:	68 37 06 00 00       	push   $0x637
  78:	6a 01                	push   $0x1
  7a:	e8 ec 02 00 00       	call   36b <printf>
  7f:	83 c4 10             	add    $0x10,%esp
  82:	eb c7                	jmp    4b <main+0x4b>

00000084 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	53                   	push   %ebx
  88:	8b 45 08             	mov    0x8(%ebp),%eax
  8b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8e:	89 c2                	mov    %eax,%edx
  90:	0f b6 19             	movzbl (%ecx),%ebx
  93:	88 1a                	mov    %bl,(%edx)
  95:	8d 52 01             	lea    0x1(%edx),%edx
  98:	8d 49 01             	lea    0x1(%ecx),%ecx
  9b:	84 db                	test   %bl,%bl
  9d:	75 f1                	jne    90 <strcpy+0xc>
    ;
  return os;
}
  9f:	5b                   	pop    %ebx
  a0:	5d                   	pop    %ebp
  a1:	c3                   	ret    

000000a2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a2:	55                   	push   %ebp
  a3:	89 e5                	mov    %esp,%ebp
  a5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  ab:	eb 06                	jmp    b3 <strcmp+0x11>
    p++, q++;
  ad:	83 c1 01             	add    $0x1,%ecx
  b0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  b3:	0f b6 01             	movzbl (%ecx),%eax
  b6:	84 c0                	test   %al,%al
  b8:	74 04                	je     be <strcmp+0x1c>
  ba:	3a 02                	cmp    (%edx),%al
  bc:	74 ef                	je     ad <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
  be:	0f b6 c0             	movzbl %al,%eax
  c1:	0f b6 12             	movzbl (%edx),%edx
  c4:	29 d0                	sub    %edx,%eax
}
  c6:	5d                   	pop    %ebp
  c7:	c3                   	ret    

000000c8 <strlen>:

uint
strlen(const char *s)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ce:	ba 00 00 00 00       	mov    $0x0,%edx
  d3:	eb 03                	jmp    d8 <strlen+0x10>
  d5:	83 c2 01             	add    $0x1,%edx
  d8:	89 d0                	mov    %edx,%eax
  da:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  de:	75 f5                	jne    d5 <strlen+0xd>
    ;
  return n;
}
  e0:	5d                   	pop    %ebp
  e1:	c3                   	ret    

000000e2 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e2:	55                   	push   %ebp
  e3:	89 e5                	mov    %esp,%ebp
  e5:	57                   	push   %edi
  e6:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e9:	89 d7                	mov    %edx,%edi
  eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  f1:	fc                   	cld    
  f2:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f4:	89 d0                	mov    %edx,%eax
  f6:	5f                   	pop    %edi
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    

000000f9 <strchr>:

char*
strchr(const char *s, char c)
{
  f9:	55                   	push   %ebp
  fa:	89 e5                	mov    %esp,%ebp
  fc:	8b 45 08             	mov    0x8(%ebp),%eax
  ff:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 103:	0f b6 10             	movzbl (%eax),%edx
 106:	84 d2                	test   %dl,%dl
 108:	74 09                	je     113 <strchr+0x1a>
    if(*s == c)
 10a:	38 ca                	cmp    %cl,%dl
 10c:	74 0a                	je     118 <strchr+0x1f>
  for(; *s; s++)
 10e:	83 c0 01             	add    $0x1,%eax
 111:	eb f0                	jmp    103 <strchr+0xa>
      return (char*)s;
  return 0;
 113:	b8 00 00 00 00       	mov    $0x0,%eax
}
 118:	5d                   	pop    %ebp
 119:	c3                   	ret    

0000011a <gets>:

char*
gets(char *buf, int max)
{
 11a:	55                   	push   %ebp
 11b:	89 e5                	mov    %esp,%ebp
 11d:	57                   	push   %edi
 11e:	56                   	push   %esi
 11f:	53                   	push   %ebx
 120:	83 ec 1c             	sub    $0x1c,%esp
 123:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 126:	bb 00 00 00 00       	mov    $0x0,%ebx
 12b:	8d 73 01             	lea    0x1(%ebx),%esi
 12e:	3b 75 0c             	cmp    0xc(%ebp),%esi
 131:	7d 2e                	jge    161 <gets+0x47>
    cc = read(0, &c, 1);
 133:	83 ec 04             	sub    $0x4,%esp
 136:	6a 01                	push   $0x1
 138:	8d 45 e7             	lea    -0x19(%ebp),%eax
 13b:	50                   	push   %eax
 13c:	6a 00                	push   $0x0
 13e:	e8 e6 00 00 00       	call   229 <read>
    if(cc < 1)
 143:	83 c4 10             	add    $0x10,%esp
 146:	85 c0                	test   %eax,%eax
 148:	7e 17                	jle    161 <gets+0x47>
      break;
    buf[i++] = c;
 14a:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 14e:	88 04 1f             	mov    %al,(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 151:	3c 0a                	cmp    $0xa,%al
 153:	0f 94 c2             	sete   %dl
 156:	3c 0d                	cmp    $0xd,%al
 158:	0f 94 c0             	sete   %al
    buf[i++] = c;
 15b:	89 f3                	mov    %esi,%ebx
    if(c == '\n' || c == '\r')
 15d:	08 c2                	or     %al,%dl
 15f:	74 ca                	je     12b <gets+0x11>
      break;
  }
  buf[i] = '\0';
 161:	c6 04 1f 00          	movb   $0x0,(%edi,%ebx,1)
  return buf;
}
 165:	89 f8                	mov    %edi,%eax
 167:	8d 65 f4             	lea    -0xc(%ebp),%esp
 16a:	5b                   	pop    %ebx
 16b:	5e                   	pop    %esi
 16c:	5f                   	pop    %edi
 16d:	5d                   	pop    %ebp
 16e:	c3                   	ret    

0000016f <stat>:

int
stat(const char *n, struct stat *st)
{
 16f:	55                   	push   %ebp
 170:	89 e5                	mov    %esp,%ebp
 172:	56                   	push   %esi
 173:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 174:	83 ec 08             	sub    $0x8,%esp
 177:	6a 00                	push   $0x0
 179:	ff 75 08             	pushl  0x8(%ebp)
 17c:	e8 d0 00 00 00       	call   251 <open>
  if(fd < 0)
 181:	83 c4 10             	add    $0x10,%esp
 184:	85 c0                	test   %eax,%eax
 186:	78 24                	js     1ac <stat+0x3d>
 188:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 18a:	83 ec 08             	sub    $0x8,%esp
 18d:	ff 75 0c             	pushl  0xc(%ebp)
 190:	50                   	push   %eax
 191:	e8 d3 00 00 00       	call   269 <fstat>
 196:	89 c6                	mov    %eax,%esi
  close(fd);
 198:	89 1c 24             	mov    %ebx,(%esp)
 19b:	e8 99 00 00 00       	call   239 <close>
  return r;
 1a0:	83 c4 10             	add    $0x10,%esp
}
 1a3:	89 f0                	mov    %esi,%eax
 1a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1a8:	5b                   	pop    %ebx
 1a9:	5e                   	pop    %esi
 1aa:	5d                   	pop    %ebp
 1ab:	c3                   	ret    
    return -1;
 1ac:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1b1:	eb f0                	jmp    1a3 <stat+0x34>

000001b3 <atoi>:

int
atoi(const char *s)
{
 1b3:	55                   	push   %ebp
 1b4:	89 e5                	mov    %esp,%ebp
 1b6:	53                   	push   %ebx
 1b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 1ba:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 1bf:	eb 10                	jmp    1d1 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 1c1:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
 1c4:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
 1c7:	83 c1 01             	add    $0x1,%ecx
 1ca:	0f be d2             	movsbl %dl,%edx
 1cd:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  while('0' <= *s && *s <= '9')
 1d1:	0f b6 11             	movzbl (%ecx),%edx
 1d4:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1d7:	80 fb 09             	cmp    $0x9,%bl
 1da:	76 e5                	jbe    1c1 <atoi+0xe>
  return n;
}
 1dc:	5b                   	pop    %ebx
 1dd:	5d                   	pop    %ebp
 1de:	c3                   	ret    

000001df <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1df:	55                   	push   %ebp
 1e0:	89 e5                	mov    %esp,%ebp
 1e2:	56                   	push   %esi
 1e3:	53                   	push   %ebx
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
 1e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ea:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 1ed:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 1ef:	eb 0d                	jmp    1fe <memmove+0x1f>
    *dst++ = *src++;
 1f1:	0f b6 13             	movzbl (%ebx),%edx
 1f4:	88 11                	mov    %dl,(%ecx)
 1f6:	8d 5b 01             	lea    0x1(%ebx),%ebx
 1f9:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 1fc:	89 f2                	mov    %esi,%edx
 1fe:	8d 72 ff             	lea    -0x1(%edx),%esi
 201:	85 d2                	test   %edx,%edx
 203:	7f ec                	jg     1f1 <memmove+0x12>
  return vdst;
}
 205:	5b                   	pop    %ebx
 206:	5e                   	pop    %esi
 207:	5d                   	pop    %ebp
 208:	c3                   	ret    

00000209 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 209:	b8 01 00 00 00       	mov    $0x1,%eax
 20e:	cd 40                	int    $0x40
 210:	c3                   	ret    

00000211 <exit>:
SYSCALL(exit)
 211:	b8 02 00 00 00       	mov    $0x2,%eax
 216:	cd 40                	int    $0x40
 218:	c3                   	ret    

00000219 <wait>:
SYSCALL(wait)
 219:	b8 03 00 00 00       	mov    $0x3,%eax
 21e:	cd 40                	int    $0x40
 220:	c3                   	ret    

00000221 <pipe>:
SYSCALL(pipe)
 221:	b8 04 00 00 00       	mov    $0x4,%eax
 226:	cd 40                	int    $0x40
 228:	c3                   	ret    

00000229 <read>:
SYSCALL(read)
 229:	b8 05 00 00 00       	mov    $0x5,%eax
 22e:	cd 40                	int    $0x40
 230:	c3                   	ret    

00000231 <write>:
SYSCALL(write)
 231:	b8 10 00 00 00       	mov    $0x10,%eax
 236:	cd 40                	int    $0x40
 238:	c3                   	ret    

00000239 <close>:
SYSCALL(close)
 239:	b8 15 00 00 00       	mov    $0x15,%eax
 23e:	cd 40                	int    $0x40
 240:	c3                   	ret    

00000241 <kill>:
SYSCALL(kill)
 241:	b8 06 00 00 00       	mov    $0x6,%eax
 246:	cd 40                	int    $0x40
 248:	c3                   	ret    

00000249 <exec>:
SYSCALL(exec)
 249:	b8 07 00 00 00       	mov    $0x7,%eax
 24e:	cd 40                	int    $0x40
 250:	c3                   	ret    

00000251 <open>:
SYSCALL(open)
 251:	b8 0f 00 00 00       	mov    $0xf,%eax
 256:	cd 40                	int    $0x40
 258:	c3                   	ret    

00000259 <mknod>:
SYSCALL(mknod)
 259:	b8 11 00 00 00       	mov    $0x11,%eax
 25e:	cd 40                	int    $0x40
 260:	c3                   	ret    

00000261 <unlink>:
SYSCALL(unlink)
 261:	b8 12 00 00 00       	mov    $0x12,%eax
 266:	cd 40                	int    $0x40
 268:	c3                   	ret    

00000269 <fstat>:
SYSCALL(fstat)
 269:	b8 08 00 00 00       	mov    $0x8,%eax
 26e:	cd 40                	int    $0x40
 270:	c3                   	ret    

00000271 <link>:
SYSCALL(link)
 271:	b8 13 00 00 00       	mov    $0x13,%eax
 276:	cd 40                	int    $0x40
 278:	c3                   	ret    

00000279 <mkdir>:
SYSCALL(mkdir)
 279:	b8 14 00 00 00       	mov    $0x14,%eax
 27e:	cd 40                	int    $0x40
 280:	c3                   	ret    

00000281 <chdir>:
SYSCALL(chdir)
 281:	b8 09 00 00 00       	mov    $0x9,%eax
 286:	cd 40                	int    $0x40
 288:	c3                   	ret    

00000289 <dup>:
SYSCALL(dup)
 289:	b8 0a 00 00 00       	mov    $0xa,%eax
 28e:	cd 40                	int    $0x40
 290:	c3                   	ret    

00000291 <getpid>:
SYSCALL(getpid)
 291:	b8 0b 00 00 00       	mov    $0xb,%eax
 296:	cd 40                	int    $0x40
 298:	c3                   	ret    

00000299 <sbrk>:
SYSCALL(sbrk)
 299:	b8 0c 00 00 00       	mov    $0xc,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <sleep>:
SYSCALL(sleep)
 2a1:	b8 0d 00 00 00       	mov    $0xd,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <uptime>:
SYSCALL(uptime)
 2a9:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <fork2>:
SYSCALL(fork2)
 2b1:	b8 18 00 00 00       	mov    $0x18,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <getpri>:
SYSCALL(getpri)
 2b9:	b8 17 00 00 00       	mov    $0x17,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <setpri>:
SYSCALL(setpri)
 2c1:	b8 16 00 00 00       	mov    $0x16,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <getpinfo>:
SYSCALL(getpinfo)
 2c9:	b8 19 00 00 00       	mov    $0x19,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 2d1:	55                   	push   %ebp
 2d2:	89 e5                	mov    %esp,%ebp
 2d4:	83 ec 1c             	sub    $0x1c,%esp
 2d7:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 2da:	6a 01                	push   $0x1
 2dc:	8d 55 f4             	lea    -0xc(%ebp),%edx
 2df:	52                   	push   %edx
 2e0:	50                   	push   %eax
 2e1:	e8 4b ff ff ff       	call   231 <write>
}
 2e6:	83 c4 10             	add    $0x10,%esp
 2e9:	c9                   	leave  
 2ea:	c3                   	ret    

000002eb <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 2eb:	55                   	push   %ebp
 2ec:	89 e5                	mov    %esp,%ebp
 2ee:	57                   	push   %edi
 2ef:	56                   	push   %esi
 2f0:	53                   	push   %ebx
 2f1:	83 ec 2c             	sub    $0x2c,%esp
 2f4:	89 c7                	mov    %eax,%edi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2f6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2fa:	0f 95 c3             	setne  %bl
 2fd:	89 d0                	mov    %edx,%eax
 2ff:	c1 e8 1f             	shr    $0x1f,%eax
 302:	84 c3                	test   %al,%bl
 304:	74 10                	je     316 <printint+0x2b>
    neg = 1;
    x = -xx;
 306:	f7 da                	neg    %edx
    neg = 1;
 308:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 30f:	be 00 00 00 00       	mov    $0x0,%esi
 314:	eb 0b                	jmp    321 <printint+0x36>
  neg = 0;
 316:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 31d:	eb f0                	jmp    30f <printint+0x24>
  do{
    buf[i++] = digits[x % base];
 31f:	89 c6                	mov    %eax,%esi
 321:	89 d0                	mov    %edx,%eax
 323:	ba 00 00 00 00       	mov    $0x0,%edx
 328:	f7 f1                	div    %ecx
 32a:	89 c3                	mov    %eax,%ebx
 32c:	8d 46 01             	lea    0x1(%esi),%eax
 32f:	0f b6 92 c4 06 00 00 	movzbl 0x6c4(%edx),%edx
 336:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
  }while((x /= base) != 0);
 33a:	89 da                	mov    %ebx,%edx
 33c:	85 db                	test   %ebx,%ebx
 33e:	75 df                	jne    31f <printint+0x34>
 340:	89 c3                	mov    %eax,%ebx
  if(neg)
 342:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 346:	74 16                	je     35e <printint+0x73>
    buf[i++] = '-';
 348:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 34d:	8d 5e 02             	lea    0x2(%esi),%ebx
 350:	eb 0c                	jmp    35e <printint+0x73>

  while(--i >= 0)
    putc(fd, buf[i]);
 352:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 357:	89 f8                	mov    %edi,%eax
 359:	e8 73 ff ff ff       	call   2d1 <putc>
  while(--i >= 0)
 35e:	83 eb 01             	sub    $0x1,%ebx
 361:	79 ef                	jns    352 <printint+0x67>
}
 363:	83 c4 2c             	add    $0x2c,%esp
 366:	5b                   	pop    %ebx
 367:	5e                   	pop    %esi
 368:	5f                   	pop    %edi
 369:	5d                   	pop    %ebp
 36a:	c3                   	ret    

0000036b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 36b:	55                   	push   %ebp
 36c:	89 e5                	mov    %esp,%ebp
 36e:	57                   	push   %edi
 36f:	56                   	push   %esi
 370:	53                   	push   %ebx
 371:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 374:	8d 45 10             	lea    0x10(%ebp),%eax
 377:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 37a:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 37f:	bb 00 00 00 00       	mov    $0x0,%ebx
 384:	eb 14                	jmp    39a <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 386:	89 fa                	mov    %edi,%edx
 388:	8b 45 08             	mov    0x8(%ebp),%eax
 38b:	e8 41 ff ff ff       	call   2d1 <putc>
 390:	eb 05                	jmp    397 <printf+0x2c>
      }
    } else if(state == '%'){
 392:	83 fe 25             	cmp    $0x25,%esi
 395:	74 25                	je     3bc <printf+0x51>
  for(i = 0; fmt[i]; i++){
 397:	83 c3 01             	add    $0x1,%ebx
 39a:	8b 45 0c             	mov    0xc(%ebp),%eax
 39d:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 3a1:	84 c0                	test   %al,%al
 3a3:	0f 84 23 01 00 00    	je     4cc <printf+0x161>
    c = fmt[i] & 0xff;
 3a9:	0f be f8             	movsbl %al,%edi
 3ac:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 3af:	85 f6                	test   %esi,%esi
 3b1:	75 df                	jne    392 <printf+0x27>
      if(c == '%'){
 3b3:	83 f8 25             	cmp    $0x25,%eax
 3b6:	75 ce                	jne    386 <printf+0x1b>
        state = '%';
 3b8:	89 c6                	mov    %eax,%esi
 3ba:	eb db                	jmp    397 <printf+0x2c>
      if(c == 'd'){
 3bc:	83 f8 64             	cmp    $0x64,%eax
 3bf:	74 49                	je     40a <printf+0x9f>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3c1:	83 f8 78             	cmp    $0x78,%eax
 3c4:	0f 94 c1             	sete   %cl
 3c7:	83 f8 70             	cmp    $0x70,%eax
 3ca:	0f 94 c2             	sete   %dl
 3cd:	08 d1                	or     %dl,%cl
 3cf:	75 63                	jne    434 <printf+0xc9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3d1:	83 f8 73             	cmp    $0x73,%eax
 3d4:	0f 84 84 00 00 00    	je     45e <printf+0xf3>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3da:	83 f8 63             	cmp    $0x63,%eax
 3dd:	0f 84 b7 00 00 00    	je     49a <printf+0x12f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3e3:	83 f8 25             	cmp    $0x25,%eax
 3e6:	0f 84 cc 00 00 00    	je     4b8 <printf+0x14d>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 3ec:	ba 25 00 00 00       	mov    $0x25,%edx
 3f1:	8b 45 08             	mov    0x8(%ebp),%eax
 3f4:	e8 d8 fe ff ff       	call   2d1 <putc>
        putc(fd, c);
 3f9:	89 fa                	mov    %edi,%edx
 3fb:	8b 45 08             	mov    0x8(%ebp),%eax
 3fe:	e8 ce fe ff ff       	call   2d1 <putc>
      }
      state = 0;
 403:	be 00 00 00 00       	mov    $0x0,%esi
 408:	eb 8d                	jmp    397 <printf+0x2c>
        printint(fd, *ap, 10, 1);
 40a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 40d:	8b 17                	mov    (%edi),%edx
 40f:	83 ec 0c             	sub    $0xc,%esp
 412:	6a 01                	push   $0x1
 414:	b9 0a 00 00 00       	mov    $0xa,%ecx
 419:	8b 45 08             	mov    0x8(%ebp),%eax
 41c:	e8 ca fe ff ff       	call   2eb <printint>
        ap++;
 421:	83 c7 04             	add    $0x4,%edi
 424:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 427:	83 c4 10             	add    $0x10,%esp
      state = 0;
 42a:	be 00 00 00 00       	mov    $0x0,%esi
 42f:	e9 63 ff ff ff       	jmp    397 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 434:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 437:	8b 17                	mov    (%edi),%edx
 439:	83 ec 0c             	sub    $0xc,%esp
 43c:	6a 00                	push   $0x0
 43e:	b9 10 00 00 00       	mov    $0x10,%ecx
 443:	8b 45 08             	mov    0x8(%ebp),%eax
 446:	e8 a0 fe ff ff       	call   2eb <printint>
        ap++;
 44b:	83 c7 04             	add    $0x4,%edi
 44e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 451:	83 c4 10             	add    $0x10,%esp
      state = 0;
 454:	be 00 00 00 00       	mov    $0x0,%esi
 459:	e9 39 ff ff ff       	jmp    397 <printf+0x2c>
        s = (char*)*ap;
 45e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 461:	8b 30                	mov    (%eax),%esi
        ap++;
 463:	83 c0 04             	add    $0x4,%eax
 466:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 469:	85 f6                	test   %esi,%esi
 46b:	75 28                	jne    495 <printf+0x12a>
          s = "(null)";
 46d:	be bc 06 00 00       	mov    $0x6bc,%esi
 472:	8b 7d 08             	mov    0x8(%ebp),%edi
 475:	eb 0d                	jmp    484 <printf+0x119>
          putc(fd, *s);
 477:	0f be d2             	movsbl %dl,%edx
 47a:	89 f8                	mov    %edi,%eax
 47c:	e8 50 fe ff ff       	call   2d1 <putc>
          s++;
 481:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 484:	0f b6 16             	movzbl (%esi),%edx
 487:	84 d2                	test   %dl,%dl
 489:	75 ec                	jne    477 <printf+0x10c>
      state = 0;
 48b:	be 00 00 00 00       	mov    $0x0,%esi
 490:	e9 02 ff ff ff       	jmp    397 <printf+0x2c>
 495:	8b 7d 08             	mov    0x8(%ebp),%edi
 498:	eb ea                	jmp    484 <printf+0x119>
        putc(fd, *ap);
 49a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 49d:	0f be 17             	movsbl (%edi),%edx
 4a0:	8b 45 08             	mov    0x8(%ebp),%eax
 4a3:	e8 29 fe ff ff       	call   2d1 <putc>
        ap++;
 4a8:	83 c7 04             	add    $0x4,%edi
 4ab:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 4ae:	be 00 00 00 00       	mov    $0x0,%esi
 4b3:	e9 df fe ff ff       	jmp    397 <printf+0x2c>
        putc(fd, c);
 4b8:	89 fa                	mov    %edi,%edx
 4ba:	8b 45 08             	mov    0x8(%ebp),%eax
 4bd:	e8 0f fe ff ff       	call   2d1 <putc>
      state = 0;
 4c2:	be 00 00 00 00       	mov    $0x0,%esi
 4c7:	e9 cb fe ff ff       	jmp    397 <printf+0x2c>
    }
  }
}
 4cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4cf:	5b                   	pop    %ebx
 4d0:	5e                   	pop    %esi
 4d1:	5f                   	pop    %edi
 4d2:	5d                   	pop    %ebp
 4d3:	c3                   	ret    

000004d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4d4:	55                   	push   %ebp
 4d5:	89 e5                	mov    %esp,%ebp
 4d7:	57                   	push   %edi
 4d8:	56                   	push   %esi
 4d9:	53                   	push   %ebx
 4da:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4dd:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4e0:	a1 5c 09 00 00       	mov    0x95c,%eax
 4e5:	eb 02                	jmp    4e9 <free+0x15>
 4e7:	89 d0                	mov    %edx,%eax
 4e9:	39 c8                	cmp    %ecx,%eax
 4eb:	73 04                	jae    4f1 <free+0x1d>
 4ed:	39 08                	cmp    %ecx,(%eax)
 4ef:	77 12                	ja     503 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4f1:	8b 10                	mov    (%eax),%edx
 4f3:	39 c2                	cmp    %eax,%edx
 4f5:	77 f0                	ja     4e7 <free+0x13>
 4f7:	39 c8                	cmp    %ecx,%eax
 4f9:	72 08                	jb     503 <free+0x2f>
 4fb:	39 ca                	cmp    %ecx,%edx
 4fd:	77 04                	ja     503 <free+0x2f>
 4ff:	89 d0                	mov    %edx,%eax
 501:	eb e6                	jmp    4e9 <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 503:	8b 73 fc             	mov    -0x4(%ebx),%esi
 506:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 509:	8b 10                	mov    (%eax),%edx
 50b:	39 d7                	cmp    %edx,%edi
 50d:	74 19                	je     528 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 50f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 512:	8b 50 04             	mov    0x4(%eax),%edx
 515:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 518:	39 ce                	cmp    %ecx,%esi
 51a:	74 1b                	je     537 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 51c:	89 08                	mov    %ecx,(%eax)
  freep = p;
 51e:	a3 5c 09 00 00       	mov    %eax,0x95c
}
 523:	5b                   	pop    %ebx
 524:	5e                   	pop    %esi
 525:	5f                   	pop    %edi
 526:	5d                   	pop    %ebp
 527:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 528:	03 72 04             	add    0x4(%edx),%esi
 52b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 52e:	8b 10                	mov    (%eax),%edx
 530:	8b 12                	mov    (%edx),%edx
 532:	89 53 f8             	mov    %edx,-0x8(%ebx)
 535:	eb db                	jmp    512 <free+0x3e>
    p->s.size += bp->s.size;
 537:	03 53 fc             	add    -0x4(%ebx),%edx
 53a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 53d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 540:	89 10                	mov    %edx,(%eax)
 542:	eb da                	jmp    51e <free+0x4a>

00000544 <morecore>:

static Header*
morecore(uint nu)
{
 544:	55                   	push   %ebp
 545:	89 e5                	mov    %esp,%ebp
 547:	53                   	push   %ebx
 548:	83 ec 04             	sub    $0x4,%esp
 54b:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 54d:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 552:	77 05                	ja     559 <morecore+0x15>
    nu = 4096;
 554:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 559:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	50                   	push   %eax
 564:	e8 30 fd ff ff       	call   299 <sbrk>
  if(p == (char*)-1)
 569:	83 c4 10             	add    $0x10,%esp
 56c:	83 f8 ff             	cmp    $0xffffffff,%eax
 56f:	74 1c                	je     58d <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 571:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 574:	83 c0 08             	add    $0x8,%eax
 577:	83 ec 0c             	sub    $0xc,%esp
 57a:	50                   	push   %eax
 57b:	e8 54 ff ff ff       	call   4d4 <free>
  return freep;
 580:	a1 5c 09 00 00       	mov    0x95c,%eax
 585:	83 c4 10             	add    $0x10,%esp
}
 588:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 58b:	c9                   	leave  
 58c:	c3                   	ret    
    return 0;
 58d:	b8 00 00 00 00       	mov    $0x0,%eax
 592:	eb f4                	jmp    588 <morecore+0x44>

00000594 <malloc>:

void*
malloc(uint nbytes)
{
 594:	55                   	push   %ebp
 595:	89 e5                	mov    %esp,%ebp
 597:	53                   	push   %ebx
 598:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 59b:	8b 45 08             	mov    0x8(%ebp),%eax
 59e:	8d 58 07             	lea    0x7(%eax),%ebx
 5a1:	c1 eb 03             	shr    $0x3,%ebx
 5a4:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5a7:	8b 0d 5c 09 00 00    	mov    0x95c,%ecx
 5ad:	85 c9                	test   %ecx,%ecx
 5af:	74 04                	je     5b5 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5b1:	8b 01                	mov    (%ecx),%eax
 5b3:	eb 4d                	jmp    602 <malloc+0x6e>
    base.s.ptr = freep = prevp = &base;
 5b5:	c7 05 5c 09 00 00 60 	movl   $0x960,0x95c
 5bc:	09 00 00 
 5bf:	c7 05 60 09 00 00 60 	movl   $0x960,0x960
 5c6:	09 00 00 
    base.s.size = 0;
 5c9:	c7 05 64 09 00 00 00 	movl   $0x0,0x964
 5d0:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 5d3:	b9 60 09 00 00       	mov    $0x960,%ecx
 5d8:	eb d7                	jmp    5b1 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 5da:	39 da                	cmp    %ebx,%edx
 5dc:	74 1a                	je     5f8 <malloc+0x64>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5de:	29 da                	sub    %ebx,%edx
 5e0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 5e3:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 5e6:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 5e9:	89 0d 5c 09 00 00    	mov    %ecx,0x95c
      return (void*)(p + 1);
 5ef:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5f2:	83 c4 04             	add    $0x4,%esp
 5f5:	5b                   	pop    %ebx
 5f6:	5d                   	pop    %ebp
 5f7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 5f8:	8b 10                	mov    (%eax),%edx
 5fa:	89 11                	mov    %edx,(%ecx)
 5fc:	eb eb                	jmp    5e9 <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5fe:	89 c1                	mov    %eax,%ecx
 600:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 602:	8b 50 04             	mov    0x4(%eax),%edx
 605:	39 da                	cmp    %ebx,%edx
 607:	73 d1                	jae    5da <malloc+0x46>
    if(p == freep)
 609:	39 05 5c 09 00 00    	cmp    %eax,0x95c
 60f:	75 ed                	jne    5fe <malloc+0x6a>
      if((p = morecore(nunits)) == 0)
 611:	89 d8                	mov    %ebx,%eax
 613:	e8 2c ff ff ff       	call   544 <morecore>
 618:	85 c0                	test   %eax,%eax
 61a:	75 e2                	jne    5fe <malloc+0x6a>
        return 0;
 61c:	b8 00 00 00 00       	mov    $0x0,%eax
 621:	eb cf                	jmp    5f2 <malloc+0x5e>
