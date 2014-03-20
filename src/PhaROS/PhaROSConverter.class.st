"
A PhaROSConverter is an adaption-polimorifc object that make conversions between an object of one type to other type. This is for makeing easy go from a generated type to a business-domain object
"
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
	< from: #TurtlesimVelocity to: #Point >
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
PhaROSConverter >> ifConfigurationsFor: anArrayConf at: aClass do: aBlock [
	| pragmas |
	pragmas :=  (Pragma allNamed: #from:to: in: aClass class) select: [
		: pragma |  pragma arguments = anArrayConf
	].
	pragmas size > 0 ifTrue: [ aBlock value: pragmas ]
]

{ #category : #'as yet unclassified' }
PhaROSConverter >> lookUpConverterFrom: aClass to: anOtherClass [

	| apply |
	
	converter ifNotNil: [ ^ converter ].
	
	apply := [ : pragmas :class | 
		pragmas size > 1 ifTrue: [ self warn: 'There is more than one way to convert ', aClass name, ' to ', anOtherClass name ].
		^  (converter:= [ : aValueToConvert | (pragmas at:1) method valueWithReceiver: class class arguments: { aValueToConvert } ])
	].

	self ifConfigurationsFor: { aClass name asSymbol . anOtherClass name asSymbol} at: anOtherClass do: [ : pragmas | 
		apply value: pragmas value: anOtherClass 
	].

	self ifConfigurationsFor: { aClass name asSymbol . anOtherClass name asSymbol} at: PhaROSConverter do: [ : pragmas | 
		apply value: pragmas value: PhaROSConverter 
	].
		
	self error: 'There is not way to convert ', aClass name, ' to ', anOtherClass name.

]

{ #category : #'as yet unclassified' }
PhaROSConverter >> printOn: aStream [
	aStream nextPutAll: '(=> ', convertTo name, ')'.
]
