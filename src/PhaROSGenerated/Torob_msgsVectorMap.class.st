Class {
	#name : #'Torob_msgsVectorMap',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap class >> rosMd5Sum [ 
^'7444b0631e4560c504ce75efdb79b59a'
]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float64 resolution
 torob_msgs/Node[] nodes
 torob_msgs/Edge[] edges
'
]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap class >> rosTypeName [ 
^'torob_msgs/VectorMap'
]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap class >> typeCreationOrder [ 
^379
]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> edges [
	^ self getAt: #edges. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> edges: aValue [
	^ self at: #edges put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self resolution: 0.0. 
	 self nodes: OrderedCollection new . 
	 self edges: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> nodes [
	^ self getAt: #nodes. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> nodes: aValue [
	^ self at: #nodes put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> resolution [
	^ self getAt: #resolution. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> resolution: aValue [
	^ self at: #resolution put: aValue. 

]
