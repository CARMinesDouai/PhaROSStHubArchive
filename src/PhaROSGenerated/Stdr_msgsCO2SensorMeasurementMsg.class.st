Class {
	#name : #'Stdr_msgsCO2SensorMeasurementMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMeasurementMsg class >> rosMd5Sum [ 
^'ea3141a4e89d798f2735cb324ffcd870'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMeasurementMsg class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float32 co2_ppm
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMeasurementMsg class >> rosTypeName [ 
^'stdr_msgs/CO2SensorMeasurementMsg'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMeasurementMsg >> co2_ppm [
	^ self getAt: #co2_ppm. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMeasurementMsg >> co2_ppm: aValue [
	^ self at: #co2_ppm put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMeasurementMsg >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMeasurementMsg >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SensorMeasurementMsg >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self co2_ppm: 0.0. 

]
