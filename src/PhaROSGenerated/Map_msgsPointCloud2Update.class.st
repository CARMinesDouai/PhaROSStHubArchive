Class {
	#name : #'Map_msgsPointCloud2Update',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update class >> add [
	^0

]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update class >> delete [
	^1

]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update class >> rosMd5Sum [ 
^'6c58e4f249ae9cd2b24fb1ee0f99195e'
]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update class >> rosTypeDefinition [ 
^' int32 ADD=0
 int32 DELETE=1
 std_msgs/Header header
 int32 type
 sensor_msgs/PointCloud2 points
'
]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update class >> rosTypeName [ 
^'map_msgs/PointCloud2Update'
]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self type: 0. 
	 self points: Sensor_msgsPointCloud2 new. 

]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update >> points: aValue [
	^ self at: #points put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Map_msgsPointCloud2Update >> type: aValue [
	^ self at: #type put: aValue. 

]
