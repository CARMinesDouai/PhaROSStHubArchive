Class {
	#name : #'Stdr_msgsSoundSensorMeasurementMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMeasurementMsg class >> rosMd5Sum [ 
^'1f73a234937f6d19824ea2a78f157d78'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMeasurementMsg class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float32 sound_dbs
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMeasurementMsg class >> rosTypeName [ 
^'stdr_msgs/SoundSensorMeasurementMsg'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMeasurementMsg class >> typeCreationOrder [ 
^352
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMeasurementMsg >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMeasurementMsg >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMeasurementMsg >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self sound_dbs: 0.0. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMeasurementMsg >> sound_dbs [
	^ self getAt: #sound_dbs. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSensorMeasurementMsg >> sound_dbs: aValue [
	^ self at: #sound_dbs put: aValue. 

]
