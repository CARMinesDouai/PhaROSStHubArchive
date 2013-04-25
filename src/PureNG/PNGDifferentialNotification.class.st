Class {
	#name : #PNGDifferentialNotification,
	#superclass : #PNGNotification,
	#instVars : [
		'targetLinearSpeed',
		'currentLinearSpeed',
		'targetAngularSpeed',
		'currentAngularSpeed',
		'status'
	],
	#category : #'PureNG-Notifications'
}

{ #category : #accessing }
PNGDifferentialNotification >> currentAngularSpeed [
	^ currentAngularSpeed
]

{ #category : #accessing }
PNGDifferentialNotification >> currentLinearSpeed [
	^ currentLinearSpeed
]

{ #category : #'initialize-release' }
PNGDifferentialNotification >> initWithDecoder: aDecoder [
	status := aDecoder nextEncodedByte.
	targetLinearSpeed := aDecoder nextEncodedFloat32.
	currentLinearSpeed := aDecoder nextEncodedFloat32.
	targetAngularSpeed := aDecoder nextEncodedFloat32.
	currentAngularSpeed := aDecoder nextEncodedFloat32.
]

{ #category : #accessing }
PNGDifferentialNotification >> status [
	^ status
]

{ #category : #accessing }
PNGDifferentialNotification >> targetAngularSpeed [
	^ targetAngularSpeed
]

{ #category : #accessing }
PNGDifferentialNotification >> targetLinearSpeed [
	^ targetLinearSpeed
]
