Class {
	#name : #'Sensor_msgsIlluminance',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance class >> rosMd5Sum [ 
^'8cf5febb0952fca9d650c3d11a81a188'
]

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float64 illuminance
 float64 variance
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance class >> rosTypeName [ 
^'sensor_msgs/Illuminance'
]

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance class >> typeCreationOrder [ 
^263
]

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance >> illuminance [
	^ self getAt: #illuminance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance >> illuminance: aValue [
	^ self at: #illuminance put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self illuminance: 0.0. 
	 self variance: 0.0. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance >> variance [
	^ self getAt: #variance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsIlluminance >> variance: aValue [
	^ self at: #variance put: aValue. 

]
