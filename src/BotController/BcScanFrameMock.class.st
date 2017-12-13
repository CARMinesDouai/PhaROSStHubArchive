Class {
	#name : #BcScanFrameMock,
	#superclass : #Object,
	#instVars : [
		'angle_increment',
		'angle_max',
		'angle_min',
		'ranges'
	],
	#category : #'BotController-Tests'
}

{ #category : #'instance creation' }
BcScanFrameMock class >> angle_increment: anInteger angle_max: anInteger2 angle_min: anInteger3 ranges: aCollection [ 
	^self new
		angle_increment: anInteger; angle_max: anInteger2; angle_min: anInteger3; ranges: aCollection; 
		yourself

]

{ #category : #accessing }
BcScanFrameMock >> angle_increment [
	^ angle_increment
]

{ #category : #accessing }
BcScanFrameMock >> angle_increment: anObject [
	angle_increment := anObject
]

{ #category : #accessing }
BcScanFrameMock >> angle_max [
	^ angle_max
]

{ #category : #accessing }
BcScanFrameMock >> angle_max: anObject [
	angle_max := anObject
]

{ #category : #accessing }
BcScanFrameMock >> angle_min [
	^ angle_min
]

{ #category : #accessing }
BcScanFrameMock >> angle_min: anObject [
	angle_min := anObject
]

{ #category : #accessing }
BcScanFrameMock >> ranges [
	^ ranges
]

{ #category : #accessing }
BcScanFrameMock >> ranges: anObject [
	ranges := anObject
]
