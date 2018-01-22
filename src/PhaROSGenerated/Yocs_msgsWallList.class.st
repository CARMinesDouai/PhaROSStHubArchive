Class {
	#name : #'Yocs_msgsWallList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsWallList >> initialize [
	super initialize.
	 self obstacles: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWallList >> obstacles [
	^ self getAt: #obstacles. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsWallList >> obstacles: aValue [
	^ self at: #obstacles put: aValue. 

]
