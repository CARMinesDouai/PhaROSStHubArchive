Class {
	#name : #NBOceanLibraryConstants,
	#superclass : #SharedPool,
	#classVars : [
		'AF_UNSPEC',
		'AI_ADDRCONFIG',
		'AI_ALL',
		'AI_CANONNAME',
		'AI_DEFAULT',
		'AI_MASK',
		'AI_NUMERICHOST',
		'AI_PASSIVE',
		'AI_V4MAPPED',
		'AI_V4MAPPED_CFG',
		'INADDR_ANY',
		'INADDR_LOOPBACK',
		'PF_UNSPEC'
	],
	#category : #'Ocean-LibraryNativeBoost'
}

{ #category : #'as yet unclassified' }
NBOceanLibraryConstants class >> initAddressFamilies [
	"<sys/socket.h>"
	AF_UNSPEC := 0.
	PF_UNSPEC := 0.
	
	
	
]

{ #category : #'as yet unclassified' }
NBOceanLibraryConstants class >> initAiFlags [

	"<netdb.h>"

" Flag values for getaddrinfo() "

	AI_PASSIVE := 16r00000001.  " get address to use bind() "
	AI_CANONNAME := 16r00000002. "fill ai_canonname"
	AI_NUMERICHOST := 16r00000004. "prevent name resolution"
	
" valid flags for addrinfo "

	AI_MASK := (AI_PASSIVE | AI_CANONNAME | AI_NUMERICHOST).
	
	AI_ALL := 16r00000100.  "IPv6 and IPv4-mapped (with AI_V4MAPPED)"
	
	AI_V4MAPPED_CFG := 16r00000200. "accept IPv4-mapped if kernel supports"
	
	AI_ADDRCONFIG := 16r00000400. "only if any address is assigned"
	AI_V4MAPPED := 16r00000800. "accept IPv4-mapped IPv6 address"
	
"special recommended flags for getipnodebyname"

	AI_DEFAULT := (AI_V4MAPPED_CFG | AI_ADDRCONFIG).
	
	
]

{ #category : #'as yet unclassified' }
NBOceanLibraryConstants class >> initialize [
"self initialize"

	self initAddressFamilies;
		initAiFlags.

"define more if you need to"

INADDR_ANY := 16r00000000.

"	
#define INADDR_BROADCAST        (u_int32_t)0xffffffff   /* must be masked */

#if !defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE)
#define IN_CLASSA(i)            (((u_int32_t)(i) & 0x80000000) == 0)
#define IN_CLASSA_NET           0xff000000
#define IN_CLASSA_NSHIFT        24
#define IN_CLASSA_HOST          0x00ffffff
#define IN_CLASSA_MAX           128

#define IN_CLASSB(i)            (((u_int32_t)(i) & 0xc0000000) == 0x80000000)
#define IN_CLASSB_NET           0xffff0000
#define IN_CLASSB_NSHIFT        16
#define IN_CLASSB_HOST          0x0000ffff
#define IN_CLASSB_MAX           65536

#define IN_CLASSC(i)            (((u_int32_t)(i) & 0xe0000000) == 0xc0000000)
#define IN_CLASSC_NET           0xffffff00
#define IN_CLASSC_NSHIFT        8
#define IN_CLASSC_HOST          0x000000ff

#define IN_CLASSD(i)            (((u_int32_t)(i) & 0xf0000000) == 0xe0000000)
#define IN_CLASSD_NET           0xf0000000      /* These ones aren't really */
#define IN_CLASSD_NSHIFT        28              /* net and host fields, but */
#define IN_CLASSD_HOST          0x0fffffff      /* routing needn't know.    */
#define IN_MULTICAST(i)         IN_CLASSD(i)

#define IN_EXPERIMENTAL(i)      (((u_int32_t)(i) & 0xf0000000) == 0xf0000000)
#define IN_BADCLASS(i)          (((u_int32_t)(i) & 0xf0000000) == 0xf0000000)

"
INADDR_LOOPBACK := 16r7f000001.

"
#define INADDR_UNSPEC_GROUP     (u_int32_t)0xe0000000   /* 224.0.0.0 */
#define INADDR_ALLHOSTS_GROUP   (u_int32_t)0xe0000001   /* 224.0.0.1 */
#define INADDR_ALLRTRS_GROUP    (u_int32_t)0xe0000002   /* 224.0.0.2 */
#define INADDR_MAX_LOCAL_GROUP  (u_int32_t)0xe00000ff   /* 224.0.0.255 */
"
]
