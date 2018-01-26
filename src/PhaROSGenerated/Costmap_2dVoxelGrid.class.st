Class {
	#name : #'Costmap_2dVoxelGrid',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid class >> rosMd5Sum [ 
^'48a040827e1322073d78ece5a497029c'
]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid class >> rosTypeDefinition [ 
^' std_msgs/Header header
 int32[] data
 geometry_msgs/Point32 origin
 geometry_msgs/Vector3 resolutions
 int32 size_x
 int32 size_y
 int32 size_z
'
]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid class >> rosTypeName [ 
^'costmap_2d/VoxelGrid'
]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid class >> typeCreationOrder [ 
^98
]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self data: OrderedCollection new . 
	 self origin: Geometry_msgsPoint32 new. 
	 self resolutions: Geometry_msgsVector3 new. 
	 self size_x: 0. 
	 self size_y: 0. 
	 self size_z: 0. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> origin [
	^ self getAt: #origin. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> origin: aValue [
	^ self at: #origin put: aValue. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> resolutions [
	^ self getAt: #resolutions. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> resolutions: aValue [
	^ self at: #resolutions put: aValue. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> size_x [
	^ self getAt: #size_x. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> size_x: aValue [
	^ self at: #size_x put: aValue. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> size_y [
	^ self getAt: #size_y. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> size_y: aValue [
	^ self at: #size_y put: aValue. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> size_z [
	^ self getAt: #size_z. 

]

{ #category : #'as yet unclassified' }
Costmap_2dVoxelGrid >> size_z: aValue [
	^ self at: #size_z put: aValue. 

]
