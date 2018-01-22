Class {
	#name : #'Map_msgsProjectedMapInfo',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo class >> rosTypeDefinition [ 
^' string frame_id
 float64 x
 float64 y
 float64 width
 float64 height
 float64 min_z
 float64 max_z
'
]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo class >> rosTypeName [ 
^'map_msgs/ProjectedMapInfo'
]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> frame_id [
	^ self getAt: #frame_id. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> frame_id: aValue [
	^ self at: #frame_id put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> initialize [
	super initialize.
	 self frame_id: ''. 
	 self x: 0.0. 
	 self y: 0.0. 
	 self width: 0.0. 
	 self height: 0.0. 
	 self min_z: 0.0. 
	 self max_z: 0.0. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> max_z [
	^ self getAt: #max_z. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> max_z: aValue [
	^ self at: #max_z put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> min_z [
	^ self getAt: #min_z. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> min_z: aValue [
	^ self at: #min_z put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> width [
	^ self getAt: #width. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> width: aValue [
	^ self at: #width put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Map_msgsProjectedMapInfo >> y: aValue [
	^ self at: #y put: aValue. 

]
