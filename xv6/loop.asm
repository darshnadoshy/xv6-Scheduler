
_loop:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "syscall.h"


int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  for(int i = 0; i < 10; i++)
   f:	bb 00 00 00 00       	mov    $0x0,%ebx
  14:	eb 10                	jmp    26 <main+0x26>
  {
  	sleep(0.10);
  16:	83 ec 0c             	sub    $0xc,%esp
  19:	6a 00                	push   $0x0
  1b:	e8 42 02 00 00       	call   262 <sleep>
  for(int i = 0; i < 10; i++)
  20:	83 c3 01             	add    $0x1,%ebx
  23:	83 c4 10             	add    $0x10,%esp
  26:	83 fb 09             	cmp    $0x9,%ebx
  29:	7e eb                	jle    16 <main+0x16>
  }
  printf(1,"%d\n", getpid());
  2b:	e8 22 02 00 00       	call   252 <getpid>
  30:	83 ec 04             	sub    $0x4,%esp
  33:	50                   	push   %eax
  34:	68 e4 05 00 00       	push   $0x5e4
  39:	6a 01                	push   $0x1
  3b:	e8 ec 02 00 00       	call   32c <printf>
  exit();
  40:	e8 8d 01 00 00       	call   1d2 <exit>

00000045 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  45:	55                   	push   %ebp
  46:	89 e5                	mov    %esp,%ebp
  48:	53                   	push   %ebx
  49:	8b 45 08             	mov    0x8(%ebp),%eax
  4c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  4f:	89 c2                	mov    %eax,%edx
  51:	0f b6 19             	movzbl (%ecx),%ebx
  54:	88 1a                	mov    %bl,(%edx)
  56:	8d 52 01             	lea    0x1(%edx),%edx
  59:	8d 49 01             	lea    0x1(%ecx),%ecx
  5c:	84 db                	test   %bl,%bl
  5e:	75 f1                	jne    51 <strcpy+0xc>
    ;
  return os;
}
  60:	5b                   	pop    %ebx
  61:	5d                   	pop    %ebp
  62:	c3                   	ret    

00000063 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  63:	55                   	push   %ebp
  64:	89 e5                	mov    %esp,%ebp
  66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  69:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  6c:	eb 06                	jmp    74 <strcmp+0x11>
    p++, q++;
  6e:	83 c1 01             	add    $0x1,%ecx
  71:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  74:	0f b6 01             	movzbl (%ecx),%eax
  77:	84 c0                	test   %al,%al
  79:	74 04                	je     7f <strcmp+0x1c>
  7b:	3a 02                	cmp    (%edx),%al
  7d:	74 ef                	je     6e <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
  7f:	0f b6 c0             	movzbl %al,%eax
  82:	0f b6 12             	movzbl (%edx),%edx
  85:	29 d0                	sub    %edx,%eax
}
  87:	5d                   	pop    %ebp
  88:	c3                   	ret    

00000089 <strlen>:

uint
strlen(const char *s)
{
  89:	55                   	push   %ebp
  8a:	89 e5                	mov    %esp,%ebp
  8c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  8f:	ba 00 00 00 00       	mov    $0x0,%edx
  94:	eb 03                	jmp    99 <strlen+0x10>
  96:	83 c2 01             	add    $0x1,%edx
  99:	89 d0                	mov    %edx,%eax
  9b:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  9f:	75 f5                	jne    96 <strlen+0xd>
    ;
  return n;
}
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    

000000a3 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a3:	55                   	push   %ebp
  a4:	89 e5                	mov    %esp,%ebp
  a6:	57                   	push   %edi
  a7:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  aa:	89 d7                	mov    %edx,%edi
  ac:	8b 4d 10             	mov    0x10(%ebp),%ecx
  af:	8b 45 0c             	mov    0xc(%ebp),%eax
  b2:	fc                   	cld    
  b3:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  b5:	89 d0                	mov    %edx,%eax
  b7:	5f                   	pop    %edi
  b8:	5d                   	pop    %ebp
  b9:	c3                   	ret    

000000ba <strchr>:

