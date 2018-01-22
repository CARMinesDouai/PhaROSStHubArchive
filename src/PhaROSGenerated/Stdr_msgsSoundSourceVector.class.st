Class {
	#name : #'Stdr_msgsSoundSourceVector',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSourceVector >> initialize [
	super initialize.
	 self sound_sources: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSourceVector >> sound_sources [
	^ self getAt: #sound_sources. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSourceVector >> sound_sources: aValue [
	^ self at: #sound_sources put: aValue. 

]
