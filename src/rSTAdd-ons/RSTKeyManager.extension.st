Extension { #name : #RSTKeyManager }

{ #category : #'*rSTAdd-ons' }
RSTKeyManager >> at: aKey ifAbsent: aBlock [

	"WARNING: if aBlock performs write operations on the receiver
	it may need a mutex protecting it."

	^ dictionary at: aKey ifAbsent: aBlock
]

{ #category : #'*rSTAdd-ons' }
RSTKeyManager >> at: keyObject put: anObject [

	"Write protected"
	^ mutex critical: [dictionary at: keyObject put: anObject]
]

{ #category : #'*rSTAdd-ons' }
RSTKeyManager >> depurate [

	dictionary keys do:[:aKey | 
		(dictionary at: aKey) ifNil:[
			self removeKey: aKey ifAbsent:[]]].

]

{ #category : #'*rSTAdd-ons' }
RSTKeyManager >> hasKey: anObject [ 
	"answer if anObject has a key"
	anObject isNil
		ifTrue: [^ self error: 'can store a nil'].

	dictionary
		keyAtIdentityValue: anObject
		ifAbsent: [^ false].
	^ true
]

{ #category : #'*rSTAdd-ons' }
RSTKeyManager >> keyFor: anObject [ 
	"Answers a key for anObject, 
	the key will be the same in future calls"
	anObject ifNil: [^ self error: 'can store a nil'].

	^ dictionary
		keyAtIdentityValue: anObject
		ifAbsent: [self newKeyFor: anObject]
]

{ #category : #'*rSTAdd-ons' }
RSTKeyManager >> newKeyFor: anObject [ 
	"Answers a key for anObject in the receiver."
	| lastKeyAsString |
	lastKey := lastKey + 1.
	lastKeyAsString := UUID new asString.
	self at: lastKeyAsString put: anObject.
	
	onNewKey ifNotNil:[
		mutex critical:[
			onNewKey value: anObject value: lastKeyAsString]].
			
	^ lastKeyAsString
]

{ #category : #'*rSTAdd-ons' }
RSTKeyManager >> removeKey: keyObject [ 

	^ mutex critical:[dictionary removeKey: keyObject]
]

{ #category : #'*rSTAdd-ons' }
RSTKeyManager >> removeKey: keyObject ifAbsent: aBlock [

	^ mutex critical:[
		dictionary removeKey: keyObject ifAbsent: aBlock]
]
