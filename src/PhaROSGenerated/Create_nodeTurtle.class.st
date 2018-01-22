Class {
	#name : #'Create_nodeTurtle',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Create_nodeTurtle class >> rosTypeDefinition [ 
^' float32 linear
 float32 angular
'
]

{ #category : #'as yet unclassified' }
Create_nodeTurtle class >> rosTypeName [ 
^'create_node/Turtle'
]

{ #category : #'as yet unclassified' }
Create_nodeTurtle >> angular [
	^ self getAt: #angular. 

]

{ #category : #'as yet unclassified' }
Create_nodeTurtle >> angular: aValue [
	^ self at: #angular put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeTurtle >> initialize [
	super initialize.
	 self linear: 0.0. 
	 self angular: 0.0. 

]

{ #category : #'as yet unclassified' }
Create_nodeTurtle >> linear [
	^ self getAt: #linear. 

]

{ #category : #'as yet unclassified' }
Create_nodeTurtle >> linear: aValue [
	^ self at: #linear put: aValue. 

]
