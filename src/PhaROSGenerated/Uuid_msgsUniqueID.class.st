Class {
	#name : #'Uuid_msgsUniqueID',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Uuid_msgsUniqueID >> initialize [
	super initialize.
	 self uuid:  (OrderedCollection new: 16). 

]

{ #category : #'as yet unclassified' }
Uuid_msgsUniqueID >> uuid [
	^ self getAt: #uuid. 

]

{ #category : #'as yet unclassified' }
Uuid_msgsUniqueID >> uuid: aValue [
	^ self at: #uuid put: aValue. 

]