char*
strchr(const char *s, char c)
{
  ba:	55                   	push   %ebp
  bb:	89 e5                	mov    %esp,%ebp
  bd:	8b 45 08             	mov    0x8(%ebp),%eax
  c0:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  c4:	0f b6 10             	movzbl (%eax),%edx
  c7:	84 d2                	test   %dl,%dl
  c9:	74 09                	je     d4 <strchr+0x1a>
    if(*s == c)
  cb:	38 ca                	cmp    %cl,%dl
  cd:	74 0a                	je     d9 <strchr+0x1f>
  for(; *s; s++)
  cf:	83 c0 01             	add    $0x1,%eax
  d2:	eb f0                	jmp    c4 <strchr+0xa>
      return (char*)s;
  return 0;
  d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  d9:	5d                   	pop    %ebp
  da:	c3                   	ret    

000000db <gets>:

char*
gets(char *buf, int max)
{
  db:	55                   	push   %ebp
  dc:	89 e5                	mov    %esp,%ebp
  de:	57                   	push   %edi
  df:	56                   	push   %esi
  e0:	53                   	push   %ebx
  e1:	83 ec 1c             	sub    $0x1c,%esp
  e4:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  e7:	bb 00 00 00 00       	mov    $0x0,%ebx
  ec:	8d 73 01             	lea    0x1(%ebx),%esi
  ef:	3b 75 0c             	cmp    0xc(%ebp),%esi
  f2:	7d 2e                	jge    122 <gets+0x47>
    cc = read(0, &c, 1);
  f4:	83 ec 04             	sub    $0x4,%esp
  f7:	6a 01                	push   $0x1
  f9:	8d 45 e7             	lea    -0x19(%ebp),%eax
  fc:	50                   	push   %eax
  fd:	6a 00                	push   $0x0
  ff:	e8 e6 00 00 00       	call   1ea <read>
    if(cc < 1)
 104:	83 c4 10             	add    $0x10,%esp
 107:	85 c0                	test   %eax,%eax
 109:	7e 17                	jle    122 <gets+0x47>
      break;
    buf[i++] = c;
 10b:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 10f:	88 04 1f             	mov    %al,(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 112:	3c 0a                	cmp    $0xa,%al
 114:	0f 94 c2             	sete   %dl
 117:	3c 0d                	cmp    $0xd,%al
 119:	0f 94 c0             	sete   %al
    buf[i++] = c;
 11c:	89 f3                	mov    %esi,%ebx
    if(c == '\n' || c == '\r')
 11e:	08 c2                	or     %al,%dl
 120:	74 ca                	je     ec <gets+0x11>
      break;
  }
  buf[i] = '\0';
 122:	c6 04 1f 00          	movb   $0x0,(%edi,%ebx,1)
  return buf;
}
 126:	89 f8                	mov    %edi,%eax
 128:	8d 65 f4             	lea    -0xc(%ebp),%esp
 12b:	5b                   	pop    %ebx
 12c:	5e                   	pop    %esi
 12d:	5f                   	pop    %edi
 12e:	5d                   	pop    %ebp
 12f:	c3                   	ret    

00000130 <stat>:

int
stat(const char *n, struct stat *st)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	56                   	push   %esi
 134:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 135:	83 ec 08             	sub    $0x8,%esp
 138:	6a 00                	push   $0x0
 13a:	ff 75 08             	pushl  0x8(%ebp)
 13d:	e8 d0 00 00 00       	call   212 <open>
  if(fd < 0)
 142:	83 c4 10             	add    $0x10,%esp
 145:	85 c0                	test   %eax,%eax
 147:	78 24                	js     16d <stat+0x3d>
 149:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 14b:	83 ec 08             	sub    $0x8,%esp
 14e:	ff 75 0c             	pushl  0xc(%ebp)
 151:	50                   	push   %eax
 152:	e8 d3 00 00 00       	call   22a <fstat>
 157:	89 c6                	mov    %eax,%esi
  close(fd);
 159:	89 1c 24             	mov    %ebx,(%esp)
 15c:	e8 99 00 00 00       	call   1fa <close>
  return r;
 161:	83 c4 10             	add    $0x10,%esp
}
 164:	89 f0                	mov    %esi,%eax
 166:	8d 65 f8             	lea    -0x8(%ebp),%esp
 169:	5b                   	pop    %ebx
 16a:	5e                   	pop    %esi
 16b:	5d                   	pop    %ebp
 16c:	c3                   	ret    
    return -1;
 16d:	be ff ff ff ff       	mov    $0xffffffff,%esi
 172:	eb f0                	jmp    164 <stat+0x34>

