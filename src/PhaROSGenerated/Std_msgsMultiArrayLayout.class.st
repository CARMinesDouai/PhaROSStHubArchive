Class {
	#name : #'Std_msgsMultiArrayLayout',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout class >> rosMd5Sum [ 
^'0fed2a11c13e11c5571b4e2a995a91a3'
]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayDimension[] dim
 int32 data_offset
'
]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout class >> rosTypeName [ 
^'std_msgs/MultiArrayLayout'
]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout class >> typeCreationOrder [ 
^292
]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout >> data_offset [
	^ self getAt: #data_offset. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout >> data_offset: aValue [
	^ self at: #data_offset put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout >> dim [
	^ self getAt: #dim. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout >> dim: aValue [
	^ self at: #dim put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout >> initialize [
	super initialize.
	 self dim: OrderedCollection new . 
	 self data_offset: 0. 

]
