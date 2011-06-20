"
|socket|
socket := OCNUdpSocket new.
socket networkLibrary: OCNSocketPluginLibrary new.
serverAddress := OCNIPV4SocketAddress loopbackAddressWithPort: 9876.
myAddress := OCNIPV4SocketAddress loopbackAddressWithPort: 9879.

datagram := OCNDatagramPacket new sourceAddress: myAddress;targetAddress: serverAddress; data: (ByteArray new:200).

socket send: datagram.
datagram := socket receive.
socket destroy.
datagram data asString


====

|socket|
socket := OCNUdpSocket new.
socket networkLibrary: OCNSocketPluginLibrary new.
serverAddress := OCNIPV4SocketAddress loopbackAddressWithPort: 6789.
myAddress := OCNIPV4SocketAddress loopbackAddressWithPort: 9879.

toSend := '2Bonjour ' asByteArray.

datagram := OCNDatagramPacket new sourceAddress: myAddress;targetAddress: serverAddress; 
data: toSend.

socket send: datagram.
datagram := socket receive.
socket destroy.
datagram data asString


=====

|socket|
socket := OCNUdpSocket new.
socket networkLibrary: OCNSocketPluginLibrary new.
serverAddress := OCNIPV4SocketAddress loopbackAddressWithPort: 6789.
myAddress := OCNIPV4SocketAddress loopbackAddressWithPort: 9878.

""aString := String new.
socket networkLibrary primSocket: socket socketId getOption: aString.
aString""

toSend := '2Bonjour ' asByteArray.

datagram := OCNDatagramPacket new sourceAddress: myAddress;targetAddress: serverAddress; data: toSend.

socket send: datagram.
datagram := socket receive.

socket destroy.
datagram data asString

OCNUdpSocket allInstances do:[:e | [e networkLibrary primSocketAbortConnection: e] on: Error do:[] ].
OCNUdpSocket allInstances do:[:e | [e networkLibrary close: e] on: Error do:[] ].
OCNUdpSocket allInstances do:[:e |[e destroy ] on: Error do:[]].
OCNUdpSocket allInstances.

OCNSocketPluginLibrary allInstances do:[:e |[e unregisterSemaphores ] on: Error do:[]].

Smalltalk garbageCollectMost.

"
Class {
	#name : #OCNUdpSocketTest,
	#superclass : #OCNSocketTest,
	#category : #'Ocean-KernelTests'
}

{ #category : #accessing }
OCNUdpSocketTest >> socketClass [ 
	^OCNUdpSocket
]
