Class {
	#name : #RSTTestCase,
	#superclass : #TestCase,
	#instVars : [
		'defaultBroker',
		'extraBroker',
		'ip'
	],
	#category : #'rST-Tests'
}

{ #category : #testing }
RSTTestCase class >> isAbstract [
	^self == RSTTestCase or: [super isAbstract]
]

{ #category : #accessing }
RSTTestCase >> defaultIpAndPortString [
	"Noury Bouraqadi 9/21/2006 15:31"
	
	^self ip, ':', self defaultPort printString
]

{ #category : #accessing }
RSTTestCase >> defaultPort [
	"Noury Bouraqadi 9/21/2006 15:31"
	
	^6666
]

{ #category : #accessing }
RSTTestCase >> extraIpAndPortString [
	"Noury Bouraqadi 9/21/2006 15:31"
	
	^self ip, ':', self extraPort printString
]

{ #category : #accessing }
RSTTestCase >> extraPort [
	"Noury Bouraqadi 9/21/2006 15:31"
	
	^7777
]

{ #category : #accessing }
RSTTestCase >> ip [
	"Noury Bouraqadi 9/21/2006 15:29"
	
	^ip ifNil: [ip := NetNameResolver localAddressString]
]

{ #category : #'setUp-tearDown' }
RSTTestCase >> setUp [
	RSTBroker reset.
	defaultBroker := RSTBroker startOnPort: self defaultPort logging: true.
	extraBroker := RSTBroker  basicNew.
	extraBroker 
		initialize;
		startOnPort: self extraPort logging: false.

]

{ #category : #'setUp-tearDown' }
RSTTestCase >> tearDown [
	"Noury Bouraqadi 9/21/2006 15:31"

	defaultBroker stop.
	extraBroker stop.	
	RSTBroker reset
]
