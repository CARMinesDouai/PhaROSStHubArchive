Class {
	#name : #ChaMultiPortComponent,
	#superclass : #ChaComponent,
	#instVars : [
		'portsDict'
	],
	#category : #'ReactiveRobot-Experiments'
}

{ #category : #'instance creation' }
ChaMultiPortComponent class >> portSetters: singleArgSelectors [
	^self new
		portSetters: singleArgSelectors;
		yourself

]

{ #category : #accessing }
ChaMultiPortComponent >> dataOnPort: portName [
	| port |
	port := self portNamed: portName ifAbsent: [^super dataOnPort: portName].
	^port get
]

{ #category : #'reflective operations' }
ChaMultiPortComponent >> doesNotUnderstand: aMessage [
	| port |
	port := self portNamed: aMessage selector ifAbsent: [^ super doesNotUnderstand: aMessage].
	^port set: aMessage argument
]

{ #category : #accessing }
ChaMultiPortComponent >> portNamed: portName [
	^self portNamed: portName ifAbsent: [ super portNamed: portName ]
]

{ #category : #accessing }
ChaMultiPortComponent >> portNamed: setterSelector ifAbsent: aBlock [
	^portsDict at: setterSelector ifAbsent: aBlock
]

{ #category : #'initialize-release' }
ChaMultiPortComponent >> portSetters: singleArgSelectors [
	portsDict := Dictionary new.
	singleArgSelectors do: [ : selector | 
		portsDict at: selector put: self newPort
	]

]
