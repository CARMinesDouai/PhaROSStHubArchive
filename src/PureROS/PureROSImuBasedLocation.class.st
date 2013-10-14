Class {
	#name : #PureROSImuBasedLocation,
	#superclass : #Object,
	#instVars : [
		'previousPosition',
		'ammount',
		'previousPositionTime',
		'orientationTime',
		'orientation',
		'currentPose'
	],
	#category : #'PureROS-Util'
}

{ #category : #'as yet unclassified' }
PureROSImuBasedLocation >> ammountOfMovement: aPosition [
	| dx dy |

	dx := (aPosition x - previousPosition x).
	dy := (aPosition y - previousPosition y).
	
	^ ((dx*dx)*(dy*dy)) sqrt.
]

{ #category : #'as yet unclassified' }
PureROSImuBasedLocation >> notificateOrientation: anOrientation [
	orientationTime := DateAndTime now.
	orientation := anOrientation.
	
	
	
]

{ #category : #'as yet unclassified' }
PureROSImuBasedLocation >> notificatePosition: aPosition [
	previousPositionTime := DateAndTime now.
	ammount := self ammountOfMovement: aPosition.
	previousPosition := aPosition.
	
	
]

{ #category : #'as yet unclassified' }
PureROSImuBasedLocation >> pose [
	| now |
	now := DateAndTime now.
	
	((orientationTime - previousPositionTime) asMilliSeconds abs < 100 ) ifTrue: [
"		put all together here. "
		(now - orientationTime ) asMilliSeconds abs > 400 ifTrue: [
			self log: 'Warn- Information about orientation and localization is old '
		].
		currentPose := PNGRobotPose x:(ammount * orientation cos) y: (ammount * orientation sin) o: orientation.
	] ifFalse: [
		self log: 'Error- Orientation and localization are desincronized'.
	].

	^ currentPose.
]
