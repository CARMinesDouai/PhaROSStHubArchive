"
I am an UDP socket dedicated to multicast communication.  I can join and leave a group.

When enabling loopback mode, I receive a copy of datagrams I send.

By default, multicast datagrams are sent with a default TTL (Time To Leave) value of 1, to prevent them to be forwarded beyond the local network. Setting TTL to other values enable receivers to forward data to other networks they are connected to. The TTL is decremented upon each forward, when reaching 0, data is not forwarded anymore.


I use the same port for sending and receiving data.


    Instance Variables
	groupAddress:		<NeIpAddress>
	networkInterfaceIp:		<Object>


    Implementation Points
"
Class {
	#name : #NeMulticastSocket,
	#superclass : #NeUdpSocket,
	#instVars : [
		'groupAddress',
		'networkInterfaceIp'
	],
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #'instance creation' }
NeMulticastSocket class >> group: groupIp port: anInteger [
	^self new
		group: groupIp port: anInteger;
		yourself
]

{ #category : #'initialize-destroy' }
NeMulticastSocket >> close [
	[self leaveGroup] ensure: [
		super close]
]

{ #category : #accessing }
NeMulticastSocket >> defaultNetworkInterfaceIp [
	^ #[0 0 0 0]
]

{ #category : #'initialize-destroy' }
NeMulticastSocket >> group: anIpAddress port: aPortNumber [
	self setPort: aPortNumber.
	self groupAddress: anIpAddress.
	self joinGroup.
]

{ #category : #accessing }
NeMulticastSocket >> groupAddress [
	^ groupAddress
]

{ #category : #accessing }
NeMulticastSocket >> groupAddress: aStringOrIPAddress [ 
	groupAddress := aStringOrIPAddress asIpAddress
]

{ #category : #accessing }
NeMulticastSocket >> groupPort [
	^self receptionPort
]

{ #category : #accessing }
NeMulticastSocket >> isLoopbackModeEnabled [
	"mp 2/13/2006 10:02"
	"Get the setting for local loopback of multicast datagrams."
	
	^ (self getOption: 'IP_MULTICAST_LOOP') ~= #(0 0)
]

{ #category : #accessing }
NeMulticastSocket >> isLoopbackModeEnabled: aBoolean [
	"mp 2/13/2006 10:02"
	"Disable/Enable local loopback of multicast datagrams. The option is used by the platform's networking code as a hint for setting whether multicast data will be looped back to the local socket."
	
	self setOption: 'IP_MULTICAST_LOOP' value: aBoolean
]

{ #category : #'group membership' }
NeMulticastSocket >> joinGroup [
	self setOption: 'IP_ADD_MEMBERSHIP' value: self joinParams
]

{ #category : #'group membership' }
NeMulticastSocket >> joinParams [
	^self multicastMembershipParametersForAddress: self groupAddress.

]

{ #category : #'group membership' }
NeMulticastSocket >> leaveGroup [
		self setOption: 'IP_DROP_MEMBERSHIP' value: self joinParams
]

{ #category : #'group membership' }
NeMulticastSocket >> multicastMembershipParametersForAddress: aMulticastAddress [ 
	"Arguments for managing multicast membership is the IP address and the network interface."
	
	| joinParams |
	joinParams := aMulticastAddress asOrderedCollection.
	joinParams addAll: self networkInterfaceIp.
	^joinParams asByteArray
]

{ #category : #accessing }
NeMulticastSocket >> networkInterface [
	"mp 2/13/2006 10:02"
	"Get the multicast network interface set."
	
	^ self getOption: 'IP_MULTICAST_IF'
]

{ #category : #accessing }
NeMulticastSocket >> networkInterfaceIp [
	^networkInterfaceIp ifNil: [ self defaultNetworkInterfaceIp ]
]

{ #category : #accessing }
NeMulticastSocket >> networkInterfaceIp: anIPAddress [
	networkInterfaceIp :=  anIPAddress asIpAddress.	
	self setOption: 'IP_MULTICAST_IF' value: networkInterfaceIp.
]

{ #category : #sending }
NeMulticastSocket >> targetIp [
	^self groupAddress

]

{ #category : #sending }
NeMulticastSocket >> targetPort [
	^self groupPort.
]

{ #category : #sending }
NeMulticastSocket >> timeToLiveOptionId [
		^'IP_MULTICAST_TTL'
]
