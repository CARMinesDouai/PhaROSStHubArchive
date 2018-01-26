Class {
	#name : #'Visualization_msgsInteractiveMarkerPose',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose class >> rosMd5Sum [ 
^'a6e6833209a196a38d798dadb02c81f8'
]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Pose pose
 string name
'
]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose class >> rosTypeName [ 
^'visualization_msgs/InteractiveMarkerPose'
]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose class >> typeCreationOrder [ 
^416
]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self pose: Geometry_msgsPose new. 
	 self name: ''. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerPose >> pose: aValue [
	^ self at: #pose put: aValue. 

]
