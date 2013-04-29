Class {
	#name : #PhaROSSelfProcessedExternalNode,
	#superclass : #PhaROSExternalNode,
	#instVars : [
		'msg',
		'stream',
		'tries',
		'processResult'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> attend: aChannel [
		[ self spinOnceOver: aChannel ] on: Error do: [: e | self manageError: e ].

]

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> checkConnection [
	socket isConnected ifFalse:[
		PhaROSError signal: 'Socket closed'.	
	].

]

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> manageError: e [ 	
	(e class isTimeOut ) ifFalse: [ 
		self stop.
	].

]

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> setup [
	
	msg := topic newMessage.	
	stream := SocketStream on: self socket. 
	stream binary.
	stream timeout: self timeout.
	tries := 0.
	


]

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> spinOnceOver: aChannel [
	
	self checkConnection. 
	stream peek ifNotNil: [
		msg loadStream: stream.
		aChannel send: msg.
	] 
]

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> stop [
	socket close. 
	processResult  := nil.
]

{ #category : #'as yet unclassified' }
PhaROSSelfProcessedExternalNode >> timeout [
	^ 60.
]

{ #category : #accessing }
PhaROSSelfProcessedExternalNode >> workWith: aChannel [
	self setup. 
	processResult := (self paralellize looping attend: aChannel) asStickyReference. 
	

]
