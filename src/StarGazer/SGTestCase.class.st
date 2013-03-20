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
SGTestCase >> closeSGPort [
	sgPort := nil.
]

{ #category : #'serial port manage' }
SGTestCase >> closeSerialPort [
	self subclassResponsibility.
]

{ #category : #'stargazer manage' }
SGTestCase >> createStarGazer: aPort [
	^sg ifNil: [ sg := StarGazer atPort: aPort. ] ifNotNil: [ sg ].
]

{ #category : #'stargazer manage' }
SGTestCase >> destroyStarGazer [
	sg := nil.
]

{ #category : #'sg port manage' }
SGTestCase >> openSGPort: aSerialPort [
	^ sgPort ifNil: [ sgPort := SGPort atPort: aSerialPort. ] ifNotNil: [ sgPort. ] .

]

{ #category : #'serial port manage' }
SGTestCase >> openSerialPort [
	self subclassResponsibility.
]

{ #category : #'sg port manage' }
SGTestCase >> withDefaultSGPort: aBlock [
	self withDefaultSerialPort: [ : port |	
		aBlock value: (self openSGPort: port).
		self closeSGPort.
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
	self withDefaultSGPort: [ : port | 
		aBlock value: (self createStarGazer: port).	
		self destroyStarGazer.
	].
]