00000174 <atoi>:

int
atoi(const char *s)
{
 174:	55                   	push   %ebp
 175:	89 e5                	mov    %esp,%ebp
 177:	53                   	push   %ebx
 178:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 17b:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 180:	eb 10                	jmp    192 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 182:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
 185:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
 188:	83 c1 01             	add    $0x1,%ecx
 18b:	0f be d2             	movsbl %dl,%edx
 18e:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  while('0' <= *s && *s <= '9')
 192:	0f b6 11             	movzbl (%ecx),%edx
 195:	8d 5a d0             	lea    -0x30(%edx),%ebx
 198:	80 fb 09             	cmp    $0x9,%bl
 19b:	76 e5                	jbe    182 <atoi+0xe>
  return n;
}
 19d:	5b                   	pop    %ebx
 19e:	5d                   	pop    %ebp
 19f:	c3                   	ret    

000001a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	56                   	push   %esi
 1a4:	53                   	push   %ebx
 1a5:	8b 45 08             	mov    0x8(%ebp),%eax
 1a8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ab:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 1ae:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 1b0:	eb 0d                	jmp    1bf <memmove+0x1f>
    *dst++ = *src++;
 1b2:	0f b6 13             	movzbl (%ebx),%edx
 1b5:	88 11                	mov    %dl,(%ecx)
 1b7:	8d 5b 01             	lea    0x1(%ebx),%ebx
 1ba:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 1bd:	89 f2                	mov    %esi,%edx
 1bf:	8d 72 ff             	lea    -0x1(%edx),%esi
 1c2:	85 d2                	test   %edx,%edx
 1c4:	7f ec                	jg     1b2 <memmove+0x12>
  return vdst;
}
 1c6:	5b                   	pop    %ebx
 1c7:	5e                   	pop    %esi
 1c8:	5d                   	pop    %ebp
 1c9:	c3                   	ret    

000001ca <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1ca:	b8 01 00 00 00       	mov    $0x1,%eax
 1cf:	cd 40                	int    $0x40
 1d1:	c3                   	ret    

000001d2 <exit>:
SYSCALL(exit)
 1d2:	b8 02 00 00 00       	mov    $0x2,%eax
 1d7:	cd 40                	int    $0x40
 1d9:	c3                   	ret    

000001da <wait>:
SYSCALL(wait)
 1da:	b8 03 00 00 00       	mov    $0x3,%eax
 1df:	cd 40                	int    $0x40
 1e1:	c3                   	ret    

000001e2 <pipe>:
SYSCALL(pipe)
 1e2:	b8 04 00 00 00       	mov    $0x4,%eax
 1e7:	cd 40                	int    $0x40
 1e9:	c3                   	ret    

000001ea <read>:
SYSCALL(read)
 1ea:	b8 05 00 00 00       	mov    $0x5,%eax
 1ef:	cd 40                	int    $0x40
 1f1:	c3                   	ret    

000001f2 <write>:
SYSCALL(write)
 1f2:	b8 10 00 00 00       	mov    $0x10,%eax
 1f7:	cd 40                	int    $0x40
 1f9:	c3                   	ret    

000001fa <close>:
SYSCALL(close)
 1fa:	b8 15 00 00 00       	mov    $0x15,%eax
 1ff:	cd 40                	int    $0x40
 201:	c3                   	ret    

00000202 <kill>:
SYSCALL(kill)
 202:	b8 06 00 00 00       	mov    $0x6,%eax
 207:	cd 40                	int    $0x40
 209:	c3                   	ret    

