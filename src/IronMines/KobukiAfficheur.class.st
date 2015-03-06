Class {
	#name : #KobukiAfficheur,
	#superclass : #Object,
	#instVars : [
		'kobuki',
		'circle',
		'ux',
		'thread',
		'elements',
		'sonar1',
		'sonar2'
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
self sonar1 openInWorld .
self sonar2 openInWorld .
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
	kobuki := anObject.
	kobuki addDependent: self.
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

{ #category : #'as yet unclassified' }
KobukiAfficheur >> sonar1 [
	^ sonar1 ifNil: [
		sonar1 := CircleMorph new .
		sonar1 extent: 10@10.
		]
]

{ #category : #accessing }
KobukiAfficheur >> sonar2 [
	^ sonar2 ifNil: [
		sonar2 := CircleMorph new .
		sonar2 extent: 10@10.
		]
]

{ #category : #accessing }
KobukiAfficheur >> sonar2: anObject [
	sonar2 := anObject
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
self sonar1 position: ((aKobuki sonar1 * 200) + ((aKobuki   x * 200) @ (aKobuki  y * 200))).
self sonar2 position: ((aKobuki sonar2 * 200) + ((aKobuki   x * 200) @ (aKobuki  y * 200))).
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
