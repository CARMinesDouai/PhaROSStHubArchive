Class {
	#name : #'Rocon_std_msgsStringArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringArray class >> rosMd5Sum [ 
^'51789d20146e565223d0963361aecda1'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringArray class >> rosTypeDefinition [ 
^' string[] strings
'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringArray class >> rosTypeName [ 
^'rocon_std_msgs/StringArray'
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringArray class >> typeCreationOrder [ 
^244
]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringArray >> initialize [
	super initialize.
	 self strings: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringArray >> strings [
	^ self getAt: #strings. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringArray >> strings: aValue [
	^ self at: #strings put: aValue. 

]
