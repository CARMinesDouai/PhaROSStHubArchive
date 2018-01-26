Class {
	#name : #'Yocs_msgsColumnList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsColumnList class >> rosMd5Sum [ 
^'fdf98d2a8a0cfe17000cdb66889826b6'
]

{ #category : #'as yet unclassified' }
Yocs_msgsColumnList class >> rosTypeDefinition [ 
^' yocs_msgs/Column[] obstacles
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsColumnList class >> rosTypeName [ 
^'yocs_msgs/ColumnList'
]

{ #category : #'as yet unclassified' }
Yocs_msgsColumnList class >> typeCreationOrder [ 
^427
]

{ #category : #'as yet unclassified' }
Yocs_msgsColumnList >> initialize [
	super initialize.
	 self obstacles: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumnList >> obstacles [
	^ self getAt: #obstacles. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumnList >> obstacles: aValue [
	^ self at: #obstacles put: aValue. 

]
