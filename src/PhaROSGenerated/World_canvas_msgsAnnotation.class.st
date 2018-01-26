Class {
	#name : #'World_canvas_msgsAnnotation',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation class >> rosMd5Sum [ 
^'ad3b363d73f197c0fc0f70645a6b2598'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation class >> rosTypeDefinition [ 
^' time timestamp
 uuid_msgs/UniqueID id
 uuid_msgs/UniqueID data_id
 string world
 string name
 string type
 int32 shape
 std_msgs/ColorRGBA color
 geometry_msgs/Vector3 size
 geometry_msgs/PoseWithCovarianceStamped pose
 string[] keywords
 uuid_msgs/UniqueID[] relationships
'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation class >> rosTypeName [ 
^'world_canvas_msgs/Annotation'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation class >> typeCreationOrder [ 
^419
]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> color [
	^ self getAt: #color. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> color: aValue [
	^ self at: #color put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> data_id [
	^ self getAt: #data_id. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> data_id: aValue [
	^ self at: #data_id put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> initialize [
	super initialize.
	 self timestamp:  PhaROSTimestamp now. 
	 self id: Uuid_msgsUniqueID new. 
	 self data_id: Uuid_msgsUniqueID new. 
	 self world: ''. 
	 self name: ''. 
	 self type: ''. 
	 self shape: 0. 
	 self color: Std_msgsColorRGBA new. 
	 self size: Geometry_msgsVector3 new. 
	 self pose: Geometry_msgsPoseWithCovarianceStamped new. 
	 self keywords: OrderedCollection new . 
	 self relationships: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> keywords [
	^ self getAt: #keywords. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> keywords: aValue [
	^ self at: #keywords put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> relationships [
	^ self getAt: #relationships. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> relationships: aValue [
	^ self at: #relationships put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> shape [
	^ self getAt: #shape. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> shape: aValue [
	^ self at: #shape put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> size [
	^ self getAt: #size. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> size: aValue [
	^ self at: #size put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> timestamp [
	^ self getAt: #timestamp. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> timestamp: aValue [
	^ self at: #timestamp put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> type: aValue [
	^ self at: #type put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> world [
	^ self getAt: #world. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsAnnotation >> world: aValue [
	^ self at: #world put: aValue. 

]
