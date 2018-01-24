Class {
	#name : #'Uuid_msgsUniqueID',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Uuid_msgsUniqueID class >> rosMd5Sum [ 
^'fec2a93b6f5367ee8112c9c0b41ff310'
]

{ #category : #'as yet unclassified' }
Uuid_msgsUniqueID class >> rosTypeDefinition [ 
^' int8[16]  uuid
'
]

{ #category : #'as yet unclassified' }
Uuid_msgsUniqueID class >> rosTypeName [ 
^'uuid_msgs/UniqueID'
]

{ #category : #'as yet unclassified' }
Uuid_msgsUniqueID >> initialize [
	super initialize.
	 self uuid:  (OrderedCollection new: 16). 

]

{ #category : #'as yet unclassified' }
Uuid_msgsUniqueID >> uuid [
	^ self getAt: #uuid. 

]

{ #category : #'as yet unclassified' }
Uuid_msgsUniqueID >> uuid: aValue [
	^ self at: #uuid put: aValue. 

]
