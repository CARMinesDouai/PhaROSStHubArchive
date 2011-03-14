Class {
	#name : #OCNUdpSocketTest,
	#superclass : #OCNSocketTest,
	#category : #'Ocean-Kernel-Test'
}

{ #category : #'server management' }
OCNUdpSocketTest >> serverCommandString [ 
	^'nc -4 -lu'
]

{ #category : #accessing }
OCNUdpSocketTest >> socketClass [ 
	^OCNUdpSocket
]
