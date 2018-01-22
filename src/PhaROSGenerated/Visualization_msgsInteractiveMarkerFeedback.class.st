Class {
	#name : #'Visualization_msgsInteractiveMarkerFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback class >> button_click [
	^3

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback class >> keep_alive [
	^0

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback class >> menu_select [
	^2

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback class >> mouse_down [
	^4

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback class >> mouse_up [
	^5

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback class >> pose_update [
	^1

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback class >> rosTypeDefinition [ 
^' int8 KEEP_ALIVE=0
 int8 POSE_UPDATE=1
 int8 MENU_SELECT=2
 int8 BUTTON_CLICK=3
 int8 MOUSE_DOWN=4
 int8 MOUSE_UP=5
 std_msgs/Header header
 string client_id
 string marker_name
 string control_name
 int8 event_type
 geometry_msgs/Pose pose
 int32 menu_entry_id
 geometry_msgs/Point mouse_point
 bool mouse_point_valid
'
]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback class >> rosTypeName [ 
^'visualization_msgs/InteractiveMarkerFeedback'
]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> client_id [
	^ self getAt: #client_id. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> client_id: aValue [
	^ self at: #client_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> control_name [
	^ self getAt: #control_name. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> control_name: aValue [
	^ self at: #control_name put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> event_type [
	^ self getAt: #event_type. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> event_type: aValue [
	^ self at: #event_type put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self client_id: ''. 
	 self marker_name: ''. 
	 self control_name: ''. 
	 self event_type: 0. 
	 self pose: Geometry_msgsPose new. 
	 self menu_entry_id: 0. 
	 self mouse_point: Geometry_msgsPoint new. 
	 self mouse_point_valid: false. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> marker_name [
	^ self getAt: #marker_name. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> marker_name: aValue [
	^ self at: #marker_name put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> menu_entry_id [
	^ self getAt: #menu_entry_id. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> menu_entry_id: aValue [
	^ self at: #menu_entry_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> mouse_point [
	^ self getAt: #mouse_point. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> mouse_point: aValue [
	^ self at: #mouse_point put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> mouse_point_valid [
	^ self getAt: #mouse_point_valid. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> mouse_point_valid: aValue [
	^ self at: #mouse_point_valid put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsInteractiveMarkerFeedback >> pose: aValue [
	^ self at: #pose put: aValue. 

]
