"
Really naive mock. Just take the DNU and feed a collection returning the same object. 
"
Class {
	#name : #PureROSMessageRegisterForTests,
	#superclass : #Object,
	#instVars : [
		'messages'
	],
	#category : #'PureROS-Controllers-Tests'
}

{ #category : #'as yet unclassified' }
PureROSMessageRegisterForTests >> doesNotUnderstand: aMessage [
	messages add: aMessage
]

{ #category : #'as yet unclassified' }
PureROSMessageRegisterForTests >> initialize [ 
	messages := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
PureROSMessageRegisterForTests >> isEmpty [ 
	^ messages isEmpty.
]

{ #category : #'as yet unclassified' }
PureROSMessageRegisterForTests >> messages [ 
	^ messages 
]

{ #category : #'as yet unclassified' }
PureROSMessageRegisterForTests >> printOn: aStream [
	'Tracker>' printOn:aStream.
	(messages collect: #selector) printOn:aStream.
]
