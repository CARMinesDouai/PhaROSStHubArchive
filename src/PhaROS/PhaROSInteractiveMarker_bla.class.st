Class {
	#name : #'PhaROSInteractiveMarker_bla',
	#superclass : #Object,
	#instVars : [
		'name',
		'description',
		'pose',
		'controls',
		'menu'
	],
	#category : #'PhaROS-Packages-InteractiveMarker'
}

{ #category : #'space-accessing' }
PhaROSInteractiveMarker_bla >> description: aDescription [
	description := aDescription.
]

{ #category : #'space-accessing' }
PhaROSInteractiveMarker_bla >> initialize [ 
	controls := Set new. 
]

{ #category : #'menu-accessing' }
PhaROSInteractiveMarker_bla >> menu [
	^ menu ifNil: [ menu := PhaROSInteractiveMenu new ].
]

{ #category : #'space-accessing' }
PhaROSInteractiveMarker_bla >> name: aName [ 
	name := aName.
]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newArrow [
"

uint8 ARROW=0
uint8 CUBE=1
uint8 SPHERE=2
uint8 CYLINDER=3
uint8 LINE_STRIP=4
uint8 LINE_LIST=5
uint8 CUBE_LIST=6
uint8 SPHERE_LIST=7
uint8 POINTS=8
uint8 TEXT_VIEW_FACING=9
uint8 MESH_RESOURCE=10
s
"
]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newCube [

]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newCubeList [

]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newCylinder [

]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newLineList [

]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newLineStrip [

]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newMeshResource [

]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newPoints [

]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newSphere [

]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newSphereList [

]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newTextViewFacing [

]

{ #category : #'control-accessing' }
PhaROSInteractiveMarker_bla >> newTriangleList [

]

{ #category : #'space-accessing' }
PhaROSInteractiveMarker_bla >> pose: aPose [
	pose := aPose
]
