Class {
	#name : #'Sensor_msgsFluidPressure',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsFluidPressure class >> rosMd5Sum [ 
^'804dc5cea1c5306d6a2eb80b9833befe'
]

{ #category : #'as yet unclassified' }
Sensor_msgsFluidPressure class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float64 fluid_pressure
 float64 variance
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsFluidPressure class >> rosTypeName [ 
^'sensor_msgs/FluidPressure'
]

{ #category : #'as yet unclassified' }
Sensor_msgsFluidPressure >> fluid_pressure [
	^ self getAt: #fluid_pressure. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsFluidPressure >> fluid_pressure: aValue [
	^ self at: #fluid_pressure put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsFluidPressure >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsFluidPressure >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsFluidPressure >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self fluid_pressure: 0.0. 
	 self variance: 0.0. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsFluidPressure >> variance [
	^ self getAt: #variance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsFluidPressure >> variance: aValue [
	^ self at: #variance put: aValue. 

]
