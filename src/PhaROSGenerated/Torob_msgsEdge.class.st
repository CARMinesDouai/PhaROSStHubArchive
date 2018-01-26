Class {
	#name : #'Torob_msgsEdge',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Torob_msgsEdge class >> rosMd5Sum [ 
^'fe369c94b9e74909b38155fca58e73d2'
]

{ #category : #'as yet unclassified' }
Torob_msgsEdge class >> rosTypeDefinition [ 
^' int64 src
 int64 trg
 int64 type
 float64 weight
'
]

{ #category : #'as yet unclassified' }
Torob_msgsEdge class >> rosTypeName [ 
^'torob_msgs/Edge'
]

{ #category : #'as yet unclassified' }
Torob_msgsEdge class >> typeCreationOrder [ 
^377
]

{ #category : #'as yet unclassified' }
Torob_msgsEdge >> initialize [
	super initialize.
	 self src: 0. 
	 self trg: 0. 
	 self type: 0. 
	 self weight: 0.0. 

]

{ #category : #'as yet unclassified' }
Torob_msgsEdge >> src [
	^ self getAt: #src. 

]

{ #category : #'as yet unclassified' }
Torob_msgsEdge >> src: aValue [
	^ self at: #src put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsEdge >> trg [
	^ self getAt: #trg. 

]

{ #category : #'as yet unclassified' }
Torob_msgsEdge >> trg: aValue [
	^ self at: #trg put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsEdge >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Torob_msgsEdge >> type: aValue [
	^ self at: #type put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsEdge >> weight [
	^ self getAt: #weight. 

]

{ #category : #'as yet unclassified' }
Torob_msgsEdge >> weight: aValue [
	^ self at: #weight put: aValue. 

]