0000020a <exec>:
SYSCALL(exec)
 20a:	b8 07 00 00 00       	mov    $0x7,%eax
 20f:	cd 40                	int    $0x40
 211:	c3                   	ret    

00000212 <open>:
SYSCALL(open)
 212:	b8 0f 00 00 00       	mov    $0xf,%eax
 217:	cd 40                	int    $0x40
 219:	c3                   	ret    

0000021a <mknod>:
SYSCALL(mknod)
 21a:	b8 11 00 00 00       	mov    $0x11,%eax
 21f:	cd 40                	int    $0x40
 221:	c3                   	ret    

00000222 <unlink>:
SYSCALL(unlink)
 222:	b8 12 00 00 00       	mov    $0x12,%eax
 227:	cd 40                	int    $0x40
 229:	c3                   	ret    

0000022a <fstat>:
SYSCALL(fstat)
 22a:	b8 08 00 00 00       	mov    $0x8,%eax
 22f:	cd 40                	int    $0x40
 231:	c3                   	ret    

00000232 <link>:
SYSCALL(link)
 232:	b8 13 00 00 00       	mov    $0x13,%eax
 237:	cd 40                	int    $0x40
 239:	c3                   	ret    

0000023a <mkdir>:
SYSCALL(mkdir)
 23a:	b8 14 00 00 00       	mov    $0x14,%eax
 23f:	cd 40                	int    $0x40
 241:	c3                   	ret    

00000242 <chdir>:
SYSCALL(chdir)
 242:	b8 09 00 00 00       	mov    $0x9,%eax
 247:	cd 40                	int    $0x40
 249:	c3                   	ret    

0000024a <dup>:
SYSCALL(dup)
 24a:	b8 0a 00 00 00       	mov    $0xa,%eax
 24f:	cd 40                	int    $0x40
 251:	c3                   	ret    

00000252 <getpid>:
SYSCALL(getpid)
 252:	b8 0b 00 00 00       	mov    $0xb,%eax
 257:	cd 40                	int    $0x40
 259:	c3                   	ret    

0000025a <sbrk>:
SYSCALL(sbrk)
 25a:	b8 0c 00 00 00       	mov    $0xc,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <sleep>:
SYSCALL(sleep)
 262:	b8 0d 00 00 00       	mov    $0xd,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <uptime>:
SYSCALL(uptime)
 26a:	b8 0e 00 00 00       	mov    $0xe,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <fork2>:
SYSCALL(fork2)
 272:	b8 18 00 00 00       	mov    $0x18,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <getpri>:
SYSCALL(getpri)
 27a:	b8 17 00 00 00       	mov    $0x17,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <setpri>:
SYSCALL(setpri)
 282:	b8 16 00 00 00       	mov    $0x16,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <getpinfo>:
SYSCALL(getpinfo)
 28a:	b8 19 00 00 00       	mov    $0x19,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 292:	55                   	push   %ebp
 293:	89 e5                	mov    %esp,%ebp
 295:	83 ec 1c             	sub    $0x1c,%esp
 298:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 29b:	6a 01                	push   $0x1
 29d:	8d 55 f4             	lea    -0xc(%ebp),%edx
 2a0:	52                   	push   %edx
 2a1:	50                   	push   %eax
 2a2:	e8 4b ff ff ff       	call   1f2 <write>
}
 2a7:	83 c4 10             	add    $0x10,%esp
 2aa:	c9                   	leave  
 2ab:	c3                   	ret    

