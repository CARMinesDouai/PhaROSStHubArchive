Class {
	#name : #'Pcl_msgsPolygonMesh',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Pcl_msgsPolygonMesh class >> rosTypeDefinition [ 
^' std_msgs/Header header
 sensor_msgs/PointCloud2 cloud
 pcl_msgs/Vertices[] polygons
'
]

{ #category : #'as yet unclassified' }
Pcl_msgsPolygonMesh class >> rosTypeName [ 
^'pcl_msgs/PolygonMesh'
]

{ #category : #'as yet unclassified' }
Pcl_msgsPolygonMesh >> cloud [
	^ self getAt: #cloud. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPolygonMesh >> cloud: aValue [
	^ self at: #cloud put: aValue. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPolygonMesh >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPolygonMesh >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPolygonMesh >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self cloud: Sensor_msgsPointCloud2 new. 
	 self polygons: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPolygonMesh >> polygons [
	^ self getAt: #polygons. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPolygonMesh >> polygons: aValue [
	^ self at: #polygons put: aValue. 

]
