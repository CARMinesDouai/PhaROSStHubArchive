Class {
	#name : #'Sensor_msgsJoyFeedbackArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedbackArray class >> rosTypeDefinition [ 
^' sensor_msgs/JoyFeedback[] array
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedbackArray class >> rosTypeName [ 
^'sensor_msgs/JoyFeedbackArray'
]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedbackArray >> array [
	^ self getAt: #array. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedbackArray >> array: aValue [
	^ self at: #array put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedbackArray >> initialize [
	super initialize.
	 self array: OrderedCollection new . 

]
