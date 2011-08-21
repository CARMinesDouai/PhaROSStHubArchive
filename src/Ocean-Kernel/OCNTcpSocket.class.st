Class {
	#name : #OCNTcpSocket,
	#superclass : #OCNSocket,
	#category : #'Ocean-Kernel'
}

{ #category : #accessing }
OCNTcpSocket >> refreshState [
	state = self connectedStateSymbol ifFalse: [^self].
	(self networkLibrary isSocketConnected: self) ifFalse: [self basicDestroy]

]

{ #category : #accessing }
OCNTcpSocket >> state [
	self refreshState.
	^super state
]
