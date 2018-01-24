Class {
	#name : #'Sensor_msgsTemperature',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsTemperature class >> rosMd5Sum [ 
^'ff71b307acdbe7c871a5a6d7ed359100'
]

{ #category : #'as yet unclassified' }
Sensor_msgsTemperature class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float64 temperature
 float64 variance
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsTemperature class >> rosTypeName [ 
^'sensor_msgs/Temperature'
]

{ #category : #'as yet unclassified' }
Sensor_msgsTemperature >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTemperature >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTemperature >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self temperature: 0.0. 
	 self variance: 0.0. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTemperature >> temperature [
	^ self getAt: #temperature. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTemperature >> temperature: aValue [
	^ self at: #temperature put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTemperature >> variance [
	^ self getAt: #variance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTemperature >> variance: aValue [
	^ self at: #variance put: aValue. 

]
