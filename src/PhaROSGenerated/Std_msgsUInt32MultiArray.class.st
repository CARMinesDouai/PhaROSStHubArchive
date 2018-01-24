Class {
	#name : #'Std_msgsUInt32MultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsUInt32MultiArray class >> rosMd5Sum [ 
^'4d6a180abc9be191b96a7eda6c8a233d'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt32MultiArray class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayLayout layout
 int32[] data
'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt32MultiArray class >> rosTypeName [ 
^'std_msgs/UInt32MultiArray'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt32MultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt32MultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt32MultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt32MultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt32MultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
