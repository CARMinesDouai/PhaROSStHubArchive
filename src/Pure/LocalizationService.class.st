Class {
	#name : #LocalizationService,
	#superclass : #RobulabService,
	#instVars : [
		'pose',
		'status'
	],
	#category : #'Pure-Services'
}

{ #category : #'initialize-release' }
LocalizationService >> initialize [ 
	super initialize.
	pose := Pose new.
]

{ #category : #accessing }
LocalizationService >> isCentimetric [
	^( (self status=12) | (self status=20))
]

{ #category : #accessing }
LocalizationService >> isDecimetric [
		^((self status=10) | (self status=18))
]

{ #category : #accessing }
LocalizationService >> isExterioreceptive [
	^((self status=20 | self status=18 | self status=17))
]

{ #category : #accessing }
LocalizationService >> isMetric [
	^((self status=9 | self status=17))
]

{ #category : #accessing }
LocalizationService >> isProprioreceptive [
	^((self status=12 | self status=10 | self status=9))
]

{ #category : #'initialize-release' }
LocalizationService >> load: aConnector [
	|  decoder |

	decoder := (self getWith: aConnector) decoder.
	

	self pose x: decoder nextEncodedFloat64. 
	self pose y: decoder nextEncodedFloat64. 
	self pose orientation: decoder nextEncodedFloat64. 
	self status: decoder nextEncodedUint32 . 
	

]

{ #category : #accessing }
LocalizationService >> orientation [
	self deprecated: ' use  localization pose orientation instead of orientation'. 
	^  self pose orientation.
]

{ #category : #'initialize-release' }
LocalizationService >> pose [
	^ pose
]

{ #category : #'initialize-release' }
LocalizationService >> pose: aPose [
	pose := aPose.
]

{ #category : #printing }
LocalizationService >> relatedNotificationClass [
	^ LocalizationNotification
]

{ #category : #request }
LocalizationService >> resetLocalization [

	^ self setLocalization: Pose new.

"	response :=self replace: 'FFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000'."

]

{ #category : #request }
LocalizationService >> setLocalization: aPose [
	| response message |

	message := PureEncoder forArray:( ByteString new: 32 ).
	
	message encodeUInt64: (DateAndTime now) asSeconds.
	message encodefloat64: aPose x.
	message encodefloat64: aPose y.
	message encodefloat64: aPose orientation.	
	
	
	self replace: message contents.

	self load.
]

{ #category : #accessing }
LocalizationService >> status [
	self deprecated: 'Our current robot is not using this information. Despite this value and derivateds from this value'.
	^ status
]

{ #category : #accessing }
LocalizationService >> status: anObject [
	status := anObject
]

{ #category : #accessing }
LocalizationService >> xPos [
	self deprecated: ' use  localization pose x instead of xPos'. 
	^  self pose x.
]

{ #category : #accessing }
LocalizationService >> yPos [
	self deprecated: ' use  localization pose y instead of yPos'. 
	^  self pose y.
]
