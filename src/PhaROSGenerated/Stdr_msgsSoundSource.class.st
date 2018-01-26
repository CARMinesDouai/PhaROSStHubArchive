Class {
	#name : #'Stdr_msgsSoundSource',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource class >> rosMd5Sum [ 
^'c45183ddcf94455b2f7bb47f2f3e9f87'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource class >> rosTypeDefinition [ 
^' string id
 float32 dbs
 geometry_msgs/Pose2D pose
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource class >> rosTypeName [ 
^'stdr_msgs/SoundSource'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource class >> typeCreationOrder [ 
^353
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource >> dbs [
	^ self getAt: #dbs. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource >> dbs: aValue [
	^ self at: #dbs put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource >> initialize [
	super initialize.
	 self id: ''. 
	 self dbs: 0.0. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSource >> pose: aValue [
	^ self at: #pose put: aValue. 

]
