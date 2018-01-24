Class {
	#name : #'Std_msgsInt8MultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsInt8MultiArray class >> rosMd5Sum [ 
^'d7c1af35a1b4781bbe79e03dd94b7c13'
]

{ #category : #'as yet unclassified' }
Std_msgsInt8MultiArray class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayLayout layout
 int8[] data
'
]

{ #category : #'as yet unclassified' }
Std_msgsInt8MultiArray class >> rosTypeName [ 
^'std_msgs/Int8MultiArray'
]

{ #category : #'as yet unclassified' }
Std_msgsInt8MultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt8MultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt8MultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsInt8MultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt8MultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
