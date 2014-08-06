"
Logger maintains a file with logs of a simulation.
To start logging simply create a logger by evaluating the expression:

	logger := BGSLogger on: someSimulation 

By default the name of the log file is the class name of the simulation with the current time stamp.
A different can be chosen by evaluating:

	logger := BGSLogger on: someSimulation logInto: 'myLogFile.txt'

Subclasses are likely to redefine methods:
-logHeader 
	Produces the first line of the log file with names of each column
-logStep
	Adds a new line to the log file with current simulation data
"
Class {
	#name : #BGSLogger,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'stream',
		'simulation'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'instance creation' }
BGSLogger class >> on: aBGSSimulation [
	|fileName|
	fileName := aBGSSimulation className, TimeStamp current printString, '.txt'.
	^self on: aBGSSimulation logInto: fileName

]

{ #category : #'instance creation' }
BGSLogger class >> on: aBGSSimulation logInto: fileName [
	|cleanFileName|
	cleanFileName := fileName
		replaceAll:  Character space with: $-;
		replaceAll: $: with: $-. 
	^self new
		simulation: aBGSSimulation fileName: fileName;
		yourself
]

{ #category : #accessing }
BGSLogger >> allLog [
	^self stream contents 
]

{ #category : #'initialize-release' }
BGSLogger >> close [
	self stream close.
]

{ #category : #logging }
BGSLogger >> cr [
	self stream cr.
]

{ #category : #logging }
BGSLogger >> crLog: anObject [
	self stream cr.
	self log: anObject
]

{ #category : #logging }
BGSLogger >> crtab [
	self stream crtab
]

{ #category : #logging }
BGSLogger >> crtabLog: anObject [
	self stream crtab.
	self log: anObject
]

{ #category : #accessing }
BGSLogger >> fileName [
	^ fileName
]

{ #category : #logging }
BGSLogger >> log: anObject [ 
	(anObject isKindOf: String) ifTrue: [^self stream nextPutAll: anObject].
	anObject printOn: self stream
]

{ #category : #logging }
BGSLogger >> logCr: anObject [
	self log: anObject.
	self stream cr
]

{ #category : #logging }
BGSLogger >> logCrLf: anObject [
	self log: anObject.
	self stream crlf
]

{ #category : #logging }
BGSLogger >> logHeader [
	self log: 'step'.
	self robots do: [:bot|
		self 
			tab;
			log: bot id, '-position';
			tab;
			log: bot id, '-heading'
	].
	self cr.
]

{ #category : #logging }
BGSLogger >> logLf: anObject [
	self log: anObject.
	self stream lf
]

{ #category : #logging }
BGSLogger >> logStep [
	self log: self stepCount.
	self robots
		do: [ :bot | 
		self 
			tab
			log: bot position;
			tab;
			log: bot heading
	].
	self cr.
]

{ #category : #accessing }
BGSLogger >> robots [
	^self simulation robots
]

{ #category : #accessing }
BGSLogger >> simulation [
	^ simulation
]

{ #category : #'initialize-release' }
BGSLogger >> simulation: aBGSSimulation fileName: aString [
	fileName := aString.
	self stream: (FileStream fileNamed: fileName).
	simulation := aBGSSimulation.
	simulation addDependent: self.
	self logHeader.
	self update: simulation
]

{ #category : #accessing }
BGSLogger >> stepCount [
	^self simulation stepCount
]

{ #category : #accessing }
BGSLogger >> stream [
	^ stream
]

{ #category : #'initialize-release' }
BGSLogger >> stream: anObject [
	stream := anObject
]

{ #category : #logging }
BGSLogger >> tab [
	self stream tab
]

{ #category : #logging }
BGSLogger >> update: anObject [
	self logStep
]
