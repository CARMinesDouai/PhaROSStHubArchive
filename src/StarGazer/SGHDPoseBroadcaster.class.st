Class {
	#name : #SGHDPoseBroadcaster,
	#superclass : #SGPoseBroadcaster,
	#instVars : [
		'pose',
		'stamp',
		'poses',
		'rate',
		'process'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #'as yet unclassified' }
SGHDPoseBroadcaster class >> samplingMilliseconds [ 
	" In order to increase the density of the topic (hz freq) we define which is the rate target. That target is the key to define if the topic should be filled with extrapolated data or not.  It also define the rate of execution of the responsible thread"
	^ 50.
]

{ #category : #'as yet unclassified' }
SGHDPoseBroadcaster class >> samplingSize [
	" The sampling size is the last n measures that are taken in care to extrapolate the data. This value is based on the average rate of the stargazer measures (which is 9.1hz), with that, we have 9.1 measures per second. So, we base the future movements taking in care the last half second of behavior, since the movement difference is arbitrary as the user wishes"
	^ 5 
]

{ #category : #'as yet unclassified' }
SGHDPoseBroadcaster >> highDensity [ 
	
	(DateAndTime now - stamp) asMilliSeconds > (SGHDPoseBroadcaster samplingMilliseconds * 0.9) ifTrue: [
	
		[
			self pose: self nextValue.	
		] on: Error do: [
			:e | 
			self log: e messageText. 
		]
	].
	(Delay forMilliseconds: SGHDPoseBroadcaster samplingMilliseconds * 0.5) wait.
	
]

{ #category : #'as yet unclassified' }
SGHDPoseBroadcaster >> initialize [
	super initialize.
	poses := OrderedCollection new.
	stamp := DateAndTime now - 1 minute.
	
]

{ #category : #'as yet unclassified' }
SGHDPoseBroadcaster >> nextValue [
	| accumulated cocient posesCache |
	posesCache := poses shallowCopy.
	
	"	true ifTrue: [
	^ poses last.]."

	posesCache size > (SGHDPoseBroadcaster samplingSize - 2)  ifTrue: [

		cocient := 0.
		accumulated := PhaROSPoseAccumulator new.

		1 to: posesCache size - 1 do: [ :i |
			accumulated accumulate: ((posesCache at:i ) - (posesCache at: i+1)) pondered: i.
		].

		poses removeFirst.

		^ posesCache last + accumulated value.	
	].
	self error: 'There is not enough data to generate extrapolation'.
]

{ #category : #'as yet unclassified' }
SGHDPoseBroadcaster >> pose: aPose [
	stamp := DateAndTime now.
	super pose: (aPose roundUpTo: 0.001).
	self registerPose: aPose.
	
]

{ #category : #'as yet unclassified' }
SGHDPoseBroadcaster >> registerPose: aPose [

	poses add: aPose.
	poses size > SGHDPoseBroadcaster samplingSize ifTrue: [
		poses removeFirst: ( poses size - SGHDPoseBroadcaster samplingSize).
		poses := poses select: [:i | true].
	]
]

{ #category : #'as yet unclassified' }
SGHDPoseBroadcaster >> start [
	super pose: PhaROSPose zero.
	process := self paralellize looping highDensity asStickyReference.
]
