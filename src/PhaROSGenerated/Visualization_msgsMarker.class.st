Class {
	#name : #'Visualization_msgsMarker',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> add [
	^0

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> arrow [
	^0

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> cube [
	^1

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> cube_list [
	^6

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> cylinder [
	^3

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> delete [
	^2

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> deleteall [
	^3

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> line_list [
	^5

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> line_strip [
	^4

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> mesh_resource [
	^10

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> modify [
	^0

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> points [
	^8

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> rosTypeDefinition [ 
^' int8 ARROW=0
 int8 CUBE=1
 int8 SPHERE=2
 int8 CYLINDER=3
 int8 LINE_STRIP=4
 int8 LINE_LIST=5
 int8 CUBE_LIST=6
 int8 SPHERE_LIST=7
 int8 POINTS=8
 int8 TEXT_VIEW_FACING=9
 int8 MESH_RESOURCE=10
 int8 TRIANGLE_LIST=11
 int8 ADD=0
 int8 MODIFY=0
 int8 DELETE=2
 int8 DELETEALL=3
 std_msgs/Header header
 string ns
 int32 id
 int32 type
 int32 action
 geometry_msgs/Pose pose
 geometry_msgs/Vector3 scale
 std_msgs/ColorRGBA color
 duration lifetime
 bool frame_locked
 geometry_msgs/Point[] points
 std_msgs/ColorRGBA[] colors
 string text
 string mesh_resource
 bool mesh_use_embedded_materials
'
]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> rosTypeName [ 
^'visualization_msgs/Marker'
]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> sphere [
	^2

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> sphere_list [
	^7

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> text_view_facing [
	^9

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker class >> triangle_list [
	^11

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> action [
	^ self getAt: #action. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> action: aValue [
	^ self at: #action put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> color [
	^ self getAt: #color. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> color: aValue [
	^ self at: #color put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> colors [
	^ self getAt: #colors. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> colors: aValue [
	^ self at: #colors put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> frame_locked [
	^ self getAt: #frame_locked. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> frame_locked: aValue [
	^ self at: #frame_locked put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self ns: ''. 
	 self id: 0. 
	 self type: 0. 
	 self action: 0. 
	 self pose: Geometry_msgsPose new. 
	 self scale: Geometry_msgsVector3 new. 
	 self color: Std_msgsColorRGBA new. 
	 self lifetime:  Duration seconds: 0. 
	 self frame_locked: false. 
	 self points: OrderedCollection new . 
	 self colors: OrderedCollection new . 
	 self text: ''. 
	 self mesh_resource: ''. 
	 self mesh_use_embedded_materials: false. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> lifetime [
	^ self getAt: #lifetime. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> lifetime: aValue [
	^ self at: #lifetime put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> mesh_resource [
	^ self getAt: #mesh_resource. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> mesh_resource: aValue [
	^ self at: #mesh_resource put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> mesh_use_embedded_materials [
	^ self getAt: #mesh_use_embedded_materials. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> mesh_use_embedded_materials: aValue [
	^ self at: #mesh_use_embedded_materials put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> ns [
	^ self getAt: #ns. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> ns: aValue [
	^ self at: #ns put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> points: aValue [
	^ self at: #points put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> scale [
	^ self getAt: #scale. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> scale: aValue [
	^ self at: #scale put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> text [
	^ self getAt: #text. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> text: aValue [
	^ self at: #text put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarker >> type: aValue [
	^ self at: #type put: aValue. 

]