000002ac <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 2ac:	55                   	push   %ebp
 2ad:	89 e5                	mov    %esp,%ebp
 2af:	57                   	push   %edi
 2b0:	56                   	push   %esi
 2b1:	53                   	push   %ebx
 2b2:	83 ec 2c             	sub    $0x2c,%esp
 2b5:	89 c7                	mov    %eax,%edi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2bb:	0f 95 c3             	setne  %bl
 2be:	89 d0                	mov    %edx,%eax
 2c0:	c1 e8 1f             	shr    $0x1f,%eax
 2c3:	84 c3                	test   %al,%bl
 2c5:	74 10                	je     2d7 <printint+0x2b>
    neg = 1;
    x = -xx;
 2c7:	f7 da                	neg    %edx
    neg = 1;
 2c9:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2d0:	be 00 00 00 00       	mov    $0x0,%esi
 2d5:	eb 0b                	jmp    2e2 <printint+0x36>
  neg = 0;
 2d7:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 2de:	eb f0                	jmp    2d0 <printint+0x24>
  do{
    buf[i++] = digits[x % base];
 2e0:	89 c6                	mov    %eax,%esi
 2e2:	89 d0                	mov    %edx,%eax
 2e4:	ba 00 00 00 00       	mov    $0x0,%edx
 2e9:	f7 f1                	div    %ecx
 2eb:	89 c3                	mov    %eax,%ebx
 2ed:	8d 46 01             	lea    0x1(%esi),%eax
 2f0:	0f b6 92 f0 05 00 00 	movzbl 0x5f0(%edx),%edx
 2f7:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
  }while((x /= base) != 0);
 2fb:	89 da                	mov    %ebx,%edx
 2fd:	85 db                	test   %ebx,%ebx
 2ff:	75 df                	jne    2e0 <printint+0x34>
 301:	89 c3                	mov    %eax,%ebx
  if(neg)
 303:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 307:	74 16                	je     31f <printint+0x73>
    buf[i++] = '-';
 309:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 30e:	8d 5e 02             	lea    0x2(%esi),%ebx
 311:	eb 0c                	jmp    31f <printint+0x73>

  while(--i >= 0)
    putc(fd, buf[i]);
 313:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 318:	89 f8                	mov    %edi,%eax
 31a:	e8 73 ff ff ff       	call   292 <putc>
  while(--i >= 0)
 31f:	83 eb 01             	sub    $0x1,%ebx
 322:	79 ef                	jns    313 <printint+0x67>
}
 324:	83 c4 2c             	add    $0x2c,%esp
 327:	5b                   	pop    %ebx
 328:	5e                   	pop    %esi
 329:	5f                   	pop    %edi
 32a:	5d                   	pop    %ebp
 32b:	c3                   	ret    

