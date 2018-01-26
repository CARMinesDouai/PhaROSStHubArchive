Class {
	#name : #'World_canvas_msgsAnnotationData',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData class >> rosMd5Sum [ 
^'e21002b6b9f6af72d6986a93e819ba1b'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData class >> rosTypeDefinition [ 
^' uuid_msgs/UniqueID id
 string type
 int8[] data
'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData class >> rosTypeName [ 
^'world_canvas_msgs/AnnotationData'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData class >> typeCreationOrder [ 
^420
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData >> initialize [
	super initialize.
	 self id: Uuid_msgsUniqueID new. 
	 self type: ''. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotationData >> type: aValue [
	^ self at: #type put: aValue. 

]
