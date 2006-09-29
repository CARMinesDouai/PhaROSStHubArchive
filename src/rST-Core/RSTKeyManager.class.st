"
I'm a place where you can store objetcs, when you store an object you get an unique key for this instance, sucesives call to the pool answer the same unique key.

Aditionaly you can get the object with the key.

The references to the object are strong references
"
Class {
	#name : #RSTKeyManager,
	#superclass : #Object,
	#instVars : [
		'lastKey',
		'dictionary',
		'mutex',
		'onNewKey'
	],
	#category : #'rST-Core'
}

{ #category : #accessing }
RSTKeyManager >> at: keyObject [
	"anser the object that the key was asigned before"
^ self at:keyObject ifAbsent:[self error:'Object no found for key:', keyObject asString]
]

{ #category : #accessing }
RSTKeyManager >> at: keyObject ifAbsent: absentBlock [ 
	"anser the object that the key was asigned before"
	| value |
	mutex
		critical: [self flag: #TODO.
			"TODO: be carefull when WeakDictionary will be used"
			value _ dictionary
						at: keyObject
						ifAbsent: [].
			value
				ifNil: [value _ absentBlock value]].
	^ value
]

{ #category : #accessing }
RSTKeyManager >> at: keyObject put: anObject [
	"asign keyObject to anObject"
	^ dictionary at: keyObject put: anObject
]

{ #category : #private }
RSTKeyManager >> depurate [
	"PRIVATE: This method is called from a critical section, be carefull to call 
	it without synchonization"
	
]

{ #category : #accessing }
RSTKeyManager >> hasKey: anObject [ 
	"answer if anObject has a key"
	anObject isNil
		ifTrue: [^ self error: 'can store a nil'].

	mutex
		critical: [dictionary
				keyAtIdentityValue: anObject
				ifAbsent: [^ false]].
	^ true
]

{ #category : #initialization }
RSTKeyManager >> initialize [
	lastKey _ 0.
	mutex _ Semaphore forMutualExclusion.
	self initializeDictionary.
	onNewKey _ nil
]

{ #category : #initialization }
RSTKeyManager >> initializeDictionary [
	"hook method"
	dictionary _ Dictionary new
]

{ #category : #accessing }
RSTKeyManager >> keyFor: anObject [ 
	"gives a key for anObject, the key will be the same in future calls"
	| key |
	anObject isNil
		ifTrue: [^ self error: 'can store a nil'].
	mutex
		critical: [key _ dictionary
						keyAtIdentityValue: anObject
						ifAbsent: [self newKeyFor: anObject]].
	^ key
]

{ #category : #private }
RSTKeyManager >> newKeyFor: anObject [ 
	"PRIVATE: This method is called from a critical section, be carefull to call 
	it without synchronization"
	| lastKeyAsString |
	lastKey _ lastKey + 1.
	lastKeyAsString _ 'OID-'
				, (self printHexFrom: 65535 atRandom)
				, (self printHexFrom: lastKey)
				, (self printHexFrom: 65535 atRandom).
	dictionary at: lastKeyAsString put: anObject.
	onNewKey isNil ifFalse:[onNewKey value: anObject value: lastKeyAsString].
	(lastKey isDivisibleBy: 25)
		ifTrue: [self depurate].
	^ lastKeyAsString
]

{ #category : #accessing }
RSTKeyManager >> onNewKey: aBlock [
	onNewKey _ aBlock
]

{ #category : #private }
RSTKeyManager >> printHexFrom: anInteger [
	"Noury Bouraqadi 9/22/2006 02:41"
	
	^(anInteger printPaddedWith: $0 to: 4 base: 16) allButFirst: 3
]

{ #category : #printing }
RSTKeyManager >> printOn: aStream [ 
	super printOn: aStream.
	aStream nextPutAll: ' last key=';
		 nextPutAll: lastKey asString;
		 nextPutAll: ', objects count=';
		 nextPutAll: dictionary size asString
]

{ #category : #removing }
RSTKeyManager >> removeKey: keyObject [ 
mutex
		critical: [
	^ dictionary removeKey: keyObject]
]

{ #category : #accessing }
RSTKeyManager >> size [
	"answer an estimated size"
	^ mutex
		critical: [dictionary size]
]
