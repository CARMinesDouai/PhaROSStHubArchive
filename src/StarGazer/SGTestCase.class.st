Class {
	#name : #SGTestCase,
	#superclass : #TestCase,
	#instVars : [
		'sgPort',
		'sg'
	],
	#category : #'StarGazer-Kernel-Test'
}

{ #category : #'sg port manage' }
SGTestCase >> closeSGGate [
	sgPort ifNotNil: [ 
		sgPort stopCalculations.
		sgPort := nil
	].
]

{ #category : #'serial port manage' }
SGTestCase >> closeSerialPort [
	self subclassResponsibility.
]

{ #category : #'stargazer manage' }
SGTestCase >> createStarGazer: aPort [
	^sg ifNil: [ sg := StarGazer atGate: aPort. ] ifNotNil: [ sg ].
]

{ #category : #'stargazer manage' }
SGTestCase >> destroyStarGazer [
	sg ifNotNil: [
		sg finalize.
		sg := nil.
	]
]

{ #category : #'sg port manage' }
SGTestCase >> openSGGate: aSerialPort [
	^ sgPort ifNil: [ 
		sgPort := (SGGate atPort: aSerialPort). 
		
	] ifNotNil: [
		 sgPort. 
	] .

]

{ #category : #'serial port manage' }
SGTestCase >> openSerialPort [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
SGTestCase >> tearDown [ 
	self closeSerialPort.
	self closeSGGate.
	self destroyStarGazer.
]

{ #category : #'serial port manage' }
SGTestCase >> waitForUser: aString [
	self halt: aString.
]

{ #category : #'sg port manage' }
SGTestCase >> withDefaultSGGate: aBlock [
	self withDefaultSerialPort: [ : port |	
		aBlock value: (self openSGGate: port).
		self closeSGGate.
	].
	
]

{ #category : #'serial port manage' }
SGTestCase >> withDefaultSerialPort: aBlock [
	| port |
	
	port := self openSerialPort.
	aBlock value: port.
	self closeSerialPort.

]

{ #category : #'stargazer manage' }
SGTestCase >> withDefaultStarGazer: aBlock [
	self withDefaultSGGate: [ : port | 
		aBlock value: (self createStarGazer: port).	
		self destroyStarGazer.
	].
]
