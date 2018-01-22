Class {
	#name : #'Std_msgsUInt64MultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsUInt64MultiArray class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayLayout layout
 int64[] data
'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt64MultiArray class >> rosTypeName [ 
^'std_msgs/UInt64MultiArray'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt64MultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt64MultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt64MultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt64MultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt64MultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
