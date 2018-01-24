Class {
	#name : #'Std_msgsInt32MultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsInt32MultiArray class >> rosMd5Sum [ 
^'1d99f79f8b325b44fee908053e9c945b'
]

{ #category : #'as yet unclassified' }
Std_msgsInt32MultiArray class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayLayout layout
 int32[] data
'
]

{ #category : #'as yet unclassified' }
Std_msgsInt32MultiArray class >> rosTypeName [ 
^'std_msgs/Int32MultiArray'
]

{ #category : #'as yet unclassified' }
Std_msgsInt32MultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt32MultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt32MultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsInt32MultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsInt32MultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
