Class {
	#name : #GHInstanceOfProxifiedClassInterceptionDelegator,
	#superclass : #Object,
	#category : #GhostProxies
}

{ #category : #'as yet unclassified' }
GHInstanceOfProxifiedClassInterceptionDelegator >> cannotInterpret: aMessage [ 
	| interception context  counter|
	
	"In this case, 'self' is the instance whose class was proxified. Therefore, we cannot send ANY message to 'self' because we will cause an infinitive loop '"
	GHGhostLogger logger log:   'cannotInterpret:  ', aMessage selector.
	GHGhostLogger logger log:   'Stack:  '.
	GHGhostLogger logger log:   '----------------'.
		
	context := thisContext sender.
	counter := 0.
	[context isNil not and: [counter < 50]] whileTrue:  [
		GHGhostLogger logger log:  context  method ghostPrintString.
		context := context sender.
		counter := counter + 1.
		].

	^ aMessage lookupClass handleInterceptionToInstance: aMessage andReceiver: self
	

]
