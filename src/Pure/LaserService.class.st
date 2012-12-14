Class {
	#name : #LaserService,
	#superclass : #RobulabService,
	#instVars : [
		'xPosition',
		'yPosition',
		'orientation',
		'echoNumber'
	],
	#category : #'Pure-Services'
}

{ #category : #accessing }
LaserService >> echoNumber [
	^ echoNumber
]

{ #category : #accessing }
LaserService >> echoNumber: anInteger [
	echoNumber:= anInteger.
]

{ #category : #request }
LaserService >> getData [ 
	| compteurEcho decoder |

	decoder := self get decoder.

	
	self xposition: decoder nextEncodedFloat32. 
	self yposition: decoder nextEncodedFloat32. 

	self orientation: decoder nextEncodedFloat32. 
	self echoNumber: decoder nextEncodedInt32. 

	
]

{ #category : #request }
LaserService >> getDataWith: aConnector [ 
	| decoder get |

	get := self getWith: aConnector . 
	get ifNil: [ ^ nil ].
	decoder := get decoder.

	
	self xposition: decoder nextEncodedFloat32. 
	self yposition: decoder nextEncodedFloat32. 

	self orientation: decoder nextEncodedFloat32. 
	self echoNumber: decoder nextEncodedInt32. 

	
]

{ #category : #'initialize-release' }
LaserService >> initialize [ 
	self echos: Dictionary new.
	self semaphore: Semaphore new.
]

{ #category : #accessing }
LaserService >> maxAcceptableRange [
	 ^10.0
]

{ #category : #accessing }
LaserService >> orientation [
	^orientation
]

{ #category : #accessing }
LaserService >> orientation: aFloat [
	orientation:= aFloat.
]

{ #category : #request }
LaserService >> receiveNotificationFromRobulab: aMessage [
"	| decoder idx |
	decoder := aMessage decoder ."
	
	"maybe is 11 here. Must avoid the header of the message"
"	self flag:#NoticeComment.
	decoder nextEncodedBytes: 8.
	idx := 0.
	[decoder hasData ] whileTrue: [ 
		| echo |
			echo := LaserEcho createEchoWithAngle: ( decoder nextEncodedFloat32 ) andFloatDistance: (decoder nextEncodedFloat32).
			idx := idx + 1.
			self echos at: idx put: echo.
""			Transcript cr; show: idx asString, ' ', echo asString.""
			
	].
	self echoNumber: idx.
	self semaphore signal.
"
]

{ #category : #printing }
LaserService >> relatedNotificationClass [
	^ LaserNotification
]

{ #category : #accessing }
LaserService >> xposition [
	^xPosition.
]

{ #category : #accessing }
LaserService >> xposition: aFloat [
	xPosition:= aFloat.
]

{ #category : #accessing }
LaserService >> yposition [
	^yPosition.
]

{ #category : #accessing }
LaserService >> yposition: aFloat [
	yPosition:= aFloat.
]
