Class {
	#name : #CaireChunk,
	#superclass : #PhaROSValue,
	#category : #PureROSNodeletsCaire
}

{ #category : #'as yet unclassified' }
CaireChunk >> initialize [
	super initialize.
	 self to: 0. 
	 self value: 0. 

]

{ #category : #'as yet unclassified' }
CaireChunk >> to [
	^ self getAt: #to. 

]

{ #category : #'as yet unclassified' }
CaireChunk >> to: aValue [
	^ self at: #to put: aValue. 

]

{ #category : #'as yet unclassified' }
CaireChunk >> value [
	^ self getAt: #value. 

]

{ #category : #'as yet unclassified' }
CaireChunk >> value: aValue [
	^ self at: #value put: aValue. 

]
