"
I provide facility methods for tests that require waiting some undefined duration, which is typical in networking
"
Trait {
	#name : #NeTWait,
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #testing }
NeTWait >> defaultTimeoutDuration [
	^500 milliSeconds 
]

{ #category : #testing }
NeTWait >> waitUntil: conditionBlock [
	self waitUntil: conditionBlock timeout: self defaultTimeoutDuration
]

{ #category : #testing }
NeTWait >> waitUntil: conditionBlock onTimeout: aDuration do: aBlock [
	self waitWhile: [ conditionBlock value not ] onTimeout: aDuration do: aBlock
]

{ #category : #testing }
NeTWait >> waitUntil: conditionBlock timeout: aDuration [
	self waitUntil: conditionBlock onTimeout: aDuration do: [ self fail: 'Timeout' ]
]

{ #category : #testing }
NeTWait >> waitWhile: conditionBlock [
	self waitWhile: conditionBlock timeout: self defaultTimeoutDuration
]

{ #category : #testing }
NeTWait >> waitWhile: conditionBlock onTimeout: aDuration do: aBlock [
	| iterationCount iterationDuration |
	iterationDuration := 50 milliSeconds.
	iterationCount := (aDuration / iterationDuration) asFloat rounded + 1.
	iterationCount
		timesRepeat: [ conditionBlock value
				ifFalse: [ ^ self ].
			iterationDuration wait ].
	aBlock value
]

{ #category : #testing }
NeTWait >> waitWhile: conditionBlock timeout: aDuration [
	self waitWhile: conditionBlock onTimeout: aDuration do: [self fail: 'Timeout']
]
