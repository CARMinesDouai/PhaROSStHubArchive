Class {
	#name : #PhaROSExternalPublisherNode,
	#superclass : #PhaROSExternalNode,
	#instVars : [
		'msg',
		'stream',
		'tries',
		'channel',
		'xmlurl',
		'process'
	],
	#category : #'PhaROS-Kernel-ExternalNodes'
}

{ #category : #'as yet unclassified' }
PhaROSExternalPublisherNode >> channel: aChannel [
	channel := aChannel 
]

{ #category : #'as yet unclassified' }
PhaROSExternalPublisherNode >> finalize [ 
	super finalize.
	process finalize.
	process := nil.
	topic := nil.
	stream close.
	stream := nil.
	msg := nil.
	channel := nil.
]

{ #category : #'as yet unclassified' }
PhaROSExternalPublisherNode >> setup [
	
	msg := topic newMessage.	
	stream := SocketStream on: self socket. 
	stream binary.
	stream timeout: self timeout.
	tries := 0.
	
	process := self paralellize looping spinOnce asStickyReference.


]

{ #category : #'as yet unclassified' }
PhaROSExternalPublisherNode >> spinOnce [
	| disconnect |

	[
		[
			[
				socket isConnected ifTrue: [
					stream peek ifNotNil: [
						msg loadStream: stream.
						channel send: msg value.
					].	
				] ifFalse: [
					disconnect := true.
				] 
			]  on: ConnectionClosed  do: [ : ct | disconnect := true. ].
		] on: ConnectionTimedOut do: [ :e | Transcript show: 'Timeout---- '; cr. ].
	] on: Error do: [: err | Transcript show:  err messageText ; cr.  ].
	
	disconnect ifNotNil: [
		channel unsubscribe: self.
		process cancel.	
		process := nil.
	]
]

{ #category : #'as yet unclassified' }
PhaROSExternalPublisherNode >> timeout [
	^ 60.
]

{ #category : #service }
PhaROSExternalPublisherNode >> xmlurl [ 
	^ xmlurl 
]

{ #category : #service }
PhaROSExternalPublisherNode >> xmlurl: 	anUrl [
		xmlurl := anUrl 
]
