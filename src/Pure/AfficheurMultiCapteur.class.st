Class {
	#name : #AfficheurMultiCapteur,
	#superclass : #Object,
	#instVars : [
		'afficheurs',
		'service',
		'morph'
	],
	#category : #'Pure-Afficheur'
}

{ #category : #accessing }
AfficheurMultiCapteur >> afficheurs [
	^ afficheurs
]

{ #category : #accessing }
AfficheurMultiCapteur >> afficheurs: aDictionary [
	afficheurs:= aDictionary
]

{ #category : #'as yet unclassified' }
AfficheurMultiCapteur >> initializeAfficheurs [
	self subclassResponsibility 
]

{ #category : #accessing }
AfficheurMultiCapteur >> morph [
	^ morph
]

{ #category : #accessing }
AfficheurMultiCapteur >> morph: anObject [
	morph := anObject
]

{ #category : #'as yet unclassified' }
AfficheurMultiCapteur >> printScale [
	self subclassResponsibility 
]

{ #category : #accessing }
AfficheurMultiCapteur >> scale [
	
	self subclassResponsibility 
]

{ #category : #accessing }
AfficheurMultiCapteur >> service [
	^ service
]

{ #category : #accessing }
AfficheurMultiCapteur >> service: anObject [
	service := anObject.
	(afficheurs isNil)ifTrue:[self initializeAfficheurs ].
]

{ #category : #'as yet unclassified' }
AfficheurMultiCapteur >> updateAll [
	afficheurs do: [:aff| aff update: service].
	
	
]

{ #category : #accessing }
AfficheurMultiCapteur >> xStandard [
	self subclassResponsibility 
]

{ #category : #accessing }
AfficheurMultiCapteur >> yStandard [
 
	self subclassResponsibility 
]
