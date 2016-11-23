Trait {
	#name : #NeTWait,
	#category : #'NetworkExtras-Tests-Support'
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
