"
This service provides measurements from a laser range finder. A laser range finder is a sensor that measures an array distances at different angles, called a scan. A pair (angle, distance) is called an echo.
"
Class {
	#name : #PNGLaserService,
	#superclass : #PNGNotifyingService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGLaserService class >> notificationClass [
	^PNGLaserNotification 
]

{ #category : #constants }
PNGLaserService class >> serviceType [ 
	^ 16r4004
]

{ #category : #actions }
PNGLaserService >> decodeEchoFromDecoder: aDecoder [
	| echo |
	echo := PNGLaserEcho new.
	echo angle: aDecoder nextEncodedFloat32.
	echo distance: aDecoder nextEncodedFloat32.
	^echo
]

{ #category : #actions }
PNGLaserService >> decodeEchoesFromDecoder: aDecoder [
	| echoes |
	echoes := OrderedCollection new: 271.
	[aDecoder hasData] whileTrue: [
		echoes add: (self decodeEchoFromDecoder: aDecoder)
	].
	^echoes
]

{ #category : #actions }
PNGLaserService >> getCommandString [
	"Byte       1             2         3-4
Content  Identifier  Action  Target"
	^'01000400'
]

{ #category : #public }
PNGLaserService >> properties [
	^self get
]
