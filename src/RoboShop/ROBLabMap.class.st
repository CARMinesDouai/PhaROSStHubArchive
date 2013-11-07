Class {
	#name : #ROBLabMap,
	#superclass : #Object,
	#instVars : [
		'hash',
		'places',
		'robot'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #'as yet unclassified' }
ROBLabMap class >> map526909358: aRobot [
	^ ROBLabMap new
		mapHash: 526909358;
		places:
				{(ROBToilet new
						icon: nil;
						image: nil;
						location: ROBUniquePose point3;
						genre: #male).
					(ROBStairs new
						icon: nil;
						image: nil;
						location: ROBUniquePose point38).
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
					(ROBOffice office3117).
					(ROBOffice office3118).
					(ROBOffice office3110).
					(ROBStairs new
						icon: nil;
						image: nil;
						location: ROBUniquePose point22).
					(ROBKitchen new
						icon: nil;
						image: nil;
						location: ROBUniquePose point39).
					(ROBOffice office3162).
					(ROBOffice office3157).
					(ROBOffice office3102).
					(ROBOffice office3149).
					(ROBStairs new
						icon: nil;
						image: nil;
						location: ROBUniquePose point28).
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
					(ROBOffice office3136)};
		robot: aRobot;
		yourself.
]

{ #category : #'as yet unclassified' }
ROBLabMap >> checkHash [
	hash ifNil: [ 
		hash  := robot mapHash.
	].

]

{ #category : #'as yet unclassified' }
ROBLabMap >> employees [
	^ ((places select: #isOffice thenCollect: #employees) inject: Set new into: [ :acc :st | acc addAll: st. acc ]) asSortedCollection: [: a : b | a name < b name ].
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
ROBLabMap >> facilities [
	^ (places select: #isFacility) asSortedCollection:[: a : b | a name < b name ].
]

{ #category : #'as yet unclassified' }
ROBLabMap >> initialize [
	places := Set new.
	
]

{ #category : #'as yet unclassified' }
ROBLabMap >> isValid [
	^ robot mapHash = hash
]

{ #category : #'as yet unclassified' }
ROBLabMap >> mapHash: aHash [
	hash := aHash asString asSymbol.
]

{ #category : #accessing }
ROBLabMap >> office: aSmallInteger [ 
	^ (places select:[ :e | e isKindOf: ROBOffice ]) detect: [ :e | e number = aSmallInteger  ].
]

{ #category : #'as yet unclassified' }
ROBLabMap >> offices [
	^ (places select: #isOffice) asSortedCollection: [: a : b | a name < b name ].
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
