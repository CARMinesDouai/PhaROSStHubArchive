Class {
	#name : #'Sensor_msgsJoy',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsJoy >> axes [
	^ self getAt: #axes. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoy >> axes: aValue [
	^ self at: #axes put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoy >> buttons [
	^ self getAt: #buttons. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoy >> buttons: aValue [
	^ self at: #buttons put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoy >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoy >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJoy >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self axes: OrderedCollection new . 
	 self buttons: OrderedCollection new . 

]
