Class {
	#name : #'World_canvas_msgsAnnotations',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotations class >> rosMd5Sum [ 
^'5b47cb1c51cbc7a899bf81b52bdb8c27'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotations class >> rosTypeDefinition [ 
^' string map_id
 world_canvas_msgs/Annotation[] annotations
'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotations class >> rosTypeName [ 
^'world_canvas_msgs/Annotations'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotations class >> typeCreationOrder [ 
^421
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotations >> annotations [
	^ self getAt: #annotations. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotations >> annotations: aValue [
	^ self at: #annotations put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotations >> initialize [
	super initialize.
	 self map_id: ''. 
	 self annotations: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotations >> map_id [
	^ self getAt: #map_id. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotations >> map_id: aValue [
	^ self at: #map_id put: aValue. 

]
