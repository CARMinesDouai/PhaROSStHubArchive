"
An UTMulticastSocket is a sub class of Socket. It is designed for multicast.

Instance Variables
	groupAddress:		<String | IPAddress>
"
Class {
	#name : #NeMulticastSocketRefactored,
	#superclass : #NeUdpSocket,
	#instVars : [
		'groupAddress',
		'multicastPort',
		'networkInterfaceIp'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeMulticastSocketRefactored class >> group: groupIp port: anInteger [
	^self new
		group: groupIp port: anInteger;
		yourself
]

{ #category : #'initialize-destroy' }
NeMulticastSocketRefactored >> closeAndDestroy [
	[self leaveGroup] ensure: [
		super closeAndDestroy]
]

{ #category : #accessing }
NeMulticastSocketRefactored >> defaultNetworkInterfaceIp [
	^ #[0 0 0 0]
]

{ #category : #'initialize-destroy' }
NeMulticastSocketRefactored >> group: anIpAddress port: aPortNumber [
	self setPort: aPortNumber.
	self groupAddress: anIpAddress.
	self joinGroup.
]

{ #category : #accessing }
NeMulticastSocketRefactored >> groupAddress [
	^ groupAddress
]

{ #category : #accessing }
NeMulticastSocketRefactored >> groupAddress: aStringOrIPAddress [ 
	groupAddress := aStringOrIPAddress asIpAddress
]

{ #category : #communicating }
NeMulticastSocketRefactored >> groupPort [
	^self receptionPort
]

{ #category : #accessing }
NeMulticastSocketRefactored >> isLoopbackModeEnabled [
	"mp 2/13/2006 10:02"
	"Get the setting for local loopback of multicast datagrams."
	
	^ (self getOption: 'IP_MULTICAST_LOOP') ~= #(0 0)
]

{ #category : #accessing }
NeMulticastSocketRefactored >> isLoopbackModeEnabled: aBoolean [
	"mp 2/13/2006 10:02"
	"Disable/Enable local loopback of multicast datagrams. The option is used by the platform's networking code as a hint for setting whether multicast data will be looped back to the local socket."
	
	self setOption: 'IP_MULTICAST_LOOP' value: aBoolean
]

{ #category : #'group membership' }
NeMulticastSocketRefactored >> joinGroup [
	self setOption: 'IP_ADD_MEMBERSHIP' value: self joinParams
]

{ #category : #'group membership' }
NeMulticastSocketRefactored >> joinParams [
	^self multicastMembershipParametersForAddress: self groupAddress.

]

{ #category : #'group membership' }
NeMulticastSocketRefactored >> leaveGroup [
		self setOption: 'IP_DROP_MEMBERSHIP' value: self joinParams
]

{ #category : #'group membership' }
NeMulticastSocketRefactored >> multicastMembershipParametersForAddress: aMulticastAddress [ 
	"Arguments for managing multicast membership is the IP address and the network interface."
	
	| joinParams |
	joinParams := aMulticastAddress asOrderedCollection.
	joinParams addAll: self networkInterfaceIp.
	^joinParams asByteArray
]

{ #category : #accessing }
NeMulticastSocketRefactored >> networkInterface [
	"mp 2/13/2006 10:02"
	"Get the multicast network interface set."
	
	^ self getOption: 'IP_MULTICAST_IF'
]

{ #category : #accessing }
NeMulticastSocketRefactored >> networkInterfaceIp [
	^networkInterfaceIp ifNil: [ self defaultNetworkInterfaceIp ]
]

{ #category : #accessing }
NeMulticastSocketRefactored >> networkInterfaceIp: anIPAddress [
	networkInterfaceIp :=  anIPAddress asIpAddress.	
	self setOption: 'IP_MULTICAST_IF' value: networkInterfaceIp.
]

{ #category : #communicating }
NeMulticastSocketRefactored >> send: aString [
	self 
		sendData: aString
		toHost: self groupAddress
		port: self groupPort.
]

{ #category : #accessing }
NeMulticastSocketRefactored >> timeToLive [
	"mp 2/13/2006 10:01"
	"Get the default time-to-live for multicast packets sent out on the socket."
	
	^ self getOption: 'IP_MULTICAST_TTL'
]

{ #category : #accessing }
NeMulticastSocketRefactored >> timeToLive: anInteger [
	"mp 2/13/2006 10:02"
	"Set the time-to-live for multicast packets sent out in order to control the scope of the multicasts."
	
	(anInteger between: 0 and: 255) 
		ifFalse: [self error: 'Time-To-Live out of range'].
	^self setOption: 'IP_MULTICAST_TTL' value: anInteger

]
