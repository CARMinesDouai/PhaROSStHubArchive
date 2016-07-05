Class {
	#name : #PrDataArray,
	#superclass : #PhaROSValue,
	#instVars : [
		'data'
	],
	#category : #PhaRosRelay
}

{ #category : #'instance creation' }
PrDataArray class >> data: byteArray [
	^self new
		data: byteArray ;
		yourself
]

{ #category : #accessing }
PrDataArray >> data [
	^ data ifNil: [ #[] ]
]

{ #category : #accessing }
PrDataArray >> data: anObject [
	data := anObject
]
