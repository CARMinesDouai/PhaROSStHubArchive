Class {
	#name : #PhaROSSpaceEventManager,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'events',
		'sensor'
	],
	#category : #PhaROSNodeletsLocalizer
}

{ #category : #'as yet unclassified' }
PhaROSSpaceEventManager >> check: aLocalizerMeasure [ 
	
	self events do: [ : e | [ e apply: aLocalizerMeasure ] on: Error do: [ : er | self log: er messageText ] ].
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEventManager >> configure [
	
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEventManager >> events [ 
	^ events
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEventManager >> initialize [
	events := Set new.
	
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEventManager >> registerLocalizationSensor: aPseudoTopicSubscriber [
	sensor ifNotNil: [
		self error: 'There cannot be more than one sensor related to one event manager'.
	] .

	sensor := aPseudoTopicSubscriber .
	aPseudoTopicSubscriber  for: [ :lm  | self check: lm ].
	
	
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEventManager >> remove: anEvent [
	events remove: anEvent ifAbsent: [].
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEventManager >> rescheddule: anEvent [
	events add: anEvent.
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEventManager >> useTfSensorTo: aRobotFrameID [
	| tfSensor | 
	tfSensor := PhaROSLocalizerTFSensor new.
	tfSensor localizer: self nodelets localizer.
	tfSensor robotFrame: aRobotFrameID.
	
	tfSensor rate: 0.35 hz.
	
	self registerLocalizationSensor: tfSensor.
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEventManager >> whenLocalizerMeasure: aConditionBlock do: anActionBlock [
	^ self events add: (
		PhaROSSpaceEvent new manager: self; 
								  condition: aConditionBlock; 
								  action: anActionBlock; 
								  yourself
					).
]

{ #category : #'as yet unclassified' }
PhaROSSpaceEventManager >> whenLocalizerMeasure: aConditionBlock doOnce: anActionBlock [
	^ self events add: (
		PhaROSOneTimeSpaceEvent new manager: self; 
										    condition: aConditionBlock; 
										    action: anActionBlock; 
										    yourself
		).
]
