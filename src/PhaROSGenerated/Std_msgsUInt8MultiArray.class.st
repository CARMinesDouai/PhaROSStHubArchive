Class {
	#name : #'Std_msgsUInt8MultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsUInt8MultiArray class >> rosMd5Sum [ 
^'82373f1612381bb6ee473b5cd6f5d89c'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt8MultiArray class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayLayout layout
 int8[] data
'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt8MultiArray class >> rosTypeName [ 
^'std_msgs/UInt8MultiArray'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt8MultiArray class >> typeCreationOrder [ 
^319
]

{ #category : #'as yet unclassified' }
Std_msgsUInt8MultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt8MultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt8MultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt8MultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt8MultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
