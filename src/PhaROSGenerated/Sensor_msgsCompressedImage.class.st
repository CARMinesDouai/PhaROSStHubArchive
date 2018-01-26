Class {
	#name : #'Sensor_msgsCompressedImage',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage class >> rosMd5Sum [ 
^'8f7a12909da2c9d3332d540a0977563f'
]

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string format
 int8[] data
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage class >> rosTypeName [ 
^'sensor_msgs/CompressedImage'
]

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage class >> typeCreationOrder [ 
^261
]

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage >> format [
	^ self getAt: #format. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage >> format: aValue [
	^ self at: #format put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCompressedImage >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self format: ''. 
	 self data: OrderedCollection new . 

]
