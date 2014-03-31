Class {
	#name : #PhaROSServer,
	#superclass : #Object,
	#instVars : [
		'delegate',
		'loop',
		'listener',
		'port'
	],
	#category : #'PhaROS-Network-Tcp'
}

{ #category : #'as yet unclassified' }
PhaROSServer class >> startOn: aPort delegate: aDelegate [
	^ self new listener: (ZnNetworkingUtils serverSocketOn: aPort); delegate: aDelegate; port: aPort; loop; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSServer >> acceptWaitTimeout [
	^ 300.
]

{ #category : #'as yet unclassified' }
PhaROSServer >> delegate: aDelegateClosure [
	delegate := aDelegateClosure.
]

{ #category : #'as yet unclassified' }
PhaROSServer >> listener: aListener [ 
	listener := aListener.
	
]

{ #category : #'as yet unclassified' }
PhaROSServer >> loop [
	^ loop ifNil: [ loop := self paralellize looping serve asStickyReference ].
]

{ #category : #'as yet unclassified' }
PhaROSServer >> noteAcceptWaitTimedOut [
	" IDLE Time tasks "
]

{ #category : #accessing }
PhaROSServer >> port [
	^ port.
]

{ #category : #'as yet unclassified' }
PhaROSServer >> port: aPortNumber [
	 ^ port.
]

{ #category : #'as yet unclassified' }
PhaROSServer >> serve [
	| socket |

	(socket := (listener waitForAcceptFor: self acceptWaitTimeout)) ifNil: [
		 self noteAcceptWaitTimedOut. 
	 ] ifNotNil: [
		delegate value: socket. 
	].

]

{ #category : #'as yet unclassified' }
PhaROSServer >> stop [
	loop finalize.
	loop := nil. 
]
