
_test_11:     file format elf32-i386


Disassembly of section .text:

00000000 <workload>:
#else
# define DEBUG_PRINT(x) do {} while (0)
#endif

//char buf[10000]; // ~10KB
int workload(int n, int t) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	8b 75 08             	mov    0x8(%ebp),%esi
   8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  int i, j = 0;
   b:	bb 00 00 00 00       	mov    $0x0,%ebx
  for (i = 0; i < n; i++) {
  10:	b8 00 00 00 00       	mov    $0x0,%eax
  15:	eb 0c                	jmp    23 <workload+0x23>
    j += i * j + 1;
  17:	89 c2                	mov    %eax,%edx
  19:	0f af d3             	imul   %ebx,%edx
  1c:	8d 5c 1a 01          	lea    0x1(%edx,%ebx,1),%ebx
  for (i = 0; i < n; i++) {
  20:	83 c0 01             	add    $0x1,%eax
  23:	39 f0                	cmp    %esi,%eax
  25:	7c f0                	jl     17 <workload+0x17>
  }

  if (t > 0) sleep(t);
  27:	85 c9                	test   %ecx,%ecx
  29:	7f 07                	jg     32 <workload+0x32>
  for (i = 0; i < n; i++) {
  2b:	b8 00 00 00 00       	mov    $0x0,%eax
  30:	eb 1a                	jmp    4c <workload+0x4c>
  if (t > 0) sleep(t);
  32:	83 ec 0c             	sub    $0xc,%esp
  35:	51                   	push   %ecx
  36:	e8 f8 03 00 00       	call   433 <sleep>
  3b:	83 c4 10             	add    $0x10,%esp
  3e:	eb eb                	jmp    2b <workload+0x2b>
    j += i * j + 1;
  40:	89 c2                	mov    %eax,%edx
  42:	0f af d3             	imul   %ebx,%edx
  45:	8d 5c 1a 01          	lea    0x1(%edx,%ebx,1),%ebx
  for (i = 0; i < n; i++) {
  49:	83 c0 01             	add    $0x1,%eax
  4c:	39 f0                	cmp    %esi,%eax
  4e:	7c f0                	jl     40 <workload+0x40>
  }
  return j;
}
  50:	89 d8                	mov    %ebx,%eax
  52:	8d 65 f8             	lea    -0x8(%ebp),%esp
  55:	5b                   	pop    %ebx
  56:	5e                   	pop    %esi
  57:	5d                   	pop    %ebp
  58:	c3                   	ret    

00000059 <main>:

int
main(int argc, char *argv[])
{
  59:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  5d:	83 e4 f0             	and    $0xfffffff0,%esp
  60:	ff 71 fc             	pushl  -0x4(%ecx)
  63:	55                   	push   %ebp
  64:	89 e5                	mov    %esp,%ebp
  66:	57                   	push   %edi
  67:	56                   	push   %esi
  68:	53                   	push   %ebx
  69:	51                   	push   %ecx
  6a:	81 ec 24 0c 00 00    	sub    $0xc24,%esp
  struct pstat st;
  check(getpinfo(&st) == 0, "getpinfo");
  70:	8d 85 e8 f3 ff ff    	lea    -0xc18(%ebp),%eax
  76:	50                   	push   %eax
  77:	e8 df 03 00 00       	call   45b <getpinfo>
  7c:	83 c4 10             	add    $0x10,%esp
  7f:	85 c0                	test   %eax,%eax
  81:	75 2a                	jne    ad <main+0x54>

  // Push this thread to the bottom
  workload(80000000, 0);
  83:	83 ec 08             	sub    $0x8,%esp
  86:	6a 00                	push   $0x0
  88:	68 00 b4 c4 04       	push   $0x4c4b400
  8d:	e8 6e ff ff ff       	call   0 <workload>

  int i, j, k;

  // Launch the 4 processes, but process 2 will sleep in the middle
  for (i = 0; i < 1; i++) {
  92:	83 c4 10             	add    $0x10,%esp
  95:	bb 00 00 00 00       	mov    $0x0,%ebx
  9a:	85 db                	test   %ebx,%ebx
  9c:	7e 2f                	jle    cd <main+0x74>
    } else {
      //setpri(c_pid, 2);
    }
  }

  for (i = 0; i < 12; i++) { 
  9e:	c7 85 e4 f3 ff ff 00 	movl   $0x0,-0xc1c(%ebp)
  a5:	00 00 00 
  a8:	e9 1a 01 00 00       	jmp    1c7 <main+0x16e>
  check(getpinfo(&st) == 0, "getpinfo");
  ad:	83 ec 0c             	sub    $0xc,%esp
  b0:	68 b8 07 00 00       	push   $0x7b8
  b5:	6a 24                	push   $0x24
  b7:	68 c1 07 00 00       	push   $0x7c1
  bc:	68 ec 07 00 00       	push   $0x7ec
  c1:	6a 01                	push   $0x1
  c3:	e8 35 04 00 00       	call   4fd <printf>
  c8:	83 c4 20             	add    $0x20,%esp
  cb:	eb b6                	jmp    83 <main+0x2a>
    int c_pid = fork2(2);
  cd:	83 ec 0c             	sub    $0xc,%esp
  d0:	6a 02                	push   $0x2
  d2:	e8 6c 03 00 00       	call   443 <fork2>
  d7:	89 c1                	mov    %eax,%ecx
    if (c_pid == 0) {
  d9:	83 c4 10             	add    $0x10,%esp
  dc:	85 c0                	test   %eax,%eax
  de:	74 05                	je     e5 <main+0x8c>
  for (i = 0; i < 1; i++) {
  e0:	83 c3 01             	add    $0x1,%ebx
  e3:	eb b5                	jmp    9a <main+0x41>
      if (i % 2 == 1) {
  e5:	be 02 00 00 00       	mov    $0x2,%esi
  ea:	89 d8                	mov    %ebx,%eax
  ec:	99                   	cltd   
  ed:	f7 fe                	idiv   %esi
  ef:	83 fa 01             	cmp    $0x1,%edx
  f2:	74 13                	je     107 <main+0xae>
      workload(600000000, t);
  f4:	83 ec 08             	sub    $0x8,%esp
  f7:	51                   	push   %ecx
  f8:	68 00 46 c3 23       	push   $0x23c34600
  fd:	e8 fe fe ff ff       	call   0 <workload>
      exit();
 102:	e8 9c 02 00 00       	call   3a3 <exit>
          t = 64*5; // for this process, give up CPU for one time-slice
 107:	b9 40 01 00 00       	mov    $0x140,%ecx
 10c:	eb e6                	jmp    f4 <main+0x9b>
    sleep(12);
    check(getpinfo(&st) == 0, "getpinfo");
 10e:	83 ec 0c             	sub    $0xc,%esp
 111:	68 b8 07 00 00       	push   $0x7b8
 116:	6a 3d                	push   $0x3d
 118:	68 c1 07 00 00       	push   $0x7c1
 11d:	68 ec 07 00 00       	push   $0x7ec
 122:	6a 01                	push   $0x1
 124:	e8 d4 03 00 00       	call   4fd <printf>
 129:	83 c4 20             	add    $0x20,%esp
 12c:	e9 c2 00 00 00       	jmp    1f3 <main+0x19a>
    
    for (j = 0; j < NPROC; j++) {
 131:	83 c3 01             	add    $0x1,%ebx
 134:	83 fb 3f             	cmp    $0x3f,%ebx
 137:	0f 8f 83 00 00 00    	jg     1c0 <main+0x167>
      if (st.inuse[j] && st.pid[j] >= 3 && st.pid[j] != getpid()) {
 13d:	83 bc 9d e8 f3 ff ff 	cmpl   $0x0,-0xc18(%ebp,%ebx,4)
 144:	00 
 145:	74 ea                	je     131 <main+0xd8>
 147:	8b b4 9d e8 f4 ff ff 	mov    -0xb18(%ebp,%ebx,4),%esi
 14e:	83 fe 02             	cmp    $0x2,%esi
 151:	7e de                	jle    131 <main+0xd8>
 153:	e8 cb 02 00 00       	call   423 <getpid>
 158:	39 c6                	cmp    %eax,%esi
 15a:	74 d5                	je     131 <main+0xd8>
	DEBUG_PRINT((1, "XV6_SCHEDULER\t CHILD\n"));
 15c:	83 ec 08             	sub    $0x8,%esp
 15f:	68 cb 07 00 00       	push   $0x7cb
 164:	6a 01                	push   $0x1
 166:	e8 92 03 00 00       	call   4fd <printf>
        DEBUG_PRINT((1, "pid: %d\n", st.pid[j]));
 16b:	83 c4 0c             	add    $0xc,%esp
 16e:	ff b4 9d e8 f4 ff ff 	pushl  -0xb18(%ebp,%ebx,4)
 175:	68 e1 07 00 00       	push   $0x7e1
 17a:	6a 01                	push   $0x1
 17c:	e8 7c 03 00 00       	call   4fd <printf>
        for (k = 3; k >= 0; k--) {
 181:	83 c4 10             	add    $0x10,%esp
 184:	be 03 00 00 00       	mov    $0x3,%esi
 189:	85 f6                	test   %esi,%esi
 18b:	78 a4                	js     131 <main+0xd8>
          DEBUG_PRINT((1, "XV6_SCHEDULER\t \t level %d ticks used %d\n", k, st.ticks[j][k]));
 18d:	8d 3c 9e             	lea    (%esi,%ebx,4),%edi
 190:	ff b4 bd e8 f7 ff ff 	pushl  -0x818(%ebp,%edi,4)
 197:	56                   	push   %esi
 198:	68 1c 08 00 00       	push   $0x81c
 19d:	6a 01                	push   $0x1
 19f:	e8 59 03 00 00       	call   4fd <printf>
	  DEBUG_PRINT((1, "XV6_SCHEDULER\t \t level %d qtail %d\n", k, st.qtail[j][k]));
 1a4:	ff b4 bd e8 fb ff ff 	pushl  -0x418(%ebp,%edi,4)
 1ab:	56                   	push   %esi
 1ac:	68 48 08 00 00       	push   $0x848
 1b1:	6a 01                	push   $0x1
 1b3:	e8 45 03 00 00       	call   4fd <printf>
        for (k = 3; k >= 0; k--) {
 1b8:	83 ee 01             	sub    $0x1,%esi
 1bb:	83 c4 20             	add    $0x20,%esp
 1be:	eb c9                	jmp    189 <main+0x130>
  for (i = 0; i < 12; i++) { 
 1c0:	83 85 e4 f3 ff ff 01 	addl   $0x1,-0xc1c(%ebp)
 1c7:	83 bd e4 f3 ff ff 0b 	cmpl   $0xb,-0xc1c(%ebp)
 1ce:	7f 2d                	jg     1fd <main+0x1a4>
    sleep(12);
 1d0:	83 ec 0c             	sub    $0xc,%esp
 1d3:	6a 0c                	push   $0xc
 1d5:	e8 59 02 00 00       	call   433 <sleep>
    check(getpinfo(&st) == 0, "getpinfo");
 1da:	8d 85 e8 f3 ff ff    	lea    -0xc18(%ebp),%eax
 1e0:	89 04 24             	mov    %eax,(%esp)
 1e3:	e8 73 02 00 00       	call   45b <getpinfo>
 1e8:	83 c4 10             	add    $0x10,%esp
 1eb:	85 c0                	test   %eax,%eax
 1ed:	0f 85 1b ff ff ff    	jne    10e <main+0xb5>
        for (k = 3; k >= 0; k--) {
 1f3:	bb 00 00 00 00       	mov    $0x0,%ebx
 1f8:	e9 37 ff ff ff       	jmp    134 <main+0xdb>
        }
      } 
    }
  }

  for (i = 0; i < 6; i++) {
 1fd:	bb 00 00 00 00       	mov    $0x0,%ebx
 202:	eb 08                	jmp    20c <main+0x1b3>
    wait();
 204:	e8 a2 01 00 00       	call   3ab <wait>
  for (i = 0; i < 6; i++) {
 209:	83 c3 01             	add    $0x1,%ebx
 20c:	83 fb 05             	cmp    $0x5,%ebx
 20f:	7e f3                	jle    204 <main+0x1ab>
  }

  //printf(1, "TEST PASSED");

  exit();
 211:	e8 8d 01 00 00       	call   3a3 <exit>

00000216 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 216:	55                   	push   %ebp
 217:	89 e5                	mov    %esp,%ebp
 219:	53                   	push   %ebx
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 220:	89 c2                	mov    %eax,%edx
 222:	0f b6 19             	movzbl (%ecx),%ebx
 225:	88 1a                	mov    %bl,(%edx)
 227:	8d 52 01             	lea    0x1(%edx),%edx
 22a:	8d 49 01             	lea    0x1(%ecx),%ecx
 22d:	84 db                	test   %bl,%bl
 22f:	75 f1                	jne    222 <strcpy+0xc>
    ;
  return os;
}
 231:	5b                   	pop    %ebx
 232:	5d                   	pop    %ebp
 233:	c3                   	ret    

00000234 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	8b 4d 08             	mov    0x8(%ebp),%ecx
 23a:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 23d:	eb 06                	jmp    245 <strcmp+0x11>
    p++, q++;
 23f:	83 c1 01             	add    $0x1,%ecx
 242:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 245:	0f b6 01             	movzbl (%ecx),%eax
 248:	84 c0                	test   %al,%al
 24a:	74 04                	je     250 <strcmp+0x1c>
 24c:	3a 02                	cmp    (%edx),%al
 24e:	74 ef                	je     23f <strcmp+0xb>
  return (uchar)*p - (uchar)*q;
 250:	0f b6 c0             	movzbl %al,%eax
 253:	0f b6 12             	movzbl (%edx),%edx
 256:	29 d0                	sub    %edx,%eax
}
 258:	5d                   	pop    %ebp
 259:	c3                   	ret    

0000025a <strlen>:

uint
strlen(const char *s)
{
 25a:	55                   	push   %ebp
 25b:	89 e5                	mov    %esp,%ebp
 25d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 260:	ba 00 00 00 00       	mov    $0x0,%edx
 265:	eb 03                	jmp    26a <strlen+0x10>
 267:	83 c2 01             	add    $0x1,%edx
 26a:	89 d0                	mov    %edx,%eax
 26c:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 270:	75 f5                	jne    267 <strlen+0xd>
    ;
  return n;
}
 272:	5d                   	pop    %ebp
 273:	c3                   	ret    

00000274 <memset>:

void*
memset(void *dst, int c, uint n)
{
 274:	55                   	push   %ebp
 275:	89 e5                	mov    %esp,%ebp
 277:	57                   	push   %edi
 278:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 27b:	89 d7                	mov    %edx,%edi
 27d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 280:	8b 45 0c             	mov    0xc(%ebp),%eax
 283:	fc                   	cld    
 284:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 286:	89 d0                	mov    %edx,%eax
 288:	5f                   	pop    %edi
 289:	5d                   	pop    %ebp
 28a:	c3                   	ret    

0000028b <strchr>:

char*
strchr(const char *s, char c)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
 28e:	8b 45 08             	mov    0x8(%ebp),%eax
 291:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 295:	0f b6 10             	movzbl (%eax),%edx
 298:	84 d2                	test   %dl,%dl
 29a:	74 09                	je     2a5 <strchr+0x1a>
    if(*s == c)
 29c:	38 ca                	cmp    %cl,%dl
 29e:	74 0a                	je     2aa <strchr+0x1f>
  for(; *s; s++)
 2a0:	83 c0 01             	add    $0x1,%eax
 2a3:	eb f0                	jmp    295 <strchr+0xa>
      return (char*)s;
  return 0;
 2a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2aa:	5d                   	pop    %ebp
 2ab:	c3                   	ret    

000002ac <gets>:

char*
gets(char *buf, int max)
{
 2ac:	55                   	push   %ebp
 2ad:	89 e5                	mov    %esp,%ebp
 2af:	57                   	push   %edi
 2b0:	56                   	push   %esi
 2b1:	53                   	push   %ebx
 2b2:	83 ec 1c             	sub    $0x1c,%esp
 2b5:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b8:	bb 00 00 00 00       	mov    $0x0,%ebx
 2bd:	8d 73 01             	lea    0x1(%ebx),%esi
 2c0:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2c3:	7d 2e                	jge    2f3 <gets+0x47>
    cc = read(0, &c, 1);
 2c5:	83 ec 04             	sub    $0x4,%esp
 2c8:	6a 01                	push   $0x1
 2ca:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2cd:	50                   	push   %eax
 2ce:	6a 00                	push   $0x0
 2d0:	e8 e6 00 00 00       	call   3bb <read>
    if(cc < 1)
 2d5:	83 c4 10             	add    $0x10,%esp
 2d8:	85 c0                	test   %eax,%eax
 2da:	7e 17                	jle    2f3 <gets+0x47>
      break;
    buf[i++] = c;
 2dc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2e0:	88 04 1f             	mov    %al,(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 2e3:	3c 0a                	cmp    $0xa,%al
 2e5:	0f 94 c2             	sete   %dl
 2e8:	3c 0d                	cmp    $0xd,%al
 2ea:	0f 94 c0             	sete   %al
    buf[i++] = c;
 2ed:	89 f3                	mov    %esi,%ebx
    if(c == '\n' || c == '\r')
 2ef:	08 c2                	or     %al,%dl
 2f1:	74 ca                	je     2bd <gets+0x11>
      break;
  }
  buf[i] = '\0';
 2f3:	c6 04 1f 00          	movb   $0x0,(%edi,%ebx,1)
  return buf;
}
 2f7:	89 f8                	mov    %edi,%eax
 2f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fc:	5b                   	pop    %ebx
 2fd:	5e                   	pop    %esi
 2fe:	5f                   	pop    %edi
 2ff:	5d                   	pop    %ebp
 300:	c3                   	ret    

00000301 <stat>:

int
stat(const char *n, struct stat *st)
{
 301:	55                   	push   %ebp
 302:	89 e5                	mov    %esp,%ebp
 304:	56                   	push   %esi
 305:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 306:	83 ec 08             	sub    $0x8,%esp
 309:	6a 00                	push   $0x0
 30b:	ff 75 08             	pushl  0x8(%ebp)
 30e:	e8 d0 00 00 00       	call   3e3 <open>
  if(fd < 0)
 313:	83 c4 10             	add    $0x10,%esp
 316:	85 c0                	test   %eax,%eax
 318:	78 24                	js     33e <stat+0x3d>
 31a:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 31c:	83 ec 08             	sub    $0x8,%esp
 31f:	ff 75 0c             	pushl  0xc(%ebp)
 322:	50                   	push   %eax
 323:	e8 d3 00 00 00       	call   3fb <fstat>
 328:	89 c6                	mov    %eax,%esi
  close(fd);
 32a:	89 1c 24             	mov    %ebx,(%esp)
 32d:	e8 99 00 00 00       	call   3cb <close>
  return r;
 332:	83 c4 10             	add    $0x10,%esp
}
 335:	89 f0                	mov    %esi,%eax
 337:	8d 65 f8             	lea    -0x8(%ebp),%esp
 33a:	5b                   	pop    %ebx
 33b:	5e                   	pop    %esi
 33c:	5d                   	pop    %ebp
 33d:	c3                   	ret    
    return -1;
 33e:	be ff ff ff ff       	mov    $0xffffffff,%esi
 343:	eb f0                	jmp    335 <stat+0x34>

00000345 <atoi>:

int
atoi(const char *s)
{
 345:	55                   	push   %ebp
 346:	89 e5                	mov    %esp,%ebp
 348:	53                   	push   %ebx
 349:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
 34c:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 351:	eb 10                	jmp    363 <atoi+0x1e>
    n = n*10 + *s++ - '0';
 353:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
 356:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
 359:	83 c1 01             	add    $0x1,%ecx
 35c:	0f be d2             	movsbl %dl,%edx
 35f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  while('0' <= *s && *s <= '9')
 363:	0f b6 11             	movzbl (%ecx),%edx
 366:	8d 5a d0             	lea    -0x30(%edx),%ebx
 369:	80 fb 09             	cmp    $0x9,%bl
 36c:	76 e5                	jbe    353 <atoi+0xe>
  return n;
}
 36e:	5b                   	pop    %ebx
 36f:	5d                   	pop    %ebp
 370:	c3                   	ret    

00000371 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 371:	55                   	push   %ebp
 372:	89 e5                	mov    %esp,%ebp
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
 376:	8b 45 08             	mov    0x8(%ebp),%eax
 379:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 37c:	8b 55 10             	mov    0x10(%ebp),%edx
  char *dst;
  const char *src;

  dst = vdst;
 37f:	89 c1                	mov    %eax,%ecx
  src = vsrc;
  while(n-- > 0)
 381:	eb 0d                	jmp    390 <memmove+0x1f>
    *dst++ = *src++;
 383:	0f b6 13             	movzbl (%ebx),%edx
 386:	88 11                	mov    %dl,(%ecx)
 388:	8d 5b 01             	lea    0x1(%ebx),%ebx
 38b:	8d 49 01             	lea    0x1(%ecx),%ecx
  while(n-- > 0)
 38e:	89 f2                	mov    %esi,%edx
 390:	8d 72 ff             	lea    -0x1(%edx),%esi
 393:	85 d2                	test   %edx,%edx
 395:	7f ec                	jg     383 <memmove+0x12>
  return vdst;
}
 397:	5b                   	pop    %ebx
 398:	5e                   	pop    %esi
 399:	5d                   	pop    %ebp
 39a:	c3                   	ret    

0000039b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 39b:	b8 01 00 00 00       	mov    $0x1,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <exit>:
SYSCALL(exit)
 3a3:	b8 02 00 00 00       	mov    $0x2,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <wait>:
SYSCALL(wait)
 3ab:	b8 03 00 00 00       	mov    $0x3,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <pipe>:
SYSCALL(pipe)
 3b3:	b8 04 00 00 00       	mov    $0x4,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <read>:
SYSCALL(read)
 3bb:	b8 05 00 00 00       	mov    $0x5,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <write>:
SYSCALL(write)
 3c3:	b8 10 00 00 00       	mov    $0x10,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <close>:
SYSCALL(close)
 3cb:	b8 15 00 00 00       	mov    $0x15,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <kill>:
SYSCALL(kill)
 3d3:	b8 06 00 00 00       	mov    $0x6,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <exec>:
SYSCALL(exec)
 3db:	b8 07 00 00 00       	mov    $0x7,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <open>:
SYSCALL(open)
 3e3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <mknod>:
SYSCALL(mknod)
 3eb:	b8 11 00 00 00       	mov    $0x11,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <unlink>:
SYSCALL(unlink)
 3f3:	b8 12 00 00 00       	mov    $0x12,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <fstat>:
SYSCALL(fstat)
 3fb:	b8 08 00 00 00       	mov    $0x8,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <link>:
SYSCALL(link)
 403:	b8 13 00 00 00       	mov    $0x13,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <mkdir>:
SYSCALL(mkdir)
 40b:	b8 14 00 00 00       	mov    $0x14,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <chdir>:
SYSCALL(chdir)
 413:	b8 09 00 00 00       	mov    $0x9,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <dup>:
SYSCALL(dup)
 41b:	b8 0a 00 00 00       	mov    $0xa,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <getpid>:
SYSCALL(getpid)
 423:	b8 0b 00 00 00       	mov    $0xb,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <sbrk>:
SYSCALL(sbrk)
 42b:	b8 0c 00 00 00       	mov    $0xc,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <sleep>:
SYSCALL(sleep)
 433:	b8 0d 00 00 00       	mov    $0xd,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <uptime>:
SYSCALL(uptime)
 43b:	b8 0e 00 00 00       	mov    $0xe,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <fork2>:
SYSCALL(fork2)
 443:	b8 18 00 00 00       	mov    $0x18,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <getpri>:
SYSCALL(getpri)
 44b:	b8 17 00 00 00       	mov    $0x17,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <setpri>:
SYSCALL(setpri)
 453:	b8 16 00 00 00       	mov    $0x16,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <getpinfo>:
SYSCALL(getpinfo)
 45b:	b8 19 00 00 00       	mov    $0x19,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 463:	55                   	push   %ebp
 464:	89 e5                	mov    %esp,%ebp
 466:	83 ec 1c             	sub    $0x1c,%esp
 469:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 46c:	6a 01                	push   $0x1
 46e:	8d 55 f4             	lea    -0xc(%ebp),%edx
 471:	52                   	push   %edx
 472:	50                   	push   %eax
 473:	e8 4b ff ff ff       	call   3c3 <write>
}
 478:	83 c4 10             	add    $0x10,%esp
 47b:	c9                   	leave  
 47c:	c3                   	ret    

0000047d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 47d:	55                   	push   %ebp
 47e:	89 e5                	mov    %esp,%ebp
 480:	57                   	push   %edi
 481:	56                   	push   %esi
 482:	53                   	push   %ebx
 483:	83 ec 2c             	sub    $0x2c,%esp
 486:	89 c7                	mov    %eax,%edi
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 488:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 48c:	0f 95 c3             	setne  %bl
 48f:	89 d0                	mov    %edx,%eax
 491:	c1 e8 1f             	shr    $0x1f,%eax
 494:	84 c3                	test   %al,%bl
 496:	74 10                	je     4a8 <printint+0x2b>
    neg = 1;
    x = -xx;
 498:	f7 da                	neg    %edx
    neg = 1;
 49a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 4a1:	be 00 00 00 00       	mov    $0x0,%esi
 4a6:	eb 0b                	jmp    4b3 <printint+0x36>
  neg = 0;
 4a8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
 4af:	eb f0                	jmp    4a1 <printint+0x24>
  do{
    buf[i++] = digits[x % base];
 4b1:	89 c6                	mov    %eax,%esi
 4b3:	89 d0                	mov    %edx,%eax
 4b5:	ba 00 00 00 00       	mov    $0x0,%edx
 4ba:	f7 f1                	div    %ecx
 4bc:	89 c3                	mov    %eax,%ebx
 4be:	8d 46 01             	lea    0x1(%esi),%eax
 4c1:	0f b6 92 74 08 00 00 	movzbl 0x874(%edx),%edx
 4c8:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
  }while((x /= base) != 0);
 4cc:	89 da                	mov    %ebx,%edx
 4ce:	85 db                	test   %ebx,%ebx
 4d0:	75 df                	jne    4b1 <printint+0x34>
 4d2:	89 c3                	mov    %eax,%ebx
  if(neg)
 4d4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
 4d8:	74 16                	je     4f0 <printint+0x73>
    buf[i++] = '-';
 4da:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
 4df:	8d 5e 02             	lea    0x2(%esi),%ebx
 4e2:	eb 0c                	jmp    4f0 <printint+0x73>

  while(--i >= 0)
    putc(fd, buf[i]);
 4e4:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 4e9:	89 f8                	mov    %edi,%eax
 4eb:	e8 73 ff ff ff       	call   463 <putc>
  while(--i >= 0)
 4f0:	83 eb 01             	sub    $0x1,%ebx
 4f3:	79 ef                	jns    4e4 <printint+0x67>
}
 4f5:	83 c4 2c             	add    $0x2c,%esp
 4f8:	5b                   	pop    %ebx
 4f9:	5e                   	pop    %esi
 4fa:	5f                   	pop    %edi
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    

000004fd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4fd:	55                   	push   %ebp
 4fe:	89 e5                	mov    %esp,%ebp
 500:	57                   	push   %edi
 501:	56                   	push   %esi
 502:	53                   	push   %ebx
 503:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 506:	8d 45 10             	lea    0x10(%ebp),%eax
 509:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  state = 0;
 50c:	be 00 00 00 00       	mov    $0x0,%esi
  for(i = 0; fmt[i]; i++){
 511:	bb 00 00 00 00       	mov    $0x0,%ebx
 516:	eb 14                	jmp    52c <printf+0x2f>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 518:	89 fa                	mov    %edi,%edx
 51a:	8b 45 08             	mov    0x8(%ebp),%eax
 51d:	e8 41 ff ff ff       	call   463 <putc>
 522:	eb 05                	jmp    529 <printf+0x2c>
      }
    } else if(state == '%'){
 524:	83 fe 25             	cmp    $0x25,%esi
 527:	74 25                	je     54e <printf+0x51>
  for(i = 0; fmt[i]; i++){
 529:	83 c3 01             	add    $0x1,%ebx
 52c:	8b 45 0c             	mov    0xc(%ebp),%eax
 52f:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
 533:	84 c0                	test   %al,%al
 535:	0f 84 23 01 00 00    	je     65e <printf+0x161>
    c = fmt[i] & 0xff;
 53b:	0f be f8             	movsbl %al,%edi
 53e:	0f b6 c0             	movzbl %al,%eax
    if(state == 0){
 541:	85 f6                	test   %esi,%esi
 543:	75 df                	jne    524 <printf+0x27>
      if(c == '%'){
 545:	83 f8 25             	cmp    $0x25,%eax
 548:	75 ce                	jne    518 <printf+0x1b>
        state = '%';
 54a:	89 c6                	mov    %eax,%esi
 54c:	eb db                	jmp    529 <printf+0x2c>
      if(c == 'd'){
 54e:	83 f8 64             	cmp    $0x64,%eax
 551:	74 49                	je     59c <printf+0x9f>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 553:	83 f8 78             	cmp    $0x78,%eax
 556:	0f 94 c1             	sete   %cl
 559:	83 f8 70             	cmp    $0x70,%eax
 55c:	0f 94 c2             	sete   %dl
 55f:	08 d1                	or     %dl,%cl
 561:	75 63                	jne    5c6 <printf+0xc9>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 563:	83 f8 73             	cmp    $0x73,%eax
 566:	0f 84 84 00 00 00    	je     5f0 <printf+0xf3>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 56c:	83 f8 63             	cmp    $0x63,%eax
 56f:	0f 84 b7 00 00 00    	je     62c <printf+0x12f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 575:	83 f8 25             	cmp    $0x25,%eax
 578:	0f 84 cc 00 00 00    	je     64a <printf+0x14d>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 57e:	ba 25 00 00 00       	mov    $0x25,%edx
 583:	8b 45 08             	mov    0x8(%ebp),%eax
 586:	e8 d8 fe ff ff       	call   463 <putc>
        putc(fd, c);
 58b:	89 fa                	mov    %edi,%edx
 58d:	8b 45 08             	mov    0x8(%ebp),%eax
 590:	e8 ce fe ff ff       	call   463 <putc>
      }
      state = 0;
 595:	be 00 00 00 00       	mov    $0x0,%esi
 59a:	eb 8d                	jmp    529 <printf+0x2c>
        printint(fd, *ap, 10, 1);
 59c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 59f:	8b 17                	mov    (%edi),%edx
 5a1:	83 ec 0c             	sub    $0xc,%esp
 5a4:	6a 01                	push   $0x1
 5a6:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5ab:	8b 45 08             	mov    0x8(%ebp),%eax
 5ae:	e8 ca fe ff ff       	call   47d <printint>
        ap++;
 5b3:	83 c7 04             	add    $0x4,%edi
 5b6:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 5b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5bc:	be 00 00 00 00       	mov    $0x0,%esi
 5c1:	e9 63 ff ff ff       	jmp    529 <printf+0x2c>
        printint(fd, *ap, 16, 0);
 5c6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 5c9:	8b 17                	mov    (%edi),%edx
 5cb:	83 ec 0c             	sub    $0xc,%esp
 5ce:	6a 00                	push   $0x0
 5d0:	b9 10 00 00 00       	mov    $0x10,%ecx
 5d5:	8b 45 08             	mov    0x8(%ebp),%eax
 5d8:	e8 a0 fe ff ff       	call   47d <printint>
        ap++;
 5dd:	83 c7 04             	add    $0x4,%edi
 5e0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
 5e3:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5e6:	be 00 00 00 00       	mov    $0x0,%esi
 5eb:	e9 39 ff ff ff       	jmp    529 <printf+0x2c>
        s = (char*)*ap;
 5f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f3:	8b 30                	mov    (%eax),%esi
        ap++;
 5f5:	83 c0 04             	add    $0x4,%eax
 5f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
 5fb:	85 f6                	test   %esi,%esi
 5fd:	75 28                	jne    627 <printf+0x12a>
          s = "(null)";
 5ff:	be 6c 08 00 00       	mov    $0x86c,%esi
 604:	8b 7d 08             	mov    0x8(%ebp),%edi
 607:	eb 0d                	jmp    616 <printf+0x119>
          putc(fd, *s);
 609:	0f be d2             	movsbl %dl,%edx
 60c:	89 f8                	mov    %edi,%eax
 60e:	e8 50 fe ff ff       	call   463 <putc>
          s++;
 613:	83 c6 01             	add    $0x1,%esi
        while(*s != 0){
 616:	0f b6 16             	movzbl (%esi),%edx
 619:	84 d2                	test   %dl,%dl
 61b:	75 ec                	jne    609 <printf+0x10c>
      state = 0;
 61d:	be 00 00 00 00       	mov    $0x0,%esi
 622:	e9 02 ff ff ff       	jmp    529 <printf+0x2c>
 627:	8b 7d 08             	mov    0x8(%ebp),%edi
 62a:	eb ea                	jmp    616 <printf+0x119>
        putc(fd, *ap);
 62c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 62f:	0f be 17             	movsbl (%edi),%edx
 632:	8b 45 08             	mov    0x8(%ebp),%eax
 635:	e8 29 fe ff ff       	call   463 <putc>
        ap++;
 63a:	83 c7 04             	add    $0x4,%edi
 63d:	89 7d e4             	mov    %edi,-0x1c(%ebp)
      state = 0;
 640:	be 00 00 00 00       	mov    $0x0,%esi
 645:	e9 df fe ff ff       	jmp    529 <printf+0x2c>
        putc(fd, c);
 64a:	89 fa                	mov    %edi,%edx
 64c:	8b 45 08             	mov    0x8(%ebp),%eax
 64f:	e8 0f fe ff ff       	call   463 <putc>
      state = 0;
 654:	be 00 00 00 00       	mov    $0x0,%esi
 659:	e9 cb fe ff ff       	jmp    529 <printf+0x2c>
    }
  }
}
 65e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 661:	5b                   	pop    %ebx
 662:	5e                   	pop    %esi
 663:	5f                   	pop    %edi
 664:	5d                   	pop    %ebp
 665:	c3                   	ret    

00000666 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 666:	55                   	push   %ebp
 667:	89 e5                	mov    %esp,%ebp
 669:	57                   	push   %edi
 66a:	56                   	push   %esi
 66b:	53                   	push   %ebx
 66c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 66f:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 672:	a1 40 0b 00 00       	mov    0xb40,%eax
 677:	eb 02                	jmp    67b <free+0x15>
 679:	89 d0                	mov    %edx,%eax
 67b:	39 c8                	cmp    %ecx,%eax
 67d:	73 04                	jae    683 <free+0x1d>
 67f:	39 08                	cmp    %ecx,(%eax)
 681:	77 12                	ja     695 <free+0x2f>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 683:	8b 10                	mov    (%eax),%edx
 685:	39 c2                	cmp    %eax,%edx
 687:	77 f0                	ja     679 <free+0x13>
 689:	39 c8                	cmp    %ecx,%eax
 68b:	72 08                	jb     695 <free+0x2f>
 68d:	39 ca                	cmp    %ecx,%edx
 68f:	77 04                	ja     695 <free+0x2f>
 691:	89 d0                	mov    %edx,%eax
 693:	eb e6                	jmp    67b <free+0x15>
      break;
  if(bp + bp->s.size == p->s.ptr){
 695:	8b 73 fc             	mov    -0x4(%ebx),%esi
 698:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 69b:	8b 10                	mov    (%eax),%edx
 69d:	39 d7                	cmp    %edx,%edi
 69f:	74 19                	je     6ba <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6a1:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6a4:	8b 50 04             	mov    0x4(%eax),%edx
 6a7:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6aa:	39 ce                	cmp    %ecx,%esi
 6ac:	74 1b                	je     6c9 <free+0x63>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6ae:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6b0:	a3 40 0b 00 00       	mov    %eax,0xb40
}
 6b5:	5b                   	pop    %ebx
 6b6:	5e                   	pop    %esi
 6b7:	5f                   	pop    %edi
 6b8:	5d                   	pop    %ebp
 6b9:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 6ba:	03 72 04             	add    0x4(%edx),%esi
 6bd:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c0:	8b 10                	mov    (%eax),%edx
 6c2:	8b 12                	mov    (%edx),%edx
 6c4:	89 53 f8             	mov    %edx,-0x8(%ebx)
 6c7:	eb db                	jmp    6a4 <free+0x3e>
    p->s.size += bp->s.size;
 6c9:	03 53 fc             	add    -0x4(%ebx),%edx
 6cc:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6cf:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6d2:	89 10                	mov    %edx,(%eax)
 6d4:	eb da                	jmp    6b0 <free+0x4a>

000006d6 <morecore>:

static Header*
morecore(uint nu)
{
 6d6:	55                   	push   %ebp
 6d7:	89 e5                	mov    %esp,%ebp
 6d9:	53                   	push   %ebx
 6da:	83 ec 04             	sub    $0x4,%esp
 6dd:	89 c3                	mov    %eax,%ebx
  char *p;
  Header *hp;

  if(nu < 4096)
 6df:	3d ff 0f 00 00       	cmp    $0xfff,%eax
 6e4:	77 05                	ja     6eb <morecore+0x15>
    nu = 4096;
 6e6:	bb 00 10 00 00       	mov    $0x1000,%ebx
  p = sbrk(nu * sizeof(Header));
 6eb:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 6f2:	83 ec 0c             	sub    $0xc,%esp
 6f5:	50                   	push   %eax
 6f6:	e8 30 fd ff ff       	call   42b <sbrk>
  if(p == (char*)-1)
 6fb:	83 c4 10             	add    $0x10,%esp
 6fe:	83 f8 ff             	cmp    $0xffffffff,%eax
 701:	74 1c                	je     71f <morecore+0x49>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 703:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 706:	83 c0 08             	add    $0x8,%eax
 709:	83 ec 0c             	sub    $0xc,%esp
 70c:	50                   	push   %eax
 70d:	e8 54 ff ff ff       	call   666 <free>
  return freep;
 712:	a1 40 0b 00 00       	mov    0xb40,%eax
 717:	83 c4 10             	add    $0x10,%esp
}
 71a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 71d:	c9                   	leave  
 71e:	c3                   	ret    
    return 0;
 71f:	b8 00 00 00 00       	mov    $0x0,%eax
 724:	eb f4                	jmp    71a <morecore+0x44>

00000726 <malloc>:

void*
malloc(uint nbytes)
{
 726:	55                   	push   %ebp
 727:	89 e5                	mov    %esp,%ebp
 729:	53                   	push   %ebx
 72a:	83 ec 04             	sub    $0x4,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 72d:	8b 45 08             	mov    0x8(%ebp),%eax
 730:	8d 58 07             	lea    0x7(%eax),%ebx
 733:	c1 eb 03             	shr    $0x3,%ebx
 736:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 739:	8b 0d 40 0b 00 00    	mov    0xb40,%ecx
 73f:	85 c9                	test   %ecx,%ecx
 741:	74 04                	je     747 <malloc+0x21>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 743:	8b 01                	mov    (%ecx),%eax
 745:	eb 4d                	jmp    794 <malloc+0x6e>
    base.s.ptr = freep = prevp = &base;
 747:	c7 05 40 0b 00 00 44 	movl   $0xb44,0xb40
 74e:	0b 00 00 
 751:	c7 05 44 0b 00 00 44 	movl   $0xb44,0xb44
 758:	0b 00 00 
    base.s.size = 0;
 75b:	c7 05 48 0b 00 00 00 	movl   $0x0,0xb48
 762:	00 00 00 
    base.s.ptr = freep = prevp = &base;
 765:	b9 44 0b 00 00       	mov    $0xb44,%ecx
 76a:	eb d7                	jmp    743 <malloc+0x1d>
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 76c:	39 da                	cmp    %ebx,%edx
 76e:	74 1a                	je     78a <malloc+0x64>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 770:	29 da                	sub    %ebx,%edx
 772:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 775:	8d 04 d0             	lea    (%eax,%edx,8),%eax
        p->s.size = nunits;
 778:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 77b:	89 0d 40 0b 00 00    	mov    %ecx,0xb40
      return (void*)(p + 1);
 781:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 784:	83 c4 04             	add    $0x4,%esp
 787:	5b                   	pop    %ebx
 788:	5d                   	pop    %ebp
 789:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 78a:	8b 10                	mov    (%eax),%edx
 78c:	89 11                	mov    %edx,(%ecx)
 78e:	eb eb                	jmp    77b <malloc+0x55>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 790:	89 c1                	mov    %eax,%ecx
 792:	8b 00                	mov    (%eax),%eax
    if(p->s.size >= nunits){
 794:	8b 50 04             	mov    0x4(%eax),%edx
 797:	39 da                	cmp    %ebx,%edx
 799:	73 d1                	jae    76c <malloc+0x46>
    if(p == freep)
 79b:	39 05 40 0b 00 00    	cmp    %eax,0xb40
 7a1:	75 ed                	jne    790 <malloc+0x6a>
      if((p = morecore(nunits)) == 0)
 7a3:	89 d8                	mov    %ebx,%eax
 7a5:	e8 2c ff ff ff       	call   6d6 <morecore>
 7aa:	85 c0                	test   %eax,%eax
 7ac:	75 e2                	jne    790 <malloc+0x6a>
        return 0;
 7ae:	b8 00 00 00 00       	mov    $0x0,%eax
 7b3:	eb cf                	jmp    784 <malloc+0x5e>
