Class {
	#name : #'Yocs_msgsARPairList',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsARPairList >> initialize [
	super initialize.
	 self pairs: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPairList >> pairs [
	^ self getAt: #pairs. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsARPairList >> pairs: aValue [
	^ self at: #pairs put: aValue. 

]
