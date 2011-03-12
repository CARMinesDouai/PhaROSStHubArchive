"
This class represent a datagramPacket. It is used to transfert data by UDP protocol.
"
Class {
	#name : #OCNDatagramPacket,
	#superclass : #Object,
	#instVars : [
		'sourceAddress',
		'targetAddress',
		'data',
		'more'
	],
	#category : #'Ocean-Kernel'
}

{ #category : #'setting-getting' }
OCNDatagramPacket >> data [
	^data
]

{ #category : #'setting-getting' }
OCNDatagramPacket >> data: aByteArray [
	data:= aByteArray
]

{ #category : #'setting-getting' }
OCNDatagramPacket >> dataSize [
	^self data size
]

{ #category : #'setting-getting' }
OCNDatagramPacket >> more [
	^more
]

{ #category : #'setting-getting' }
OCNDatagramPacket >> more: aBoolean [
	more:= aBoolean
]

{ #category : #'setting-getting' }
OCNDatagramPacket >> sourceAddress [
	^sourceAddress
]

{ #category : #'setting-getting' }
OCNDatagramPacket >> sourceAddress: anOCNSocketAddress [
	sourceAddress:= anOCNSocketAddress
]

{ #category : #'setting-getting' }
OCNDatagramPacket >> sourceIP: anIPAddress port: aPort type: aSocketAddressClass [
	sourceAddress := aSocketAddressClass new
							ip: anIPAddress;
							port: aPort
]

{ #category : #'setting-getting' }
OCNDatagramPacket >> targetAddress [
	^ targetAddress
]

{ #category : #'setting-getting' }
OCNDatagramPacket >> targetAddress: anOCNSocketAddress [
	^targetAddress:= anOCNSocketAddress
]

{ #category : #'setting-getting' }
OCNDatagramPacket >> targetIP: anIPAddress port: aPort type: aSocketAddressClass [
	sourceAddress := aSocketAddressClass new
							ip: anIPAddress;
							port: aPort
]

{ #category : #testing }
OCNDatagramPacket >> verify [
	"verify the coherence of the datagramPacket. If it is ok, it rturn true, else it raises an error"
	"self shouldBeImplemented"
	^ true.
]
