Class {
	#name : #'Std_msgsFloat32MultiArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsFloat32MultiArray class >> rosMd5Sum [ 
^'6a40e0ffa6a17a503ac3f8616991b1f6'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat32MultiArray class >> rosTypeDefinition [ 
^' std_msgs/MultiArrayLayout layout
 float32[] data
'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat32MultiArray class >> rosTypeName [ 
^'std_msgs/Float32MultiArray'
]

{ #category : #'as yet unclassified' }
Std_msgsFloat32MultiArray >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat32MultiArray >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat32MultiArray >> initialize [
	super initialize.
	 self layout: Std_msgsMultiArrayLayout new. 
	 self data: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat32MultiArray >> layout [
	^ self getAt: #layout. 

]

{ #category : #'as yet unclassified' }
Std_msgsFloat32MultiArray >> layout: aValue [
	^ self at: #layout put: aValue. 

]
