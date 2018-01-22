Class {
	#name : #'Std_msgsBool',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsBool class >> rosTypeDefinition [ 
^' bool data
'
]

{ #category : #'as yet unclassified' }
Std_msgsBool class >> rosTypeName [ 
^'std_msgs/Bool'
]

{ #category : #'as yet unclassified' }
Std_msgsBool >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsBool >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsBool >> initialize [
	super initialize.
	 self data: false. 

]
