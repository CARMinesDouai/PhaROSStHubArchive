"
I'm a cache of values, given a key I return a Value from the cache or from the factory
"
Class {
	#name : #RSTCache,
	#superclass : #Object,
	#instVars : [
		'size',
		'factory',
		'calls',
		'hits',
		'values'
	],
	#category : #'rST-Core'
}

{ #category : #'instance creation' }
RSTCache class >> size: aNumber factory: aBlock [ 
	^ self new initializeSize: aNumber factory: aBlock 
]

{ #category : #testing }
RSTCache class >> test [
	" 
	RSTCache test
	"
	| c |
	c := RSTCache size: 5 factory: [:key | key * 2].
	c at: 1.
	c at: 2.
	c at: 3.
	c at: 4.
	c at: 1.
	c at: 5.
	c at: 6.
	c at: 7.
	c at: 8.
	c at: 1.
	^ c
]

{ #category : #testing }
RSTCache class >> test2 [
	" 
	RSTCache test2. 
	Time millisecondsToRun:[RSTCache test2].
	MessageTally spyOn:[RSTCache test2]. 
	"
	| c |
	c := RSTCache size: 600 factory: [:key | key * 2].
	1 to: 6000 do: [:each | c at: each].
	^ c
]

{ #category : #accessing }
RSTCache >> at: aKey [ 
	"answer the object for aKey, if not present in the cache creates it"
	| element keyHash |
	calls := calls + 1.
	keyHash := aKey hash.
	1
		to: size
		do: [:index | 
			element := values at: index.
			(keyHash
						= (element at: 2)
					and: [aKey
							= (element at: 1)])
				ifTrue: ["Found!"
					hits := hits + 1.
					values
						replaceFrom: 2
						to: index
						with: (values first: index - 1).
					values at: 1 put: element.
					^ element at: 3]].
	"Not found!"
	element := {aKey. keyHash. factory value: aKey}.
	values
		replaceFrom: 2
		to: size
		with: values allButLast.
	values at: 1 put: element.
	^ element at: 3
]

{ #category : #initialization }
RSTCache >> initializeSize: aNumber factory: aBlock [ 
	size := aNumber.
	values := Array new: aNumber withAll:{nil. nil. nil}.
	factory := aBlock.
	calls := 0.
	hits := 0
]

{ #category : #printing }
RSTCache >> printOn: aStream [ 
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' size='.
	size printOn: aStream.
	aStream nextPutAll: ', calls='.
	calls printOn: aStream.
	aStream nextPutAll: ', hits='.
	hits printOn: aStream.
	aStream nextPutAll: ', ratio='.
	(hits / calls) asFloat printOn: aStream
]
