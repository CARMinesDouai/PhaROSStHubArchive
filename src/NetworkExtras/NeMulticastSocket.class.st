"
An UTMulticastSocket is a sub class of Socket. It is designed for multicast.

Instance Variables
	groupAddress:		<String | IPAddress>
"
Class {
	#name : #NeMulticastSocket,
	#superclass : #NeReceiveUdpSocket,
	#instVars : [
		'groupAddress',
		'multicastPort'
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
NeMulticastSocket >> closeAndDestroy [
	[self leaveGroup] ensure: [
		super closeAndDestroy]
]

{ #category : #accessing }
NeMulticastSocket >> getInterface [
	"mp 2/13/2006 10:02"
	"Get the multicast network interface set."
	
	^ self getOption: 'IP_MULTICAST_IF'
]

{ #category : #accessing }
NeMulticastSocket >> getLoopbackMode [
	"mp 2/13/2006 10:02"
	"Get the setting for local loopback of multicast datagrams."
	
	^ self getOption: 'IP_MULTICAST_LOOP'
]

{ #category : #accessing }
NeMulticastSocket >> getTimeToLive [
	"mp 2/13/2006 10:01"
	"Get the default time-to-live for multicast packets sent out on the socket."
	
	^ self getOption: 'IP_MULTICAST_TTL'
]

{ #category : #'initialize-destroy' }
NeMulticastSocket >> group: anIpAddressString port: aPortNumber [
	self setPort: aPortNumber.
	self groupAddress: anIpAddressString.
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
NeMulticastSocket >> inaddrAny [
	"mp 4/10/2006 16:17"
	
	^ #[0 0 0 0]
]

{ #category : #'group membership' }
NeMulticastSocket >> joinGroup [
	"mp 2/8/2006 14:54"

	"Join the default multicast group (226.0.0.12) on the default interface (0.0.0.0 for INADDR_ANY)"

	| joinParams |
	joinParams := self
		multicastMembershipParametersForAddress: self groupAddress.
	self setOption: 'IP_ADD_MEMBERSHIP' value: joinParams asByteArray
]

{ #category : #'group membership' }
NeMulticastSocket >> leaveGroup [
	"mp 2/8/2006 14:54"

	"Leave the default multicast group (226.0.0.12) on the default interface (0.0.0.0 for INADDR_ANY)"

	| joinParams |
	joinParams := self
		multicastMembershipParametersForAddress: self groupAddress.
	self setOption: 'IP_DROP_MEMBERSHIP' value: joinParams asByteArray
]

{ #category : #'group membership' }
NeMulticastSocket >> multicastMembershipParametersForAddress: aMulticastAddress [ 
	"mp 2/8/2006 15:00"
	"Arguments for leaving a group are the multicast address (226.0.0.12) and the interface to use (0.0.0.0 for INADDR_ANY)"
	
	| joinParams |
	joinParams := aMulticastAddress asOrderedCollection.
	joinParams addAll: self inaddrAny.
	^joinParams
]

{ #category : #communicating }
NeMulticastSocket >> send: aString [
	self 
		sendData: aString
		toHost: self groupAddress
		port: self port.
]

{ #category : #accessing }
NeMulticastSocket >> setInterfaceTo: anIPAddress [
	"mp 2/13/2006 10:02"
	"Specify the network interface for outgoing multicast datagrams sent on this socket."
	
	self setOption: 'IP_MULTICAST_IF' value: anIPAddress
]

{ #category : #accessing }
NeMulticastSocket >> setLoopbackModeTo: aBoolean [
	"mp 2/13/2006 10:02"
	"Disable/Enable local loopback of multicast datagrams. The option is used by the platform's networking code as a hint for setting whether multicast data will be looped back to the local socket."
	
	self setOption: 'IP_MULTICAST_LOOP' value: aBoolean
]

{ #category : #accessing }
NeMulticastSocket >> setTimeToLiveTo: anInteger [
	"mp 2/13/2006 10:02"
	"Set the time-to-live for multicast packets sent out in order to control the scope of the multicasts."
	
	(anInteger between: 0 and: 255) 
		ifFalse: [self error: 'Time-To-Live out of range'].
	^self setOption: 'IP_MULTICAST_TTL' value: anInteger

]
