Class {
	#name : #BGSBodyPartTest,
	#superclass : #TestCase,
	#instVars : [
		'botBody',
		'terrain'
	],
	#category : #'BOSS-BodyParts-Test'
}

{ #category : #testing }
BGSBodyPartTest >> setUp [ 
	botBody := BGSRobotBody new.
	terrain := BGSGrid extent: 10@10.
	botBody jumpTo: 5@5 in: terrain.

]
