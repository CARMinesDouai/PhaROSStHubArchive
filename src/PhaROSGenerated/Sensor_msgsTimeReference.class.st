Class {
	#name : #'Sensor_msgsTimeReference',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsTimeReference >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTimeReference >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTimeReference >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self time_ref:  PhaROSTimestamp now. 
	 self source: ''. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTimeReference >> source [
	^ self getAt: #source. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTimeReference >> source: aValue [
	^ self at: #source put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTimeReference >> time_ref [
	^ self getAt: #time_ref. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsTimeReference >> time_ref: aValue [
	^ self at: #time_ref put: aValue. 

]
