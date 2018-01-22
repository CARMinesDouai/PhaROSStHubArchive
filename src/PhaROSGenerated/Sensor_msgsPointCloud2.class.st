Class {
	#name : #'Sensor_msgsPointCloud2',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 class >> rosTypeDefinition [ 
^' std_msgs/Header header
 int32 height
 int32 width
 sensor_msgs/PointField[] fields
 bool is_bigendian
 int32 point_step
 int32 row_step
 int8[] data
 bool is_dense
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 class >> rosTypeName [ 
^'sensor_msgs/PointCloud2'
]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> fields [
	^ self getAt: #fields. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> fields: aValue [
	^ self at: #fields put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self height: 0. 
	 self width: 0. 
	 self fields: OrderedCollection new . 
	 self is_bigendian: false. 
	 self point_step: 0. 
	 self row_step: 0. 
	 self data: OrderedCollection new . 
	 self is_dense: false. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> is_bigendian [
	^ self getAt: #is_bigendian. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> is_bigendian: aValue [
	^ self at: #is_bigendian put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> is_dense [
	^ self getAt: #is_dense. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> is_dense: aValue [
	^ self at: #is_dense put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> point_step [
	^ self getAt: #point_step. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> point_step: aValue [
	^ self at: #point_step put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> row_step [
	^ self getAt: #row_step. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> row_step: aValue [
	^ self at: #row_step put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> width [
	^ self getAt: #width. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsPointCloud2 >> width: aValue [
	^ self at: #width put: aValue. 

]
