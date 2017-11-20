"
I represents an IPv4 address. 

I subclass of  ByteArray for purpose of compatibility with the existing implementation of Socket

Instances can be created either  from  a string or a byte array.
Examples:
'192.168.11.22' asIpAddress
#[192 168 11 22] asIpAddress
"
Class {
	#name : #NeIpV4Address,
	#superclass : #ByteArray,
	#type : #bytes,
	#category : #'NetworkExtras-Kernel'
}

{ #category : #'instance creation' }
NeIpV4Address class >> allNetworkInterfaces [
	"INADDR_ANY = all available network interfaces on the current device"
	^ self newFrom:  #[0 0 0 0]
]

{ #category : #'instance creation' }
NeIpV4Address class >> broadcast [
	^ self newFrom: #[255 255 255 255]
]

{ #category : #'instance creation' }
NeIpV4Address class >> fromString: aString [
	"return a new IP address from a string
	IPAddress fromString: '10.1.10.115'"
	
	^ self newFrom: ((aString splitOn: $.) collect: [:s | s asInteger])
]

{ #category : #'instance creation' }
NeIpV4Address class >> local [
	"mp 10/30/2005 15:53"
	"return a new IP address from a string
	IPAddress local"
	
	^ self newFrom: NetNameResolver localHostAddress
]

{ #category : #'instance creation' }
NeIpV4Address class >> loopback [
	^ self newFrom: NetNameResolver loopBackAddress
]

{ #category : #comparing }
NeIpV4Address >> < anIpAddress [
	^self asNumber < anIpAddress asNumber
]

{ #category : #comparing }
NeIpV4Address >> > anIpAddress [
	^self asNumber > anIpAddress asNumber
]

{ #category : #converting }
NeIpV4Address >> asIpAddress [
	^self
]

{ #category : #converting }
NeIpV4Address >> asNumber [
	| result coeficient |
	result := 0.
	self with: (self size to: 1 by: -1) do: [ : value : index |
		coeficient := 10 ** (index * 3).
		result := result + (value * coeficient) ].
	^result
]

{ #category : #converting }
NeIpV4Address >> asString [
	^ NetNameResolver stringFromAddress: self
]

{ #category : #accessing }
NeIpV4Address >> name [
	^NetNameResolver nameForAddress: self timeout: 60
]
