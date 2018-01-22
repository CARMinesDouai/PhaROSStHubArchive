Class {
	#name : #'Shape_msgsPlane',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Shape_msgsPlane >> coef [
	^ self getAt: #coef. 

]

{ #category : #'as yet unclassified' }
Shape_msgsPlane >> coef: aValue [
	^ self at: #coef put: aValue. 

]

{ #category : #'as yet unclassified' }
Shape_msgsPlane >> initialize [
	super initialize.
	 self coef:  (OrderedCollection new: 4). 

]
