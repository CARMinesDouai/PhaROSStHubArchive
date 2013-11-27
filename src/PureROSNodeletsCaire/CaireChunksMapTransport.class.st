Class {
	#name : #CaireChunksMapTransport,
	#superclass : #PhaROSValue,
	#category : #PureROSNodeletsCaire
}

{ #category : #'as yet unclassified' }
CaireChunksMapTransport >> addChunk: aValue [
	^ self chunks add: aValue. 

]

{ #category : #'as yet unclassified' }
CaireChunksMapTransport >> chunks [
	^ self getAt: #chunks. 

]

{ #category : #'as yet unclassified' }
CaireChunksMapTransport >> chunks: aValue [
	^ self at: #chunks put: aValue. 

]

{ #category : #'as yet unclassified' }
CaireChunksMapTransport >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
CaireChunksMapTransport >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
CaireChunksMapTransport >> info [
	^ self getAt: #info. 

]

{ #category : #'as yet unclassified' }
CaireChunksMapTransport >> info: aValue [
	^ self at: #info put: aValue. 

]

{ #category : #'as yet unclassified' }
CaireChunksMapTransport >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self info: Nav_msgsMapMetaData new. 
	 self chunks: OrderedCollection new . 

]
