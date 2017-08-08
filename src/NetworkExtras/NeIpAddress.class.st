"
I represents an IP address. 

I subclass of  ByteArray for purpose of compatibility with the existing implementation of Socket
"
Class {
	#name : #NeIpAddress,
	#superclass : #ByteArray,
	#type : #bytes,
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeIpAddress class >> broadcast [
	^ self newFrom: #[255 255 255 255]
]

{ #category : #'instance creation' }
NeIpAddress class >> fromString: aString [
	"return a new IP address from a string
	IPAddress fromString: '10.1.10.115'"
	
	^ self newFrom: ((aString splitOn: $.) collect: [:s | s asInteger])
]

{ #category : #'instance creation' }
NeIpAddress class >> local [
	"mp 10/30/2005 15:53"
	"return a new IP address from a string
	IPAddress local"
	
	^ self newFrom: NetNameResolver localHostAddress
]

{ #category : #'instance creation' }
NeIpAddress class >> loopback [
	^ self newFrom: NetNameResolver loopBackAddress
]

{ #category : #'instance creation' }
NeIpAddress class >> netID1: anInteger1 netID2: anInteger2 hostID1: anInteger3 hostID2: anInteger4 [
	"mp 10/6/2005 18:53"
	"Return an instance with the 4 bytes of an IP address"
	"IpAddress netID1: 1 netID2: 2 hostID1: 3 hostID2: 4"
	
	^ self 
		with: anInteger1
		with: anInteger2
		with: anInteger3
		with: anInteger4
]

{ #category : #converting }
NeIpAddress >> asIpAddress [
	^self
]

{ #category : #converting }
NeIpAddress >> asString [
	^ NetNameResolver stringFromAddress: self
]

{ #category : #accessing }
NeIpAddress >> name [
	^NetNameResolver nameForAddress: self timeout: 60
]
