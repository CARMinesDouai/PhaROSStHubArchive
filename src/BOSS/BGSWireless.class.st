"
I am a wireless communication interface. I allow communication between my owner and any other robot which has another wireless communication interface.
"
Class {
	#name : #BGSWireless,
	#superclass : #BGSBodyPart,
	#instVars : [
		'range'
	],
	#category : #'BOSS-BodyParts'
}

{ #category : #'instance creation' }
BGSWireless class >> botBody: robotBody name: sensorName range: maxDistanceToDetectedPeers [
	^(self botBody: robotBody name: sensorName)
		range: maxDistanceToDetectedPeers;
		yourself
]

{ #category : #visiting }
BGSWireless >> acceptVisitor: visitor [
	visitor visitWireless: self
]

{ #category : #communicating }
BGSWireless >> bot [
	^self botBody bot
]

{ #category : #communicating }
BGSWireless >> botsInRange [ 
	^self peers collect: [:wireless| wireless bot]
]

{ #category : #testing }
BGSWireless >> isInRangeOf: aBot [
	^ aBot wireless range >= range
]

{ #category : #communicating }
BGSWireless >> peerAt: cell [
	cell content ifNil: [^nil].
	^cell content part: self name
]

{ #category : #communicating }
BGSWireless >> peers [
	| peers |
	peers := Set new.
	((self terrain cellsAround: self cell range: self range)
		select: [ :cell | (self peerAt: cell) notNil ])
		do: [ :fullCell | peers add: (self peerAt: fullCell) ].
	^ peers
]

{ #category : #accessing }
BGSWireless >> range [
	^ range
]

{ #category : #accessing }
BGSWireless >> range: anObject [
	range := anObject
]
