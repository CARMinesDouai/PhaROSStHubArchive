Class {
	#name : #'Std_msgsByteMultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray class >> rosMd5Sum [ 
^'70ea476cbcfd65ac2f68f3cda1e891fe'
]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayLayout layout
 int8[] data
'
]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray class >> rosTypeName [ 
^'std_msgs/ByteMultiArray'
]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsByteMultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
