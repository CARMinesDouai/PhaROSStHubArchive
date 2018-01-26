Class {
	#name : #'Std_msgsInt64MultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsInt64MultiArray class >> rosMd5Sum [ 
^'54865aa6c65be0448113a2afc6a49270'
]

{ #category : #'as yet unclassified' }
Std_msgsInt64MultiArray class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayLayout layout
 int64[] data
'
]

{ #category : #'as yet unclassified' }
Std_msgsInt64MultiArray class >> rosTypeName [ 
^'std_msgs/Int64MultiArray'
]

{ #category : #'as yet unclassified' }
Std_msgsInt64MultiArray class >> typeCreationOrder [ 
^307
]

{ #category : #'as yet unclassified' }
Std_msgsInt64MultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt64MultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt64MultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsInt64MultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt64MultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
