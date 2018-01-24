Class {
	#name : #'Visualization_msgsInteractiveMarkerControl',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> button [
	^2

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> fixed [
	^1

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> inherit [
	^0

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> menu [
	^1

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> move_3d [
	^7

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> move_axis [
	^3

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> move_plane [
	^4

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> move_rotate [
	^6

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> move_rotate_3d [
	^9

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> none [
	^0

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> rosMd5Sum [ 
^'b3c81e785788195d1840b86c28da1aac'
]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> rosTypeDefinition [ 
^' int8 INHERIT=0
 int8 FIXED=1
 int8 VIEW_FACING=2
 int8 NONE=0
 int8 MENU=1
 int8 BUTTON=2
 int8 MOVE_AXIS=3
 int8 MOVE_PLANE=4
 int8 ROTATE_AXIS=5
 int8 MOVE_ROTATE=6
 int8 MOVE_3D=7
 int8 ROTATE_3D=8
 int8 MOVE_ROTATE_3D=9
 string name
 geometry_msgs/Quaternion orientation
 int8 orientation_mode
 int8 interaction_mode
 bool always_visible
 visualization_msgs/Marker[] markers
 bool independent_marker_orientation
 string description
'
]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> rosTypeName [ 
^'visualization_msgs/InteractiveMarkerControl'
]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> rotate_3d [
	^8

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> rotate_axis [
	^5

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl class >> view_facing [
	^2

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> always_visible [
	^ self getAt: #always_visible. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> always_visible: aValue [
	^ self at: #always_visible put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> independent_marker_orientation [
	^ self getAt: #independent_marker_orientation. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> independent_marker_orientation: aValue [
	^ self at: #independent_marker_orientation put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> initialize [
	super initialize.
	 self name: ''. 
	 self orientation: Geometry_msgsQuaternion new. 
	 self orientation_mode: 0. 
	 self interaction_mode: 0. 
	 self always_visible: false. 
	 self markers: OrderedCollection new . 
	 self independent_marker_orientation: false. 
	 self description: ''. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> interaction_mode [
	^ self getAt: #interaction_mode. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> interaction_mode: aValue [
	^ self at: #interaction_mode put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> markers [
	^ self getAt: #markers. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> markers: aValue [
	^ self at: #markers put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> orientation [
	^ self getAt: #orientation. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> orientation: aValue [
	^ self at: #orientation put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> orientation_mode [
	^ self getAt: #orientation_mode. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerControl >> orientation_mode: aValue [
	^ self at: #orientation_mode put: aValue. 

]
