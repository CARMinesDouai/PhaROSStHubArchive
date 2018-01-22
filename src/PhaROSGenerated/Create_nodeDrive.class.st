Class {
	#name : #'Create_nodeDrive',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Create_nodeDrive class >> rosTypeDefinition [ 
^' float32 velocity
 float32 radius
'
]

{ #category : #'as yet unclassified' }
Create_nodeDrive class >> rosTypeName [ 
^'create_node/Drive'
]

{ #category : #'as yet unclassified' }
Create_nodeDrive >> initialize [
	super initialize.
	 self velocity: 0.0. 
	 self radius: 0.0. 

]

{ #category : #'as yet unclassified' }
Create_nodeDrive >> radius [
	^ self getAt: #radius. 

]

{ #category : #'as yet unclassified' }
Create_nodeDrive >> radius: aValue [
	^ self at: #radius put: aValue. 

]

{ #category : #'as yet unclassified' }
Create_nodeDrive >> velocity [
	^ self getAt: #velocity. 

]

{ #category : #'as yet unclassified' }
Create_nodeDrive >> velocity: aValue [
	^ self at: #velocity put: aValue. 

]
