Class {
	#name : #GHInterception,
	#superclass : #Object,
	#instVars : [
		'message',
		'proxy',
		'receiver'
	],
	#category : #GhostProxies
}

{ #category : #'as yet unclassified' }
GHInterception class >> for: aMessage proxy: aProxy [
	^ self new initializeWith: aMessage proxy: aProxy receiver: nil. 
]

{ #category : #'as yet unclassified' }
GHInterception >> initializeWith: aMessage proxy: aProxy receiver: aReceiver [
	message := aMessage.
	proxy := aProxy.
	receiver := aReceiver.
]

{ #category : #accessing }
GHInterception >> message [
	^ message
]

{ #category : #accessing }
GHInterception >> proxy [
	^ proxy
]

{ #category : #accessing }
GHInterception >> receiver [
	^ receiver
]
