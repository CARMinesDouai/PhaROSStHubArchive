Class {
	#name : #'Torob_msgsNode',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Torob_msgsNode class >> rosMd5Sum [ 
^'be5d6724f5ae8d7705bfb37781c6a9ba'
]

{ #category : #'as yet unclassified' }
Torob_msgsNode class >> rosTypeDefinition [ 
^' float64 x
 float64 y
 int64 type
 float64 weight
'
]

{ #category : #'as yet unclassified' }
Torob_msgsNode class >> rosTypeName [ 
^'torob_msgs/Node'
]

{ #category : #'as yet unclassified' }
Torob_msgsNode >> initialize [
	super initialize.
	 self x: 0.0. 
	 self y: 0.0. 
	 self type: 0. 
	 self weight: 0.0. 

]

{ #category : #'as yet unclassified' }
Torob_msgsNode >> type [
	^ self getAt: #type. 

]

{ #category : #'as yet unclassified' }
Torob_msgsNode >> type: aValue [
	^ self at: #type put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsNode >> weight [
	^ self getAt: #weight. 

]

{ #category : #'as yet unclassified' }
Torob_msgsNode >> weight: aValue [
	^ self at: #weight put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsNode >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Torob_msgsNode >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsNode >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Torob_msgsNode >> y: aValue [
	^ self at: #y put: aValue. 

]
