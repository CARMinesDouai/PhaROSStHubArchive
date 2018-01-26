Class {
	#name : #'Sensor_msgsJoyFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback class >> rosMd5Sum [ 
^'f4dcd73460360d98f36e55ee7f2e46f1'
]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback class >> rosTypeDefinition [ 
^' int8 TYPE_LED=0
 int8 TYPE_RUMBLE=1
 int8 TYPE_BUZZER=2
 int8 type
 int8 id
 float32 intensity
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback class >> rosTypeName [ 
^'sensor_msgs/JoyFeedback'
]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback class >> typeCreationOrder [ 
^268
]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback class >> type_buzzer [
	^2

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback class >> type_led [
	^0

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback class >> type_rumble [
	^1

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback >> initialize [
	super initialize.
	 self type: 0. 
	 self id: 0. 
	 self intensity: 0.0. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback >> intensity [
	^ self getAt: #intensity. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback >> intensity: aValue [
	^ self at: #intensity put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedback >> type: aValue [
	^ self at: #type put: aValue. 

]
