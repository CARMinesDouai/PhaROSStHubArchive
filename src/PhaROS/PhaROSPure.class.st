Class {
	#name : #PhaROSPure,
	#superclass : #PhaROSNode,
	#instVars : [
		'access'
	],
	#category : #'PhaROS-Experiments'
}

{ #category : #'as yet unclassified' }
PhaROSPure >> initialize [ 
	super initialize.
	access := Robulab new.
]

{ #category : #'as yet unclassified' }
PhaROSPure >> printAceleration: aLinearVelocity and: anAngularVelocity [
	(access directoryService services at:'0003') setTargetLinearSpeed: aLinearVelocity andTargetAngularSpeed: anAngularVelocity.
]

{ #category : #'as yet unclassified' }
PhaROSPure >> receive: aMessage from: aChannel [ 
	| linear angular |

	linear := (aMessage value linear * 0.1) min: 0.1.
	angular := (aMessage value angular * 0.1) min: 0.2.
	
	7000 timesRepeat: [
		self printAceleration: linear and: angular.
	].
	
	
	
	

]

{ #category : #'as yet unclassified' }
PhaROSPure >> repeat: aLinearVelocity and: anAngularVelocity for: milliSeconds [ 
	| times delay  linear angular |
		
	delay := Delay forMilliseconds: 10.
	times := 10.
	
	"(milliSeconds/10)."
	

	1 to: times do: [ :time |
		linear := self uniformAccelerationFor: time withALimitOf: aLinearVelocity inAnTimeIntervalOf: milliSeconds.
		angular :=  self uniformAccelerationFor: time withALimitOf: anAngularVelocity inAnTimeIntervalOf: milliSeconds.
		self printAceleration: linear and: angular.
"		delay wait."
	].

]

{ #category : #'as yet unclassified' }
PhaROSPure >> resolveXForTime: i inATimeIntervalOf: milliSeconds [
	| base diferential x |
	" Sumatory of t / 2000 beginning with i = -t / 200 and limited to t/200 "
	
	
	
	base := (i /(4/milliSeconds)) sqrt .
	diferential := milliSeconds / 2000.
	
	x := base + (diferential * i).
	
	(x > (base * -1) or: [ x < base ] )ifTrue: [
		Error signal: ' x cannot takes values out of the interval defined by [-t/200 t/200]'	.
	].
	^ x.
]

{ #category : #resolving }
PhaROSPure >> resolveXForTime: time withALimitOf: i inATimeIntervalOf: t [ 

	| base diferential x |
	" Sumatory of t / 2000 beginning with i = -t / 200 and limited to t/200 "
	
	
	
	base := (i abs /(4/t)) sqrt * -1.
	diferential := t / 2000.
	
	x := base + (diferential * time).
	
	x > (base * -1) ifTrue:[
		^base * -1.
	].
	x < base ifTrue: [
		^base. 	
	].
	^ x.
]

{ #category : #'as yet unclassified' }
PhaROSPure >> uniformAccelerationFor: time withALimitOf: i inAnTimeIntervalOf: t [
	| acceleration x | 
	i = 0 ifTrue: [
		^ 0.	
	].

	x := self resolveXForTime: time withALimitOf: i inATimeIntervalOf: t.
	acceleration := ((((4/t) * -1) * (x raisedTo: 2)) + (i abs)) roundUpTo: 0.001.

	acceleration < 0 ifTrue: [
		Error signal: 'this function is just working in the positive interval of the parabola'.
	].
	acceleration > i abs ifTrue: [
		Error signal: 'this have not sense :('	.
	].

	^ (acceleration * i signWith0Positive).
	
	


]
