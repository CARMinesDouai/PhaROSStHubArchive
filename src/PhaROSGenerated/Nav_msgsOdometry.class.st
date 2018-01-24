Class {
	#name : #'Nav_msgsOdometry',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsOdometry class >> rosMd5Sum [ 
^'cd5e73d190d741a2f92e81eda573aca7'
]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string child_frame_id
 geometry_msgs/PoseWithCovariance pose
 geometry_msgs/TwistWithCovariance twist
'
]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry class >> rosTypeName [ 
^'nav_msgs/Odometry'
]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry >> child_frame_id [
	^ self getAt: #child_frame_id. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry >> child_frame_id: aValue [
	^ self at: #child_frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self child_frame_id: ''. 
	 self pose: Geometry_msgsPoseWithCovariance new. 
	 self twist: Geometry_msgsTwistWithCovariance new. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Nav_msgsOdometry >> twist: aValue [
	^ self at: #twist put: aValue. 

]
