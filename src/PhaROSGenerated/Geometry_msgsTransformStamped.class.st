Class {
	#name : #'Geometry_msgsTransformStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped class >> rosMd5Sum [ 
^'b5764a33bfeb3588febc2682852579b0'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string child_frame_id
 geometry_msgs/Transform transform
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped class >> rosTypeName [ 
^'geometry_msgs/TransformStamped'
]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> child_frame_id [
	^ self getAt: #child_frame_id. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> child_frame_id: aValue [
	^ self at: #child_frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self child_frame_id: ''. 
	 self transform: Geometry_msgsTransform new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> transform [
	^ self getAt: #transform. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransformStamped >> transform: aValue [
	^ self at: #transform put: aValue. 

]
