Class {
	#name : #'Pcl_msgsPointIndices',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices class >> rosMd5Sum [ 
^'458c7998b7eaf99908256472e273b3d4'
]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices class >> rosTypeDefinition [ 
^' std_msgs/Header header
 int32[] indices
'
]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices class >> rosTypeName [ 
^'pcl_msgs/PointIndices'
]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices class >> typeCreationOrder [ 
^209
]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices >> indices [
	^ self getAt: #indices. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices >> indices: aValue [
	^ self at: #indices put: aValue. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsPointIndices >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self indices: OrderedCollection new . 

]
