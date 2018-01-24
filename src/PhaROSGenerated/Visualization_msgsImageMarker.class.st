Class {
	#name : #'Visualization_msgsImageMarker',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker class >> add [
	^0

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker class >> circle [
	^0

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker class >> line_list [
	^2

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker class >> line_strip [
	^1

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker class >> points [
	^4

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker class >> polygon [
	^3

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker class >> remove [
	^1

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker class >> rosMd5Sum [ 
^'1de93c67ec8858b831025a08fbf1b35c'
]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker class >> rosTypeDefinition [ 
^' int8 CIRCLE=0
 int8 LINE_STRIP=1
 int8 LINE_LIST=2
 int8 POLYGON=3
 int8 POINTS=4
 int8 ADD=0
 int8 REMOVE=1
 std_msgs/Header header
 string ns
 int32 id
 int32 type
 int32 action
 geometry_msgs/Point position
 float32 scale
 std_msgs/ColorRGBA outline_color
 int8 filled
 std_msgs/ColorRGBA fill_color
 duration lifetime
 geometry_msgs/Point[] points
 std_msgs/ColorRGBA[] outline_colors
'
]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker class >> rosTypeName [ 
^'visualization_msgs/ImageMarker'
]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> action [
	^ self getAt: #action. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> action: aValue [
	^ self at: #action put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> fill_color [
	^ self getAt: #fill_color. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> fill_color: aValue [
	^ self at: #fill_color put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> filled [
	^ self getAt: #filled. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> filled: aValue [
	^ self at: #filled put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self ns: ''. 
	 self id: 0. 
	 self type: 0. 
	 self action: 0. 
	 self position: Geometry_msgsPoint new. 
	 self scale: 0.0. 
	 self outline_color: Std_msgsColorRGBA new. 
	 self filled: 0. 
	 self fill_color: Std_msgsColorRGBA new. 
	 self lifetime:  Duration seconds: 0. 
	 self points: OrderedCollection new . 
	 self outline_colors: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> lifetime [
	^ self getAt: #lifetime. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> lifetime: aValue [
	^ self at: #lifetime put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> ns [
	^ self getAt: #ns. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> ns: aValue [
	^ self at: #ns put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> outline_color [
	^ self getAt: #outline_color. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> outline_color: aValue [
	^ self at: #outline_color put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> outline_colors [
	^ self getAt: #outline_colors. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> outline_colors: aValue [
	^ self at: #outline_colors put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> points: aValue [
	^ self at: #points put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> position [
	^ self getAt: #position. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> position: aValue [
	^ self at: #position put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> scale [
	^ self getAt: #scale. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> scale: aValue [
	^ self at: #scale put: aValue. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsImageMarker >> type: aValue [
	^ self at: #type put: aValue. 

]
