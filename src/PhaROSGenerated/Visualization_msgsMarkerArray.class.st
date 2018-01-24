Class {
	#name : #'Visualization_msgsMarkerArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Visualization_msgsMarkerArray class >> rosMd5Sum [ 
^'d155b9ce5188fbaf89745847fd5882d7'
]

{ #category : #'as yet unclassified' }
Visualization_msgsMarkerArray class >> rosTypeDefinition [ 
^' visualization_msgs/Marker[] markers
'
]

{ #category : #'as yet unclassified' }
Visualization_msgsMarkerArray class >> rosTypeName [ 
^'visualization_msgs/MarkerArray'
]

{ #category : #'as yet unclassified' }
Visualization_msgsMarkerArray >> initialize [
	super initialize.
	 self markers: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarkerArray >> markers [
	^ self getAt: #markers. 

]

{ #category : #'as yet unclassified' }
Visualization_msgsMarkerArray >> markers: aValue [
	^ self at: #markers put: aValue. 

]