0000032c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 32c:	55                   	push   %ebp
 32d:	89 e5                	mov    %esp,%ebp
 32f:	57                   	push   %edi
 330:	56                   	push   %esi
 331:	53                   	push   %ebx
 332:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 335:	8d 45 10             	lea    0x10(%ebp),%eax
 338:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 33b:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 340:	bb 00 00 00 00       	mov    $0x0,%ebx
 345:	eb 14                	jmp    35b <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 347:	89 fa                	mov    %edi,%edx
 349:	8b 45 08             	mov    0x8(%ebp),%eax
 34c:	e8 41 ff ff ff       	call   292 <putc>
 351:	eb 05                	jmp    358 <printf+0x2c>
      }
    } else if(state == '%'){
 353:	83 fe 25             	cmp    $0x25,%esi
 356:	74 25                	je     37d <printf+0x51>
  for(i = 0; fmt[i]; i++){
 358:	83 c3 01             	add    $0x1,%ebx
 35b:	8b 45 0c             	mov    0xc(%ebp),%eax
 35e:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 362:	84 c0                	test   %al,%al
 364:	0f 84 23 01 00 00    	je     48d <printf+0x161>
    c = fmt[i] & 0xff;
 36a:	0f be f8             	movsbl %al,%edi
 36d:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 370:	85 f6                	test   %esi,%esi
 372:	75 df                	jne    353 <printf+0x27>
      if(c == '%'){
 374:	83 f8 25             	cmp    $0x25,%eax
 377:	75 ce                	jne    347 <printf+0x1b>
        state = '%';
 379:	89 c6                	mov    %eax,%esi
 37b:	eb db                	jmp    358 <printf+0x2c>
      if(c == 'd'){
 37d:	83 f8 64             	cmp    $0x64,%eax
 380:	74 49                	je     3cb <printf+0x9f>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 382:	83 f8 78             	cmp    $0x78,%eax
 385:	0f 94 c1             	sete   %cl
 388:	83 f8 70             	cmp    $0x70,%eax
 38b:	0f 94 c2             	sete   %dl
 38e:	08 d1                	or     %dl,%cl
 390:	75 63                	jne    3f5 <printf+0xc9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 392:	83 f8 73             	cmp    $0x73,%eax
 395:	0f 84 84 00 00 00    	je     41f <printf+0xf3>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 39b:	83 f8 63             	cmp    $0x63,%eax
 39e:	0f 84 b7 00 00 00    	je     45b <printf+0x12f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3a4:	83 f8 25             	cmp    $0x25,%eax
 3a7:	0f 84 cc 00 00 00    	je     479 <printf+0x14d>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 3ad:	ba 25 00 00 00       	mov    $0x25,%edx
 3b2:	8b 45 08             	mov    0x8(%ebp),%eax
 3b5:	e8 d8 fe ff ff       	call   292 <putc>
        putc(fd, c);
 3ba:	89 fa                	mov    %edi,%edx
 3bc:	8b 45 08             	mov    0x8(%ebp),%eax
 3bf:	e8 ce fe ff ff       	call   292 <putc>
      }
      state = 0;
 3c4:	be 00 00 00 00       	mov    $0x0,%esi
 3c9:	eb 8d                	jmp    358 <printf+0x2c>
        printint(fd, *ap, 10, 1);
 3cb:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3ce:	8b 17                	mov    (%edi),%edx
 3d0:	83 ec 0c             	sub    $0xc,%esp
 3d3:	6a 01                	push   $0x1
 3d5:	b9 0a 00 00 00       	mov    $0xa,%ecx
 3da:	8b 45 08             	mov    0x8(%ebp),%eax
 3dd:	e8 ca fe ff ff       	call   2ac <printint>
        ap++;
 3e2:	83 c7 04             	add    $0x4,%edi
 3e5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 3e8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 3eb:	be 00 00 00 00       	mov    $0x0,%esi
 3f0:	e9 63 ff ff ff       	jmp    358 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 3f5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 3f8:	8b 17                	mov    (%edi),%edx
 3fa:	83 ec 0c             	sub    $0xc,%esp
 3fd:	6a 00                	push   $0x0
 3ff:	b9 10 00 00 00       	mov    $0x10,%ecx
 404:	8b 45 08             	mov    0x8(%ebp),%eax
 407:	e8 a0 fe ff ff       	call   2ac <printint>
        ap++;
 40c:	83 c7 04             	add    $0x4,%edi
 40f:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 412:	83 c4 10             	add    $0x10,%esp
      state = 0;
 415:	be 00 00 00 00       	mov    $0x0,%esi
 41a:	e9 39 ff ff ff       	jmp    358 <printf+0x2c>
        s = (char*)*ap;
 41f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 422:	8b 30                	mov    (%eax),%esi
        ap++;
 424:	83 c0 04             	add    $0x4,%eax
 427:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 42a:	85 f6                	test   %esi,%esi
 42c:	75 28                	jne    456 <printf+0x12a>
          s = "(null)";
 42e:	be e8 05 00 00       	mov    $0x5e8,%esi
 433:	8b 7d 08             	mov    0x8(%ebp),%edi
 436:	eb 0d                	jmp    445 <printf+0x119>
          putc(fd, *s);
 438:	0f be d2             	movsbl %dl,%edx
 43b:	89 f8                	mov    %edi,%eax
 43d:	e8 50 fe ff ff       	call   292 <putc>
          s++;
 442:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 445:	0f b6 16             	movzbl (%esi),%edx
 448:	84 d2                	test   %dl,%dl
 44a:	75 ec                	jne    438 <printf+0x10c>
      state = 0;
 44c:	be 00 00 00 00       	mov    $0x0,%esi
 451:	e9 02 ff ff ff       	jmp    358 <printf+0x2c>
 456:	8b 7d 08             	mov    0x8(%ebp),%edi
 459:	eb ea                	jmp    445 <printf+0x119>
        putc(fd, *ap);
 45b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 45e:	0f be 17             	movsbl (%edi),%edx
 461:	8b 45 08             	mov    0x8(%ebp),%eax
 464:	e8 29 fe ff ff       	call   292 <putc>
        ap++;
 469:	83 c7 04             	add    $0x4,%edi
 46c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 46f:	be 00 00 00 00       	mov    $0x0,%esi
 474:	e9 df fe ff ff       	jmp    358 <printf+0x2c>
        putc(fd, c);
 479:	89 fa                	mov    %edi,%edx
 47b:	8b 45 08             	mov    0x8(%ebp),%eax
 47e:	e8 0f fe ff ff       	call   292 <putc>
      state = 0;
 483:	be 00 00 00 00       	mov    $0x0,%esi
 488:	e9 cb fe ff ff       	jmp    358 <printf+0x2c>
    }
  }
}
 48d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 490:	5b                   	pop    %ebx
 491:	5e                   	pop    %esi
 492:	5f                   	pop    %edi
 493:	5d                   	pop    %ebp
 494:	c3                   	ret    

