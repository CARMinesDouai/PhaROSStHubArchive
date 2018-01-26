Class {
	#name : #'World_canvas_msgsMapListEntry',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry class >> rosMd5Sum [ 
^'092f024758d394d17196cd37d999fdb0'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry class >> rosTypeDefinition [ 
^' string name
 string session_id
 int64 date
 string map_id
'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry class >> rosTypeName [ 
^'world_canvas_msgs/MapListEntry'
]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry class >> typeCreationOrder [ 
^422
]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry >> date [
	^ self getAt: #date. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry >> date: aValue [
	^ self at: #date put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry >> initialize [
	super initialize.
	 self name: ''. 
	 self session_id: ''. 
	 self date: 0. 
	 self map_id: ''. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry >> map_id [
	^ self getAt: #map_id. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry >> map_id: aValue [
	^ self at: #map_id put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry >> session_id [
	^ self getAt: #session_id. 

]

{ #category : #'as yet unclassified' }
World_canvas_msgsMapListEntry >> session_id: aValue [
	^ self at: #session_id put: aValue. 

]
