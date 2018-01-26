Class {
	#name : #'World_canvas_msgsWorldCanvas',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas class >> rosMd5Sum [ 
^'6d7c521a48d85a2b09f0d0c03fe5f648'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas class >> rosTypeDefinition [ 
^' time timestamp
 string name
 string description
 string geometry
'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas class >> rosTypeName [ 
^'world_canvas_msgs/WorldCanvas'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas class >> typeCreationOrder [ 
^423
]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas >> description [
	^ self getAt: #description. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas >> description: aValue [
	^ self at: #description put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas >> geometry [
	^ self getAt: #geometry. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas >> geometry: aValue [
	^ self at: #geometry put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas >> initialize [
	super initialize.
	 self timestamp:  PhaROSTimestamp now. 
	 self name: ''. 
	 self description: ''. 
	 self geometry: ''. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas >> timestamp [
	^ self getAt: #timestamp. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsWorldCanvas >> timestamp: aValue [
	^ self at: #timestamp put: aValue. 

]
