Class {
	#name : #IMArduinoNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'led'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #'as yet unclassified' }
IMArduinoNodelet class >> toggleLedTopic [
	^ '/toggle_led'
]

{ #category : #'as yet unclassified' }
IMArduinoNodelet class >> toggleLedTopicType [
	^ 'std_msgs/Bool'
]

{ #category : #'as yet unclassified' }
IMArduinoNodelet >> led [
	^ led ifNil: [ led := IMArduinoLed for: (
		self controller node topicPublisher: IMArduinoNodelet toggleLedTopic  
							  typedAs: IMArduinoNodelet toggleLedTopicType )
	].
]
