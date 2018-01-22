Class {
	#name : #'Sensor_msgsIlluminance',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
