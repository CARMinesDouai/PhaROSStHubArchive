Class {
	#name : #'Kobuki_msgsAutoDockingResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingResult class >> rosMd5Sum [ 
^'74697ed3d931f6eede8bf3a8dfeca160'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingResult class >> rosTypeDefinition [ 
^' string text
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingResult class >> rosTypeName [ 
^'kobuki_msgs/AutoDockingResult'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingResult >> initialize [
	super initialize.
	 self text: ''. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingResult >> text [
	^ self getAt: #text. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingResult >> text: aValue [
	^ self at: #text put: aValue. 

]