00000495 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 495:	55                   	push   %ebp
 496:	89 e5                	mov    %esp,%ebp
 498:	57                   	push   %edi
 499:	56                   	push   %esi
 49a:	53                   	push   %ebx
 49b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 49e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4a1:	a1 8c 08 00 00       	mov    0x88c,%eax
 4a6:	eb 02                	jmp    4aa <free+0x15>
 4a8:	89 d0                	mov    %edx,%eax
 4aa:	39 c8                	cmp    %ecx,%eax
 4ac:	73 04                	jae    4b2 <free+0x1d>
 4ae:	39 08                	cmp    %ecx,(%eax)
 4b0:	77 12                	ja     4c4 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4b2:	8b 10                	mov    (%eax),%edx
 4b4:	39 c2                	cmp    %eax,%edx
 4b6:	77 f0                	ja     4a8 <free+0x13>
 4b8:	39 c8                	cmp    %ecx,%eax
 4ba:	72 08                	jb     4c4 <free+0x2f>
 4bc:	39 ca                	cmp    %ecx,%edx
 4be:	77 04                	ja     4c4 <free+0x2f>
 4c0:	89 d0                	mov    %edx,%eax
 4c2:	eb e6                	jmp    4aa <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 4c4:	8b 73 fc             	mov    -0x4(%ebx),%esi
 4c7:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 4ca:	8b 10                	mov    (%eax),%edx
 4cc:	39 d7                	cmp    %edx,%edi
 4ce:	74 19                	je     4e9 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 4d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 4d3:	8b 50 04             	mov    0x4(%eax),%edx
 4d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 4d9:	39 ce                	cmp    %ecx,%esi
 4db:	74 1b                	je     4f8 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 4dd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 4df:	a3 8c 08 00 00       	mov    %eax,0x88c
}
 4e4:	5b                   	pop    %ebx
 4e5:	5e                   	pop    %esi
 4e6:	5f                   	pop    %edi
 4e7:	5d                   	pop    %ebp
 4e8:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 4e9:	03 72 04             	add    0x4(%edx),%esi
 4ec:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 4ef:	8b 10                	mov    (%eax),%edx
 4f1:	8b 12                	mov    (%edx),%edx
 4f3:	89 53 f8             	mov    %edx,-0x8(%ebx)
 4f6:	eb db                	jmp    4d3 <free+0x3e>
    p->s.size += bp->s.size;
 4f8:	03 53 fc             	add    -0x4(%ebx),%edx
 4fb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 4fe:	8b 53 f8             	mov    -0x8(%ebx),%edx
 501:	89 10                	mov    %edx,(%eax)
 503:	eb da                	jmp    4df <free+0x4a>

00000505 <morecore>:

