Class {
	#name : #KobukiAfficheur,
	#superclass : #Object,
	#instVars : [
		'kobuki',
		'circle',
		'ux',
		'thread',
		'sonnar1',
		'sonnar2',
		'elements'
	],
	#category : #'IronMines-Nodelets'
}

{ #category : #accessing }
KobukiAfficheur >> arreterAffichage [ 
	self thread suspend.
	CircleMorph allInstances do:[:e| e delete].
	LineMorph allInstances do:[:e| e delete].
]

{ #category : #accessing }
KobukiAfficheur >> circle [
	^ circle ifNil: [
		circle := CircleMorph new .
		circle extent: 50@50.
		]
]

{ #category : #accessing }
KobukiAfficheur >> circle: anObject [
	circle := anObject
]

{ #category : #accessing }
KobukiAfficheur >> demarrerAffichage [ 
self circle openInWorld .
self sonnar1 openInWorld .
self sonnar2 openInWorld .
self ux openInWorld .

]

{ #category : #accessing }
KobukiAfficheur >> elements [
	^ elements ifNil: [elements := OrderedCollection new]
]

{ #category : #accessing }
KobukiAfficheur >> elements: anObject [
	elements := anObject
]

{ #category : #accessing }
KobukiAfficheur >> kobuki [
	^ kobuki
]

{ #category : #accessing }
KobukiAfficheur >> kobuki: anObject [
	kobuki := anObject
]

{ #category : #accessing }
KobukiAfficheur >> newThread [
	|aThread|
	aThread := [
		[ true ] whileTrue:[ 
			self update: self kobuki.
			(Delay forMilliseconds: 100) wait.
		].
	] newProcess.
	^aThread.

]

{ #category : #accessing }
KobukiAfficheur >> sonnar1 [
	^ sonnar1 ifNil: [
		sonnar1 := CircleMorph new .
		sonnar1 extent: 10@10.
		]
]

{ #category : #accessing }
KobukiAfficheur >> sonnar2 [
	^ sonnar2 ifNil: [
		sonnar2 := CircleMorph new .
		sonnar2 extent: 10@10.
		]
]

{ #category : #accessing }
KobukiAfficheur >> sonnar2: anObject [
	sonnar2 := anObject
]

{ #category : #accessing }
KobukiAfficheur >> thread [
	thread ifNil:[self thread: self newThread].
	^thread.
]

{ #category : #accessing }
KobukiAfficheur >> thread: anObject [
	thread := anObject
]

{ #category : #accessing }
KobukiAfficheur >> update: aKobuki [
self circle position: ((aKobuki   x * 200) @ (aKobuki  y * 200)).
self sonnar1 position: ((aKobuki sonnar1 * 200) + ((aKobuki   x * 200) @ (aKobuki  y * 200))).
self sonnar2 position: ((aKobuki sonnar2 * 200) + ((aKobuki   x * 200) @ (aKobuki  y * 200))).
self ux setVertices:{
	((aKobuki   x * 200) @ (aKobuki  y * 200))+(25@25). 
	((aKobuki   x * 200) @ (aKobuki  y * 200))+ ((aKobuki ux)*100)+(25@25)
	}.

]

{ #category : #accessing }
KobukiAfficheur >> ux [
	^ ux ifNil: [ux := LineMorph new.]
]

{ #category : #accessing }
KobukiAfficheur >> ux: anObject [
	ux := anObject
]
