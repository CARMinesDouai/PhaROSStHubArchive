Class {
	#name : #BGSWirelessTest,
	#superclass : #BGSBodyPartTest,
	#instVars : [
		'wireless',
		'otherBotBody',
		'otherWireless'
	],
	#category : #'BOSS-BodyParts-Test'
}

{ #category : #testing }
BGSWirelessTest >> setUp [ 
	super setUp.
	wireless := BGSWireless botBody: botBody name: #wifi range: 3.
	otherBotBody := BGSRobotBody new.
	otherBotBody jumpTo: 1@1 in: terrain.
	otherWireless := BGSWireless botBody: otherBotBody name: #wifi range: 3.

]

{ #category : #testing }
BGSWirelessTest >> testDetectPeerWithinRange [
	|rangePositions expectedPeers|
	rangePositions := Set new.
	2 to: 8 do: [:x|
		2 to: 8 do: [:y|
			rangePositions add: x@y]].
	expectedPeers := {otherWireless} asSet.
	rangePositions do: [:aPoint|
		otherBotBody position: aPoint.
		self assert: wireless peers = expectedPeers].
]

{ #category : #testing }
BGSWirelessTest >> testNoPeerWithinRange [
	|rangePositions outsideRangePositions|
	rangePositions := Set new.
	2 to: 8 do: [:x|
		2 to: 8 do: [:y|
			rangePositions add: x@y]].
	outsideRangePositions := terrain positions asSet copyWithoutAll: rangePositions.
	outsideRangePositions do: [:aPoint|
		otherBotBody position: aPoint.
		self assert: wireless peers isEmpty].
]
