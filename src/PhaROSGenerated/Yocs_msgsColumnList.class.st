Class {
	#name : #'Yocs_msgsColumnList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
