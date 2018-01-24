Class {
	#name : #'Std_msgsUInt16MultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsUInt16MultiArray class >> rosMd5Sum [ 
^'52f264f1c973c4b73790d384c6cb4484'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt16MultiArray class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayLayout layout
 uint16[] data
'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt16MultiArray class >> rosTypeName [ 
^'std_msgs/UInt16MultiArray'
]

{ #category : #'as yet unclassified' }
Std_msgsUInt16MultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt16MultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt16MultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt16MultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt16MultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
