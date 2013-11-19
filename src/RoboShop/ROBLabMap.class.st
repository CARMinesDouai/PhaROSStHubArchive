Class {
	#name : #ROBLabMap,
	#superclass : #Object,
	#instVars : [
		'hash',
		'places',
		'robot',
		'goals',
		'asking',
		'guiding',
		'arrived'
	],
	#classInstVars : [
		'map'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #'as yet unclassified' }
ROBLabMap class >> map526909358: aRobot [

	map ifNil: [ 
		map :=	 ROBLabMap new
		mapHash: 526909358;
		places:
				{(ROBToilet new
						icon: nil;
						image: nil;
						location: ROBUniquePose point3;
						genre: #male).
					(ROBOffice office3111).
					(ROBOffice office3126).
					(ROBOffice office3154).
					(ROBToilet new
						icon: nil;
						image: nil;
						location: ROBUniquePose point12;
						genre: #female).
					(ROBOffice office3150).
					(ROBOffice office3145).
					(ROBOffice office3143).
					(ROBOffice office3147).
					(ROBOffice office3112).
					(ROBOffice office3127).
					(ROBOffice office3114).
					(ROBOffice office3153).
					(ROBOffice office3139).
					(ROBOffice office3122).
					(ROBOffice office3119).
					(ROBOffice office3113).
					(ROBOffice office3130).
					(ROBOffice office3130B).
					(ROBOffice office3117).
					(ROBOffice office3118).
					(ROBOffice office3110).
					(ROBKitchen new
						icon: nil;
						image: nil;
						location: ROBUniquePose point39).
					(ROBOffice office3162).
					(ROBOffice office3157).
					(ROBOffice office3102).
					(ROBOffice office3149).
					(ROBStairs centralStairs).
					(ROBOffice office3159).
					(ROBOffice office3137).
					(ROBOffice office3158).
					(ROBOffice office3152).
					(ROBOffice office3134).
					(ROBElevator new
						icon: nil;
						image: nil;
						location: ROBUniquePose point5).
					(ROBOffice office3128).
					(ROBOffice office3156).
					(ROBToilet new
						icon: nil;
						image: nil;
						location: ROBUniquePose point1;
						genre: #female).
					(ROBOffice office3103).
					(ROBOffice office3101).
					(ROBOffice office3105).
					(ROBOffice office3148).
					(ROBOffice office3160).
					(ROBOffice office3142).
					(ROBOffice office3131).
					(ROBOffice office3163).
					(ROBOffice office3125).
					(ROBOffice office3144).
					(ROBOffice office3108).
					(ROBOffice office3146).
					(ROBToilet new
						icon: nil;
						image: nil;
						location: ROBUniquePose point11;
						genre: #male).
					(ROBOffice office3161).
					(ROBOffice office3109).
					(ROBOffice office3140).
					(ROBOffice office3136).
					(ROBOffice office3124).
					};
		yourself.
		map register: (ROBTour roboticTeamTour: map ).
		map register: (ROBTour pharoTeamTour: map) .
		map register: (ROBTour evaluationTourA: map) .

		].
		map robot: aRobot.
		^ map
]

{ #category : #'as yet unclassified' }
ROBLabMap class >> reset [
	map :=  nil
]

{ #category : #service }
ROBLabMap >> addNavigateTour: aTourId [
	|place| 

	place := self searchForId: aTourId.
	place size = 1 ifFalse: [ self error:'Repeated ID' , aTourId ].
	place anyOne isTour ifFalse: [  self error:'ID doesnot belongs to a tour!'].
	
	(place anyOne places asSortedCollection: [: a : b | a shortName < b shortName ]) do: [ :p | self goal:p ].
]

{ #category : #'as yet unclassified' }
ROBLabMap >> checkHash [
	hash ifNil: [ 
		hash  := robot mapHash.
	].

]

{ #category : #'as yet unclassified' }
ROBLabMap >> employees [
	^ ((places select: #isOffice thenCollect: #employees) inject: Set new into: [ :acc :st | acc addAll: st. acc ]) asSortedCollection: [: a : b | a shortName < b shortName ].
]

{ #category : #'as yet unclassified' }
ROBLabMap >> encode [
	| ps code |
	"Save points as constructor map{HASH}"
	ps := (places inject:'{' into: [ :acc : mr | acc, mr asDump , '.']), '}'.
	code := 'map{1}: aRobot 
	ROBLabMap new mapHash: #{1}; places: {2}; robot: aRobot; yourself. ' format: { hash asString . ps }.
	self class class compile: code.
	
]

{ #category : #'as yet unclassified' }
ROBLabMap >> eventsToShow [
	^ { { #a -> 1 } asDictionary } .
]

{ #category : #'as yet unclassified' }
ROBLabMap >> facilities [
	^ (places select: #isFacility) asSortedCollection:[: a : b | a name < b name ].
]

{ #category : #service }
ROBLabMap >> goHome [
	self goal: (places detect: [ : d | d isKindOf:ROBElevator ])
]

{ #category : #service }
ROBLabMap >> goal: aPlace [

	goals size < 10 ifTrue:[
		(goals includes: aPlace) ifFalse: [
			goals add: aPlace.
		].
	]

]

{ #category : #service }
ROBLabMap >> guiding [
	^ guiding
]

{ #category : #'as yet unclassified' }
ROBLabMap >> initialize [
	places := Set new.
	goals := OrderedCollection new. 
	asking := 0.
	guiding := false.
	arrived := true.
]

{ #category : #'as yet unclassified' }
ROBLabMap >> isValid [
	^ robot mapHash = hash
]

{ #category : #service }
ROBLabMap >> locateClosestElementNamed: aName [
	| facilities robotPosition |
	
	 facilities := self searchFacilitiesByName: aName. 
	 robotPosition := robot currentPosition.
	
	^ (facilities inject: facilities anyOne into: [:min :each | 
		(min location point dist: robotPosition) < (each location point dist: robotPosition) ifTrue:[min] ifFalse:[each]		
	 ])
	

]

{ #category : #service }
ROBLabMap >> locationIDFor: anElement [
	| |
	
	^ anElement isFacility ifTrue: [ 
		(self locateClosestElementNamed: anElement name) locationID.
	] ifFalse: [ 
		anElement locationID.
	]
]

{ #category : #service }
ROBLabMap >> mantainment [
	goals ifNotEmpty: [
		guiding ifTrue: [
			asking := asking + 1. 
			asking > 4 ifTrue: [ 
				asking := 0.
				robot isRobotArrived ifTrue: [ 
					goals remove: (goals at:1).
					arrived := true.
				].
				(robot hasFinished and: [ goals isEmpty]) ifTrue: [ 
					guiding := false.	
				 ]
			 ].
		]
	].
]

{ #category : #'as yet unclassified' }
ROBLabMap >> mapHash: aHash [
	hash := aHash asString asSymbol.
]

{ #category : #accessing }
ROBLabMap >> matchesFor:  aString [
	| filtered |
	filtered := 
		(self employees select: [ :each | each name includesSubstring: aString caseSensitive: false ]) asOrderedCollection ,
		(places
		select: [ :each | each name includesSubstring: aString caseSensitive: false ]) asOrderedCollection.
		
	filtered size > 10
		ifTrue: [ filtered := filtered first: 10 ].
	^ filtered collect: [ :each | each name ]

]

{ #category : #accessing }
ROBLabMap >> matchesObjectsFor:  aString [
	| filtered |
	filtered := 
		(self employees select: [ :each | each name includesSubstring: aString caseSensitive: false ]) asOrderedCollection ,
		(places
		select: [ :each | each name includesSubstring: aString caseSensitive: false ]) asOrderedCollection.
		
	filtered size > 10
		ifTrue: [ filtered := filtered first: 10 ].
	^ filtered 

]

{ #category : #service }
ROBLabMap >> moving [
	^ arrived not.

]

{ #category : #service }
ROBLabMap >> navigateTo: aPlaceId [
	|place| 
	place := self searchForId: aPlaceId.
	place size = 1 ifFalse: [ self error:'Repeated ID' , aPlaceId ].
	self goal: (place anyOne).
]

{ #category : #service }
ROBLabMap >> navigatesToBestMatcher: aByteString [ 
	| bestMatcher |
	bestMatcher := (self matchesObjectsFor:  aByteString ) at:1 .


	bestMatcher isTour ifTrue: [  
		^ self addNavigateTour:  bestMatcher id.	
	].
	
	
	self goal: bestMatcher.
]

{ #category : #service }
ROBLabMap >> navigationGoals [
	
	^ goals.
]

{ #category : #accessing }
ROBLabMap >> office: aSmallInteger [ 
	^ (places select:[ :e | e isKindOf: ROBOffice ]) detect: [ :e | e number = aSmallInteger  ].
]

{ #category : #'as yet unclassified' }
ROBLabMap >> offices [
	^ (places select: [ : p| p isOffice and: [ p hasEmployees not and: [ p description size>0 ] ]])  asSortedCollection: [: a : b | a name < b name ].
]

{ #category : #'as yet unclassified' }
ROBLabMap >> places [
	^ places 
]

{ #category : #'as yet unclassified' }
ROBLabMap >> places: aSet [
	places := aSet asSet
]

{ #category : #'as yet unclassified' }
ROBLabMap >> register: aPlace [
	places add: aPlace.
	self checkHash.
]

{ #category : #service }
ROBLabMap >> removeAllGoals [
	| currentGoal |
	(self moving and:[ goals isEmpty not ]) ifTrue:[
		currentGoal  := goals at:1.
		goals removeAll.
		goals add: currentGoal.
	] ifFalse: [ 
		goals removeAll.
	]
	
]

{ #category : #service }
ROBLabMap >> removeGoal: aPlaceId [

	|place compare | 

	compare := aPlaceId asInteger ifNil:[ aPlaceId ] .
	place := goals detect: [ :p |  p id = compare ] ifNone: [ ^ self ].
	
	(self moving and:[ place = (goals at:1)]) ifTrue: [ 
		^ self.
	 ].
	
	goals remove: place.
]

{ #category : #'as yet unclassified' }
ROBLabMap >> renderWith: aRenderer [
	aRenderer renderMap: self. 
	^ places do: [  :p | p renderWith: aRenderer ].
]

{ #category : #'as yet unclassified' }
ROBLabMap >> robot: aRobot [
	robot := aRobot.
	self register: (ROBRobot name: robot robotName pose: [ robot currentPosition ] ).
]

{ #category : #'as yet unclassified' }
ROBLabMap >> searchFacilitiesByName: aName [
	^ self facilities select: [ : p | p name = aName ].

	
]

{ #category : #'as yet unclassified' }
ROBLabMap >> searchForId: anId [
	| compare |
	compare := anId asInteger ifNil:[ anId ] .
	^ (places , self employees) select: [ : p | p id = compare ].
]

{ #category : #'as yet unclassified' }
ROBLabMap >> searchOneForId: anId [
	^ (self searchForId: anId) anyOne.
]

{ #category : #service }
ROBLabMap >> setAsInHome [
	robot setIn: ROBUniquePose point5.
	

]

{ #category : #service }
ROBLabMap >> startGuidance [

	goals ifNotEmpty:[
		guiding := true.
		arrived := false.
		robot initializeRobotPathWithStargazerIds: { self locationIDFor: (goals first )}.
		robot goToNextId.
	].


]

{ #category : #'as yet unclassified' }
ROBLabMap >> stop [ 
	
	guiding := false.
	arrived := true.
	robot stop.
]

{ #category : #'as yet unclassified' }
ROBLabMap >> tours [
	^( places select: #isTour) asSortedCollection: [: a : b | a name < b name ].
]

{ #category : #service }
ROBLabMap >> waitingForNext [
	^ guiding.

]
