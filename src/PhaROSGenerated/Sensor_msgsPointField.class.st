Class {
	#name : #'Sensor_msgsPointField',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> float32 [
	^7

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> float64 [
	^8

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> int16 [
	^3

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> int32 [
	^5

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> int8 [
	^1

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> rosMd5Sum [ 
^'268eacb2962780ceac86cbd17e328150'
]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> rosTypeDefinition [ 
^' int8 INT8=1
 int8 UINT8=2
 int8 INT16=3
 int8 UINT16=4
 int8 INT32=5
 int8 UINT32=6
 int8 FLOAT32=7
 int8 FLOAT64=8
 string name
 int32 offset
 int8 datatype
 int32 count
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> rosTypeName [ 
^'sensor_msgs/PointField'
]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> uint16 [
	^4

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> uint32 [
	^6

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField class >> uint8 [
	^2

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField >> count [
	^ self getAt: #count. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField >> count: aValue [
	^ self at: #count put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField >> datatype [
	^ self getAt: #datatype. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField >> datatype: aValue [
	^ self at: #datatype put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField >> initialize [
	super initialize.
	 self name: ''. 
	 self offset: 0. 
	 self datatype: 0. 
	 self count: 0. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField >> offset [
	^ self getAt: #offset. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointField >> offset: aValue [
	^ self at: #offset put: aValue. 

]
