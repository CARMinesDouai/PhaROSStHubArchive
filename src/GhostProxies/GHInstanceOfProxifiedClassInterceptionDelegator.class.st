Class {
	#name : #GHInstanceOfProxifiedClassInterceptionDelegator,
	#superclass : #Object,
	#category : #GhostProxies
}

{ #category : #'as yet unclassified' }
GHInstanceOfProxifiedClassInterceptionDelegator >> cannotInterpret: aMessage [ 
	| interception context  counter|
	self log:  'cannotInterpret:  ', aMessage selector.
	self log:  'Stack:  '.
	self log:  '----------------'.
		
	context := thisContext sender.
	counter := 0.
	[context isNil not and: [counter < 50]] whileTrue:  [
		self log: context  method ghostPrintString.
		context := context sender.
		counter := counter + 1.
		].

	^ aMessage lookupClass handleInterceptionToInstance: aMessage andReceiver: self
	

]
