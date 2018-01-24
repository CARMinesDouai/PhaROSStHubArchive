Class {
	#name : #'Sensor_msgsRelativeHumidity',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsRelativeHumidity class >> rosMd5Sum [ 
^'8730015b05955b7e992ce29a2678d90f'
]

{ #category : #'as yet unclassified' }
Sensor_msgsRelativeHumidity class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float64 relative_humidity
 float64 variance
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsRelativeHumidity class >> rosTypeName [ 
^'sensor_msgs/RelativeHumidity'
]

{ #category : #'as yet unclassified' }
Sensor_msgsRelativeHumidity >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRelativeHumidity >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRelativeHumidity >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self relative_humidity: 0.0. 
	 self variance: 0.0. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRelativeHumidity >> relative_humidity [
	^ self getAt: #relative_humidity. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRelativeHumidity >> relative_humidity: aValue [
	^ self at: #relative_humidity put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRelativeHumidity >> variance [
	^ self getAt: #variance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRelativeHumidity >> variance: aValue [
	^ self at: #variance put: aValue. 

]
