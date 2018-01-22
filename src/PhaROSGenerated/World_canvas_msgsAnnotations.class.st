Class {
	#name : #'World_canvas_msgsAnnotations',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
