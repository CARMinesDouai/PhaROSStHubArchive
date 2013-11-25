Class {
	#name : #CaireMapFuser,
	#superclass : #Object,
	#instVars : [
		'events',
		'map'
	],
	#category : #PureROSNodeletsCaire
}

{ #category : #'as yet unclassified' }
CaireMapFuser class >> deltaX [
	^ 20
]

{ #category : #'as yet unclassified' }
CaireMapFuser class >> deltaY [
	^ -20
]

{ #category : #'domain events' }
CaireMapFuser >> fusionKnownDataAt: x and: y with: otherMap [ 

		((map at:x at: y) = 0 or: [ (otherMap at: x + CaireMapFuser deltaX at: y + CaireMapFuser deltaY) = 0 ]) ifTrue: [
			map at: x at: y put: 0. 
		]
		
		
		
	 
]

{ #category : #'domain events' }
CaireMapFuser >> initialize [ 
	events := Dictionary new.
]

{ #category : #'domain events' }
CaireMapFuser >> isInBound: x and: y of: aMerginMap [


	^ x + CaireMapFuser deltaX >= 0 and: [
		x + CaireMapFuser deltaX < aMerginMap width and: [
			y + CaireMapFuser deltaY >= 0 and: [
				y + CaireMapFuser deltaY < aMerginMap height.
			]
		]	
	].
 
	
]

{ #category : #'domain events' }
CaireMapFuser >> noticeMapUpdate [ 
	self trigger: #FusedMapUpdate
]

{ #category : #'domain events' }
CaireMapFuser >> on: anEvent do: aBlockClosure [ 
	(events at: anEvent ifAbsentPut: [OrderedCollection new]) add: aBlockClosure.
]

{ #category : #'domain events' }
CaireMapFuser >> registerMap: otherMap [

	

	map ifNil: [ map := otherMap ] ifNotNil: [
		1 to: map width do: [  : i  |  	1 to: map height do: [: j |
			(self isInBound: i and: j of: otherMap) ifTrue: [
				self fusionKnownDataAt: i and:j with: otherMap.
			]				
		]]



	].
]

{ #category : #'domain events' }
CaireMapFuser >> registerMaps: aCollection [
	aCollection do: [ : m | self registerMap: m ].
	self noticeMapUpdate.
	map := nil.
]

{ #category : #'domain events' }
CaireMapFuser >> trigger: aSymbol [
	((events at: aSymbol ) ifAbsentPut: [ OrderedCollection new ]) do: [ 
		: e | e cull: map. 
	].
]
