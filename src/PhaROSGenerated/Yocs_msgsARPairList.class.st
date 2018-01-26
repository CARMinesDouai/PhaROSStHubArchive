Class {
	#name : #'Yocs_msgsARPairList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsARPairList class >> rosMd5Sum [ 
^'0d0cfdee6418b6b3edd41c0abc93d76f'
]

{ #category : #'as yet unclassified' }
Yocs_msgsARPairList class >> rosTypeDefinition [ 
^' yocs_msgs/ARPair[] pairs
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsARPairList class >> rosTypeName [ 
^'yocs_msgs/ARPairList'
]

{ #category : #'as yet unclassified' }
Yocs_msgsARPairList class >> typeCreationOrder [ 
^425
]

{ #category : #'as yet unclassified' }
Yocs_msgsARPairList >> initialize [
	super initialize.
	 self pairs: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPairList >> pairs [
	^ self getAt: #pairs. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPairList >> pairs: aValue [
	^ self at: #pairs put: aValue. 

]
