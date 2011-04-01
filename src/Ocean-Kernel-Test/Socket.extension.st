Extension { #name : #Socket }

{ #category : #'*Ocean-Kernel-TestSupport' }
Socket >> primSocketBind: socketID to: anIntFromIPAddress port: aPortNumber [
	<primitive: 'primitiveSocketBindToPort' module: 'SocketPlugin'>
	self primitiveFailed
]
