Class {
	#name : #'Yocs_msgsTableList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsTableList class >> rosMd5Sum [ 
^'88fff7e2df98bd37f03f85cffc55624b'
]

{ #category : #'as yet unclassified' }
Yocs_msgsTableList class >> rosTypeDefinition [ 
^' yocs_msgs/Table[] tables
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsTableList class >> rosTypeName [ 
^'yocs_msgs/TableList'
]

{ #category : #'as yet unclassified' }
Yocs_msgsTableList >> initialize [
	super initialize.
	 self tables: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTableList >> tables [
	^ self getAt: #tables. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsTableList >> tables: aValue [
	^ self at: #tables put: aValue. 

]
