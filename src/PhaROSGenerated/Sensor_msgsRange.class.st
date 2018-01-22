Class {
	#name : #'Sensor_msgsRange',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsRange class >> infrared [
	^1

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange class >> rosTypeDefinition [ 
^' int8 ULTRASOUND=0
 int8 INFRARED=1
 std_msgs/Header header
 int8 radiation_type
 float32 field_of_view
 float32 min_range
 float32 max_range
 float32 range
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsRange class >> rosTypeName [ 
^'sensor_msgs/Range'
]

{ #category : #'as yet unclassified' }
Sensor_msgsRange class >> ultrasound [
	^0

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> field_of_view [
	^ self getAt: #field_of_view. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> field_of_view: aValue [
	^ self at: #field_of_view put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self radiation_type: 0. 
	 self field_of_view: 0.0. 
	 self min_range: 0.0. 
	 self max_range: 0.0. 
	 self range: 0.0. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> max_range [
	^ self getAt: #max_range. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> max_range: aValue [
	^ self at: #max_range put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> min_range [
	^ self getAt: #min_range. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> min_range: aValue [
	^ self at: #min_range put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> radiation_type [
	^ self getAt: #radiation_type. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> radiation_type: aValue [
	^ self at: #radiation_type put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> range [
	^ self getAt: #range. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRange >> range: aValue [
	^ self at: #range put: aValue. 

]
