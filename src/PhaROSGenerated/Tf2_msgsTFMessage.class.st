Class {
	#name : #'Tf2_msgsTFMessage',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsTFMessage >> initialize [
	super initialize.
	 self transforms: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Tf2_msgsTFMessage >> transforms [
	^ self getAt: #transforms. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsTFMessage >> transforms: aValue [
	^ self at: #transforms put: aValue. 

]
