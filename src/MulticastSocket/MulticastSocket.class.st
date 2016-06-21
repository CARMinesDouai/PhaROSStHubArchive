"
An UTMulticastSocket is a sub class of Socket. It is designed for multicast.

Instance Variables
	groupAddress:		<String | IPAddress>
"
Class {
	#name : #MulticastSocket,
	#superclass : #Socket,
	#instVars : [
		'groupAddress',
		'multicastPort',
		'receptionBuffer'
	],
	#category : #MulticastSocket
}

{ #category : #'instance creation' }
MulticastSocket class >> group: aString port: anInteger [
	"mp 2/10/2006 12:14"
	"Create a multicast socket then join the specified group on the specified port."
	
	| socket |
	socket := self new.
	socket group: aString port: anInteger.
	^ socket
]

{ #category : #'instance creation' }
MulticastSocket class >> new [
	"mp 2/10/2006 12:14"
	"Create a multicast socket"
	
	^ self newUDP
]

{ #category : #'initialize-destroy' }
MulticastSocket >> closeAndDestroy [
	[self leaveGroup] ensure: [
		super closeAndDestroy]
]

{ #category : #'initialize-destroy' }
MulticastSocket >> defaultBufferSize [
	^10000
]

{ #category : #accessing }
MulticastSocket >> getInterface [
	"mp 2/13/2006 10:02"
	"Get the multicast network interface set."
	
	^ self getOption: 'IP_MULTICAST_IF'
]

{ #category : #accessing }
MulticastSocket >> getLoopbackMode [
	"mp 2/13/2006 10:02"
	"Get the setting for local loopback of multicast datagrams."
	
	^ self getOption: 'IP_MULTICAST_LOOP'
]

{ #category : #accessing }
MulticastSocket >> getTimeToLive [
	"mp 2/13/2006 10:01"
	"Get the default time-to-live for multicast packets sent out on the socket."
	
	^ self getOption: 'IP_MULTICAST_TTL'
]

{ #category : #'initialize-destroy' }
MulticastSocket >> group: anIpAddressString port: aPortNumber [
	self setPort: aPortNumber.
	self multicastPort: aPortNumber.
	self groupAddress: anIpAddressString.
	self joinGroup.
]

{ #category : #accessing }
MulticastSocket >> groupAddress [
	^ groupAddress
]

{ #category : #accessing }
MulticastSocket >> groupAddress: aStringOrIPAddress [ 
	groupAddress := aStringOrIPAddress asIpAddress
]

{ #category : #accessing }
MulticastSocket >> inaddrAny [
	"mp 4/10/2006 16:17"
	
	^ #[0 0 0 0]
]

{ #category : #'initialize-destroy' }
MulticastSocket >> initialize: socketType [
	super initialize: socketType.
	receptionBuffer := ByteArray new: self defaultBufferSize.

]

{ #category : #'group membership' }
MulticastSocket >> joinGroup [
	"mp 2/8/2006 14:54"
	"Join the default multicast group (226.0.0.12) on the default interface (0.0.0.0 for INADDR_ANY)"
	
	self joinGroup: self groupAddress
]

{ #category : #'group membership' }
MulticastSocket >> joinGroup: aMulticastAddress [
	"mp 2/8/2006 14:54"
	"Arguments for joining a group are the multicast address (226.0.0.12) and the interface to use (0.0.0.0 for INADDR_ANY)"
	
	| joinParams |
	joinParams := self multicastMembershipParametersForAddress: aMulticastAddress.
	self setOption: 'IP_ADD_MEMBERSHIP' value: joinParams asByteArray
]

{ #category : #'group membership' }
MulticastSocket >> leaveGroup [
	"mp 2/8/2006 14:54"
	"Leave the default multicast group (226.0.0.12) on the default interface (0.0.0.0 for INADDR_ANY)"

	self leaveGroup: self groupAddress
]

{ #category : #'group membership' }
MulticastSocket >> leaveGroup: aMulticastAddress [ 
	"mp 2/8/2006 14:54"
	"Arguments for leaving a group are the multicast address (226.0.0.12) and the interface to use is set to 0.0.0.0 for INADDR_ANY"

	| joinParams |
	joinParams := self multicastMembershipParametersForAddress: aMulticastAddress.
	self setOption: 'IP_DROP_MEMBERSHIP' value: joinParams asByteArray
]

{ #category : #'group membership' }
MulticastSocket >> multicastMembershipParameters [
	^self multicastMembershipParametersForAddress: self groupAddress
]

{ #category : #'group membership' }
MulticastSocket >> multicastMembershipParametersForAddress: aMulticastAddress [ 
	"mp 2/8/2006 15:00"
	"Arguments for leaving a group are the multicast address (226.0.0.12) and the interface to use (0.0.0.0 for INADDR_ANY)"
	
	| joinParams |
	joinParams := aMulticastAddress asOrderedCollection.
	joinParams addAll: self inaddrAny.
	^joinParams
]

{ #category : #accessing }
MulticastSocket >> multicastPort [
	^multicastPort
]

{ #category : #accessing }
MulticastSocket >> multicastPort: anInteger [
	multicastPort  := anInteger
]

{ #category : #communicating }
MulticastSocket >> receive [
	"mp 2/13/2006 11:05"
	"Suspends for an infinite period until receiving some data"
	
	| bytesRead |
	bytesRead := self receiveDataInto: receptionBuffer.
	^ receptionBuffer copyFrom: 1 to: bytesRead
]

{ #category : #communicating }
MulticastSocket >> receiveTimeout: seconds [
	self waitForDataFor: seconds.
	^self receive
]

{ #category : #communicating }
MulticastSocket >> send: aString [
	"mp 2/10/2006 12:23"
	"Send a UDP packet containing the given data to the specified host/port."
	
	self 
		sendData: aString
		toHost: self groupAddress
		port: self multicastPort.
]

{ #category : #accessing }
MulticastSocket >> setInterfaceTo: anIPAddress [
	"mp 2/13/2006 10:02"
	"Specify the network interface for outgoing multicast datagrams sent on this socket."
	
	self setOption: 'IP_MULTICAST_IF' value: anIPAddress
]

{ #category : #accessing }
MulticastSocket >> setLoopbackModeTo: aBoolean [
	"mp 2/13/2006 10:02"
	"Disable/Enable local loopback of multicast datagrams. The option is used by the platform's networking code as a hint for setting whether multicast data will be looped back to the local socket."
	
	self setOption: 'IP_MULTICAST_LOOP' value: aBoolean
]

{ #category : #accessing }
MulticastSocket >> setTimeToLiveTo: anInteger [
	"mp 2/13/2006 10:02"
	"Set the time-to-live for multicast packets sent out in order to control the scope of the multicasts."
	
	(anInteger between: 0 and: 255) 
		ifFalse: [self error: 'Time-To-Live out of range'].
	^self setOption: 'IP_MULTICAST_TTL' value: anInteger

]
