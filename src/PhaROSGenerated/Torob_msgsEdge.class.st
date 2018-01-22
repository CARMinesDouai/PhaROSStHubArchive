Class {
	#name : #'Torob_msgsEdge',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
