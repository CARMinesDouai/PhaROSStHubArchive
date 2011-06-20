Class {
	#name : #OCNSysSocketConstants,
	#superclass : #SharedPool,
	#classVars : [
		'AF_INET',
		'IPPROTO_TCP',
		'PF_INET',
		'SOCK_DGRAM',
		'SOCK_RAW',
		'SOCK_RDM',
		'SOCK_SEQPACKET',
		'SOCK_STREAM'
	],
	#category : #'Ocean-LibraryPosix'
}

{ #category : #'as yet unclassified' }
OCNSysSocketConstants class >> initialize [ 

	super initialize.
	self initializeAddressFamilies ;
		initializeProtocolFamilies ;
		initializeSocketTypes
]

{ #category : #'as yet unclassified' }
OCNSysSocketConstants class >> initializeAddressFamilies [

	AF_INET := 2. "/* internetwork: UDP, TCP, etc. */"
	
]

{ #category : #'as yet unclassified' }
OCNSysSocketConstants class >> initializeProtocolFamilies [

	"socket.h"
	PF_INET := AF_INET.
	
	"in.h"
	IPPROTO_TCP := 6.  "tcp"
	
]

{ #category : #'as yet unclassified' }
OCNSysSocketConstants class >> initializeSocketTypes [

	"socket.h"
	SOCK_STREAM := 1. 	" stream socket "
	SOCK_DGRAM := 2.	 	" datagram socket "
	SOCK_RAW	:= 3. 		"raw-protocol interface"
	
	SOCK_RDM	:= 4.		"DARWIN POSIX only reliably-delivered message"

	SOCK_SEQPACKET := 5. "sequenced packet stream"
	
]
