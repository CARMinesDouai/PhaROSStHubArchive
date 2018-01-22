Class {
	#name : #'Yocs_msgsTableList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
