Class {
	#name : #'Std_msgsChar',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsChar class >> rosMd5Sum [ 
^'1bf77f25acecdedba0e224b162199717'
]

{ #category : #'as yet unclassified' }
Std_msgsChar class >> rosTypeDefinition [ 
^' int8 data
'
]

{ #category : #'as yet unclassified' }
Std_msgsChar class >> rosTypeName [ 
^'std_msgs/Char'
]

{ #category : #'as yet unclassified' }
Std_msgsChar >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsChar >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsChar >> initialize [
	super initialize.
	 self data: 0. 

]
