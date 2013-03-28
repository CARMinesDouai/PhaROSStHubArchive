"
This service exposes an array of telemeters. A telemeter is a sensor that measures a distance. Typically, ultrasonic sensors, or infrared sensors are available through this service.
"
Class {
	#name : #PNGTelemeterService,
	#superclass : #PNGNotifyingService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGTelemeterService class >> notificationClass [
	^PNGTelemeterNotification 
]

{ #category : #constants }
PNGTelemeterService class >> serviceType [ 
	^ 16r4008
]

{ #category : #'as yet unclassified' }
PNGTelemeterService >> decodeDistancesFromDecoder: aDecoder [
	| distances |
	distances := OrderedCollection new: 16.
	[aDecoder hasData] whileTrue: [
		distances add: aDecoder nextEncodedFloat32
	].
	^distances
]

{ #category : #'as yet unclassified' }
PNGTelemeterService >> decodeGetResponseFrom: decoder [
	| telemeterProperties   |
	telemeterProperties := OrderedCollection new.
	[decoder hasData ] whileTrue: [
		|aTelemeter|
		aTelemeter := PNGTelemeterProperties new.
		self decodeTelemeterPropertiesFrom: decoder into: aTelemeter.
		telemeterProperties add: aTelemeter.
	].
	^telemeterProperties.
]

{ #category : #'as yet unclassified' }
PNGTelemeterService >> decodeTelemeterPropertiesFrom: decoder into: aTelemeter. [
	^aTelemeter 
		x: decoder nextEncodedFloat32;
		y: decoder nextEncodedFloat32;
		orientation: decoder nextEncodedFloat32;
		fieldOfView: decoder nextEncodedFloat32;
		minimumDistance: decoder nextEncodedFloat32;
		maximumDistance: decoder nextEncodedFloat32;
		yourself 
]

{ #category : #'as yet unclassified' }
PNGTelemeterService >> getCommandString [
	"Byte       1             2         3-4
Content  Identifier  Action  Target"
	self flag: 'we need a builder of this string'.
	^'01000', id asString, '00'
]

{ #category : #'as yet unclassified' }
PNGTelemeterService >> properties [
	^self get
]
