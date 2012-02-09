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

{ #category : #'instance creation' }
GHInterception class >> for: aMessage proxy: aProxy [
	^ self new initializeWith: aMessage proxy: aProxy receiver: nil. 
]

{ #category : #initialization }
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
