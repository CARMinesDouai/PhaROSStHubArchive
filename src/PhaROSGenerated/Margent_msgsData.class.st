Class {
	#name : #'Margent_msgsData',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Margent_msgsData class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string mesage
 int64[] flag
 float64[] value
'
]

{ #category : #'as yet unclassified' }
Margent_msgsData class >> rosTypeName [ 
^'margent_msgs/Data'
]

{ #category : #'as yet unclassified' }
Margent_msgsData >> flag [
	^ self getAt: #flag. 

]

{ #category : #'as yet unclassified' }
Margent_msgsData >> flag: aValue [
	^ self at: #flag put: aValue. 

]

{ #category : #'as yet unclassified' }
Margent_msgsData >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Margent_msgsData >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Margent_msgsData >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self mesage: ''. 
	 self flag: OrderedCollection new . 
	 self value: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Margent_msgsData >> mesage [
	^ self getAt: #mesage. 

]

{ #category : #'as yet unclassified' }
Margent_msgsData >> mesage: aValue [
	^ self at: #mesage put: aValue. 

]

{ #category : #'as yet unclassified' }
Margent_msgsData >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
Margent_msgsData >> value: aValue [
	^ self at: #value put: aValue. 

]
