Class {
	#name : #PhaROSNodeBuilder,
	#superclass : #PhaROSBaseElement,
	#category : #'PhaROS-Launch'
}

{ #category : #'as yet unclassified' }
PhaROSNodeBuilder class >> package: aPackageName type:aType named: aName [
	^ self new pkg: aPackageName; type:aType ;name: aName; yourself 
]

{ #category : #properties }
PhaROSNodeBuilder >> args: aString [
	self  at: #args put: aString ofType: String.
]

{ #category : #properties }
PhaROSNodeBuilder >> doesNotUnderstand: aMessage [

	((aMessage selector numArgs = 1) and:[ (aMessage selector indexOf:$: )> 0  ] )ifTrue: [
		| parameter value |
		parameter := ( (':' split: aMessage selector ) at:1).
		value := ( aMessage arguments at: 1).
		self param: parameter value: value asString.
		^ self.
	].

	super doesNotUnderstand: aMessage.
]

{ #category : #properties }
PhaROSNodeBuilder >> name: aName [
	^ self at: #name put: aName ofType: String.
]

{ #category : #properties }
PhaROSNodeBuilder >> nodeName [ 
	^ 'node'
]

{ #category : #properties }
PhaROSNodeBuilder >> output: aType [
	^ self  at: #output put: aType ofType: String.
]

{ #category : #childs }
PhaROSNodeBuilder >> param [
	^ self addChild: PhaROSNamedLeafElement parameter. 
]

{ #category : #childs }
PhaROSNodeBuilder >> param: aName value: aValue [
	^ self param name: aName; value: aValue; yourself.
	
]

{ #category : #properties }
PhaROSNodeBuilder >> pkg: aName [
	^ self  at: #pkg put: aName ofType: String.
]

{ #category : #childs }
PhaROSNodeBuilder >> remap [
	^ self addChild: PhaROSNamedLeafElement remap. 
]

{ #category : #childs }
PhaROSNodeBuilder >> remap: aStringFrom to: aStringTo [
	^ self remap from:  aStringFrom; to: aStringTo. 
]

{ #category : #properties }
PhaROSNodeBuilder >> respawn: aBoolean [
	self  at: #respawn put: aBoolean ofType: Boolean.
	
]

{ #category : #childs }
PhaROSNodeBuilder >> rosparam [
	^ self addChild: PhaROSNamedLeafElement rosparameter. 
	
]

{ #category : #properties }
PhaROSNodeBuilder >> type: aType [
	^ self  at: #type put: aType ofType: String.
]
