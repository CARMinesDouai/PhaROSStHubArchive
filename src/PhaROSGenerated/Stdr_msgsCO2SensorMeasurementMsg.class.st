Class {
	#name : #'Stdr_msgsCO2SensorMeasurementMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
