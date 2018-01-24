Class {
	#name : #'Sensor_msgsJoyFeedbackArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsJoyFeedbackArray class >> rosMd5Sum [ 
^'cde5730a895b1fc4dee6f91b754b213d'
]

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
