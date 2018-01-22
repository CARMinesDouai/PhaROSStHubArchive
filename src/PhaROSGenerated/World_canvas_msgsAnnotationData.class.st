Class {
	#name : #'World_canvas_msgsAnnotationData',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
