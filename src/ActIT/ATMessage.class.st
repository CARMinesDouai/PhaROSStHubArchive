Class {
	#name : #ATMessage,
	#superclass : #TKTTask,
	#instVars : [
		'message',
		'receiver'
	],
	#category : #'ActIT-Kernel'
}

{ #category : #'as yet unclassified' }
ATMessage >> executeWithFuture: aFuture [

	^ receiver perform: message selector withArguments: message arguments
]

{ #category : #'as yet unclassified' }
ATMessage >> message: aMessage [

	message := aMessage
]

{ #category : #'as yet unclassified' }
ATMessage >> receiver: aReceiver [

	receiver := aReceiver
]
