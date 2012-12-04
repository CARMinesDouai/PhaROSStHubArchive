Class {
	#name : #SocketSet,
	#superclass : #Object,
	#instVars : [
		'set',
		'onActiveSocket',
		'mutex',
		'process',
		'keepRunning'
	],
	#category : #'PhaROS-Kernel-Tcp'
}

{ #category : #'as yet unclassified' }
SocketSet >> cicle [
	| sockets |
	mutex critical: [
		sockets := set select:[ :socket | socket isDataAvailable ].
	].
	sockets do: [ :socket |  onActiveSocket value: socket ].
	
	
]

{ #category : #'as yet unclassified' }
SocketSet >> initialize [ 
	mutex := Mutex new.
]

{ #category : #'as yet unclassified' }
SocketSet >> keepRunning [ 
	| val |
	mutex critical: [
		val := keepRunning.
	].
	^val. 
]

{ #category : #'as yet unclassified' }
SocketSet >> keepRunning: aBoolean [
	mutex critical: [
		keepRunning := aBoolean.
	].

]

{ #category : #'as yet unclassified' }
SocketSet >> onActiveSocket: aBlock [
	onActiveSocket := aBlock.
]

{ #category : #'as yet unclassified' }
SocketSet >> start [
	process ifNotNil: [
		self error: 'already started'.
	].

	process := [
		 [self keepRunning ] whileTrue: [ 
			self cicle. 
			(Delay  forMilliseconds: 1000) wait.
		].
		process := nil.
	] fork. 
]

{ #category : #'as yet unclassified' }
SocketSet >> stop [
	self keepRunning: false.
	Delay forMilliseconds: 10.
	process ifNotNil: [ process terminate. ].
	process := nil.
]

{ #category : #'as yet unclassified' }
SocketSet >> subscribeSocket: aSocket [
	mutex critical: [
		set add: aSocket.		
	].
]
