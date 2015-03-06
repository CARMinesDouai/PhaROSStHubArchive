Class {
	#name : #KobukiTest,
	#superclass : #Kobuki,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : #IronMinesTest
}

{ #category : #accessing }
KobukiTest >> demarrer [
	self speedManager velocityThread resume. 
]

{ #category : #'as yet unclassified' }
KobukiTest >> initialize [
	super initialize.
	self velocity linear: Vector3ForTest new.
	self velocity angular: Vector3ForTest new.
	sonar0 := sonar1 := sonar2 := sonar3 := sonar4 := 0@0.
]

{ #category : #accessing }
KobukiTest >> makeSound: aInt [
Transcript show:'makesound'; cr.
]

{ #category : #'as yet unclassified' }
KobukiTest >> newVelocityThread [ 
	^ velocityThread := [ 
	[ 
	self x: (self x + (0.01*((self velocity linear x) * (self z cos))) ).
	self y: (self y + (0.01*((self velocity linear x) * (self z sin)) )).
	self z: (self z + (0.01*(self velocity angular z * 1))).
	self changed .
	(Delay forMilliseconds: 1) wait ] repeat ] newProcess
]

{ #category : #accessing }
KobukiTest >> resetOdom [ 
	self x: 0.
	self y: 0.
	self z: 0.
]

{ #category : #accessing }
KobukiTest >> speedManager [
	speedManager ifNil:[
		speedManager := SpeedManagerForTest new.
		speedManager kobuki: self.
	].
	^speedManager.
]

{ #category : #accessing }
KobukiTest >> x [
	^ x ifNil: [x:=0]
]

{ #category : #accessing }
KobukiTest >> x: anObject [
	x := anObject
]

{ #category : #accessing }
KobukiTest >> y [
	^ y ifNil: [y:=0]
]

{ #category : #accessing }
KobukiTest >> y: anObject [
	y := anObject
]

{ #category : #accessing }
KobukiTest >> z [
	^ z ifNil: [z:=0]
]

{ #category : #accessing }
KobukiTest >> z: anNum [

	z := anNum.
]
