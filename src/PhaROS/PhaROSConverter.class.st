Class {
	#name : #PhaROSConverter,
	#superclass : #Object,
	#instVars : [
		'convertTo'
	],
	#category : #'PhaROS-MessageAdapter'
}

{ #category : #construction }
PhaROSConverter class >> convertTo: aClass [
	^ self new convertTo: aClass; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSConverter >> adapToAdapter [ 
	^ self 
]

{ #category : #'as yet unclassified' }
PhaROSConverter >> convert: aPhaROSValue into: anExpectedType [
	
]

{ #category : #'as yet unclassified' }
PhaROSConverter >> convertTo: aClass [
	convertTo := aClass.
]

{ #category : #'as yet unclassified' }
PhaROSConverter >> positionToPoint: aPhaROSValue [ 
	< from: #Geometry_msgsPoint to: #Point >
	^ aPhaROSValue x @ aPhaROSValue y.
	


]

{ #category : #'as yet unclassified' }
PhaROSConverter >> printOn: aStream [
	aStream nextPutAll: '(=> ', convertTo name, ')'.
]
