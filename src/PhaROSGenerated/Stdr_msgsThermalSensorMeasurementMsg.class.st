Class {
	#name : #'Stdr_msgsThermalSensorMeasurementMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMeasurementMsg >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMeasurementMsg >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMeasurementMsg >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self thermal_source_degrees: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMeasurementMsg >> thermal_source_degrees [
	^ self getAt: #thermal_source_degrees. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSensorMeasurementMsg >> thermal_source_degrees: aValue [
	^ self at: #thermal_source_degrees put: aValue. 

]
