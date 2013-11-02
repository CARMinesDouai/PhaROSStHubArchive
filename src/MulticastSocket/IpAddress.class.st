"
An IpAddress represents an IP address. It is a subclass of  ByteArray for purpose of compatibility with the existing implementation of Socket
"
Class {
	#name : #IpAddress,
	#superclass : #ByteArray,
	#type : #bytes,
	#category : #MulticastSocket
}

{ #category : #'instance creation' }
IpAddress class >> fromString: aString [
	"mp 10/6/2005 19:50"
	"return a new IP address from a string
	IPAddress fromString: '10.1.10.115'"
	
	^ self newFrom: ((aString findTokens: $.) collect: [:s | s asInteger])
]

{ #category : #'instance creation' }
IpAddress class >> local [
	"mp 10/30/2005 15:53"
	"return a new IP address from a string
	IPAddress local"
	
	^ self newFrom: NetNameResolver localHostAddress
]

{ #category : #'instance creation' }
IpAddress class >> netID1: anInteger1 netID2: anInteger2 hostID1: anInteger3 hostID2: anInteger4 [
	"mp 10/6/2005 18:53"
	"Return an instance with the 4 bytes of an IP address"
	"IpAddress netID1: 1 netID2: 2 hostID1: 3 hostID2: 4"
	
	^ self 
		with: anInteger1
		with: anInteger2
		with: anInteger3
		with: anInteger4
]

{ #category : #arithmetic }
IpAddress >> + anIPAddress [
	"mp 10/9/2005 18:00"
	
	self error: 'Not implemented yet'
]

{ #category : #arithmetic }
IpAddress >> - anIPAddress [
	"mp 10/9/2005 18:00"
	
	self error: 'Not implemented yet'
]

{ #category : #comparing }
IpAddress >> < anIPAddress [
	"mp 10/7/2005 11:35"
	
	^ (self netID1 <= anIPAddress netID1) and: 
		[(self netID2 <= anIPAddress netID2) and: 
			[(self hostID1 <= anIPAddress hostID1) and: 
				[(self hostID2 < anIPAddress hostID2)]]]
]

{ #category : #comparing }
IpAddress >> <= anIPAddress [
	"mp 10/7/2005 11:35"
	
	^ (anIPAddress < self) not
]

{ #category : #comparing }
IpAddress >> > anIPAddress [
	"mp 10/7/2005 11:35"
	
	^ anIPAddress < self
]

{ #category : #comparing }
IpAddress >> >= anIPAddress [
	"mp 10/7/2005 11:35"
	
	^ (self < anIPAddress) not
]

{ #category : #converting }
IpAddress >> asIpAddress [
	^self
]

{ #category : #converting }
IpAddress >> asString [
	"mp 10/6/2005 18:50"
	
	^ NetNameResolver stringFromAddress: self
]

{ #category : #converting }
IpAddress >> asSymbol [
	"mp 10/13/2005 11:01"
	
	^ self asString asSymbol
]

{ #category : #comparing }
IpAddress >> between: ip1 and: ip2 [
	"mp 10/7/2005 17:27"
	
	^ self >= ip1 and: [self <= ip2]
]

{ #category : #accessing }
IpAddress >> hostID1 [
	"mp 10/6/2005 19:53"
	
	^ self third
]

{ #category : #accessing }
IpAddress >> hostID1: anInteger [
	"mp 10/6/2005 19:53"
	
	self at: 3 put: anInteger
]

{ #category : #accessing }
IpAddress >> hostID2 [
	"mp 10/6/2005 19:53"
	
	^ self fourth
]

{ #category : #accessing }
IpAddress >> hostID2: anInteger [
	"mp 10/6/2005 19:53"
	
	self at: 4 put: anInteger
]

{ #category : #accessing }
IpAddress >> netID1 [
	"mp 10/6/2005 19:53"
	
	^ self first
]

{ #category : #accessing }
IpAddress >> netID1: anInteger [
	"mp 10/6/2005 19:53"
	
	self at: 1 put: anInteger
]

{ #category : #accessing }
IpAddress >> netID2 [
	"mp 10/6/2005 19:53"
	
	^ self second
]

{ #category : #accessing }
IpAddress >> netID2: anInteger [
	"mp 10/6/2005 19:53"
	
	self at: 2 put: anInteger
]

{ #category : #arithmetic }
IpAddress >> next [
	"mp 10/7/2005 14:57"
	
	self nextHostID2
]

{ #category : #arithmetic }
IpAddress >> nextHostID1 [
	"mp 12/19/2005 16:32"
	| gap |
	self hostID1 >= 255
		ifTrue: [gap := self hostID1 - 255.
			0
				to: gap
				do: [:n | self nextNetID2].
			self hostID1: gap]
		ifFalse: [self hostID1: self hostID1 + 1]
]

{ #category : #arithmetic }
IpAddress >> nextHostID2 [
	"mp 12/19/2005 16:32"
	| gap |
	self hostID2 >= 255
		ifTrue: [gap := self hostID2 - 255.
			0
				to: gap
				do: [:n | self nextHostID1].
			self hostID2: gap]
		ifFalse: [self hostID2: self hostID2 + 1]
]

{ #category : #arithmetic }
IpAddress >> nextNetID1 [
	"mp 12/19/2005 16:30"
	self netID1 >= 255
		ifTrue: [MaximumIpReached signal]
		ifFalse: [self netID1: self netID1 + 1]
]

{ #category : #arithmetic }
IpAddress >> nextNetID2 [
	"mp 12/19/2005 16:32"
	| gap |
	self netID2 >= 255
		ifTrue: [gap := self netID2 - 255.
			0
				to: gap
				do: [:n | self nextNetID1].
			self netID2: gap]
		ifFalse: [self netID2: self netID2 + 1]
]
