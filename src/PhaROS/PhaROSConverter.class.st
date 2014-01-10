Class {
	#name : #PhaROSConverter,
	#superclass : #Object,
	#instVars : [
		'convertTo',
		'converter'
	],
	#category : #'PhaROS-TopicHandlers'
}

{ #category : #construction }
PhaROSConverter class >> convertTo: aClass [
	^ self new convertTo: aClass; yourself.
]

{ #category : #'convertion-registry' }
PhaROSConverter class >> positionToPoint: aPhaROSValue [ 
	< from: #Geometry_msgsPoint to: #Point >
	^ aPhaROSValue x @ aPhaROSValue y.

]

{ #category : #'convertion-registry' }
PhaROSConverter class >> turtlesimVelocityToPoint: aPhaROSValue [ 
	< from: #Turtle_actionlibVelocity to: #Point >
	^ aPhaROSValue linear @ aPhaROSValue angular.

]

{ #category : #'as yet unclassified' }
PhaROSConverter >> adapt: aPhaROSValue [ 
	| constructor |
	
	constructor := ('from', aPhaROSValue class name,':') asSymbol.
	(convertTo class canUnderstand:  constructor ) ifTrue: [
		^ convertTo perform: constructor with: aPhaROSValue.
	].
	
	^ (self lookUpConverterFrom: aPhaROSValue class to: convertTo) value: aPhaROSValue.
	
]

{ #category : #'as yet unclassified' }
PhaROSConverter >> adaptToAdapter [ 
	^ self 
]

{ #category : #'as yet unclassified' }
PhaROSConverter >> convertTo: aClass [
	convertTo := aClass.
]

{ #category : #'as yet unclassified' }
PhaROSConverter >> lookUpConverterFrom: aClass to: anOtherClass [

	| pragmas |
	
	converter ifNotNil: [ ^ converter ].
	
	pragmas := (Pragma allNamed: #from:to: in: PhaROSConverter class) select: [
		: pragma |  pragma arguments = { aClass name asSymbol . anOtherClass name asSymbol}.
	].
	pragmas size = 0 ifTrue: [ self error: 'There is not way to convert ', aClass name, ' to ', anOtherClass name ].
	pragmas size > 1 ifTrue: [ self warn: 'There is more than one way to convert ', aClass name, ' to ', anOtherClass name ].
	pragmas := pragmas at:1.
	
	converter:=  [ : aValueToConvert | pragmas method valueWithReceiver: PhaROSConverter class arguments: { aValueToConvert } ].
	^ converter. 
]

{ #category : #'as yet unclassified' }
PhaROSConverter >> printOn: aStream [
	aStream nextPutAll: '(=> ', convertTo name, ')'.
]