static Header*
morecore(uint nu)
{
 505:	55                   	push   %ebp
 506:	89 e5                	mov    %esp,%ebp
 508:	53                   	push   %ebx
 509:	83 ec 04             	sub    $0x4,%esp
 50c:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 50e:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 513:	77 05                	ja     51a <morecore+0x15>
    nu = 4096;
 515:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 51a:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 521:	83 ec 0c             	sub    $0xc,%esp
 524:	50                   	push   %eax
 525:	e8 30 fd ff ff       	call   25a <sbrk>
  if(p == (char*)-1)
 52a:	83 c4 10             	add    $0x10,%esp
 52d:	83 f8 ff             	cmp    $0xffffffff,%eax
 530:	74 1c                	je     54e <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 532:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 535:	83 c0 08             	add    $0x8,%eax
 538:	83 ec 0c             	sub    $0xc,%esp
 53b:	50                   	push   %eax
 53c:	e8 54 ff ff ff       	call   495 <free>
  return freep;
 541:	a1 8c 08 00 00       	mov    0x88c,%eax
 546:	83 c4 10             	add    $0x10,%esp
}
 549:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 54c:	c9                   	leave  
 54d:	c3                   	ret    
    return 0;
 54e:	b8 00 00 00 00       	mov    $0x0,%eax
 553:	eb f4                	jmp    549 <morecore+0x44>

00000555 <malloc>:

void*
malloc(uint nbytes)
{
 555:	55                   	push   %ebp
 556:	89 e5                	mov    %esp,%ebp
 558:	53                   	push   %ebx
 559:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 55c:	8b 45 08             	mov    0x8(%ebp),%eax
 55f:	8d 58 07             	lea    0x7(%eax),%ebx
 562:	c1 eb 03             	shr    $0x3,%ebx
 565:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 568:	8b 0d 8c 08 00 00    	mov    0x88c,%ecx
 56e:	85 c9                	test   %ecx,%ecx
 570:	74 04                	je     576 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 572:	8b 01                	mov    (%ecx),%eax
 574:	eb 4d                	jmp    5c3 <malloc+0x6e>
    base.s.ptr = freep = prevp = &base;
 576:	c7 05 8c 08 00 00 90 	movl   $0x890,0x88c
 57d:	08 00 00 
 580:	c7 05 90 08 00 00 90 	movl   $0x890,0x890
 587:	08 00 00 
    base.s.size = 0;
 58a:	c7 05 94 08 00 00 00 	movl   $0x0,0x894
 591:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 594:	b9 90 08 00 00       	mov    $0x890,%ecx
 599:	eb d7                	jmp    572 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 59b:	39 da                	cmp    %ebx,%edx
 59d:	74 1a                	je     5b9 <malloc+0x64>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 59f:	29 da                	sub    %ebx,%edx
 5a1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 5a4:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 5a7:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 5aa:	89 0d 8c 08 00 00    	mov    %ecx,0x88c
      return (void*)(p + 1);
 5b0:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5b3:	83 c4 04             	add    $0x4,%esp
 5b6:	5b                   	pop    %ebx
 5b7:	5d                   	pop    %ebp
 5b8:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 5b9:	8b 10                	mov    (%eax),%edx
 5bb:	89 11                	mov    %edx,(%ecx)
 5bd:	eb eb                	jmp    5aa <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5bf:	89 c1                	mov    %eax,%ecx
 5c1:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 5c3:	8b 50 04             	mov    0x4(%eax),%edx
 5c6:	39 da                	cmp    %ebx,%edx
 5c8:	73 d1                	jae    59b <malloc+0x46>
    if(p == freep)
 5ca:	39 05 8c 08 00 00    	cmp    %eax,0x88c
 5d0:	75 ed                	jne    5bf <malloc+0x6a>
      if((p = morecore(nunits)) == 0)
 5d2:	89 d8                	mov    %ebx,%eax
 5d4:	e8 2c ff ff ff       	call   505 <morecore>
 5d9:	85 c0                	test   %eax,%eax
 5db:	75 e2                	jne    5bf <malloc+0x6a>
        return 0;
 5dd:	b8 00 00 00 00       	mov    $0x0,%eax
 5e2:	eb cf                	jmp    5b3 <malloc+0x5e>
