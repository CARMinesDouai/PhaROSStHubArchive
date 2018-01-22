Class {
	#name : #'Std_msgsMultiArrayLayout',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout >> data_offset [
	^ self getAt: #data_offset. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout >> data_offset: aValue [
	^ self at: #data_offset put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout >> dim [
	^ self getAt: #dim. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout >> dim: aValue [
	^ self at: #dim put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsMultiArrayLayout >> initialize [
	super initialize.
	 self dim: OrderedCollection new . 
	 self data_offset: 0. 

]
