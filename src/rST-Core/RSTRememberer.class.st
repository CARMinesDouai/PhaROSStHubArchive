"
My purpose is to remember some objects with some names at least for a time you tell me.  Each name has an expiration, when all names expires I'll forget the object.

NOTE: Between time and time you must send #maintenance to me
"
Class {
	#name : #RSTRememberer,
	#superclass : #Object,
	#instVars : [
		'remembered',
		'mutex'
	],
	#category : #'rST-Core'
}

{ #category : #'remembering & forgetting' }
RSTRememberer >> forgetAllNamed: nameObject [ 
	"forget anObject"
	
	| named | 
	named := self allNamed: nameObject.
	named do: [:object | self forget: object named: nameObject]
]

{ #category : #initialization }
RSTRememberer >> initialize [
	remembered _ IdentityDictionary new.
	mutex _ Semaphore forMutualExclusion
]

{ #category : #'remembering & forgetting' }
RSTRememberer >> remember: anObject forSeconds: anInteger naming: nameObject [ 
	"remember anObject at least for anInteger seconds"
	
	mutex critical: [
		| names expires | 
		names := remembered
					at: anObject
					ifAbsentPut: [Dictionary new].
		expires := anInteger ifNotNil: [Time totalSeconds + anInteger].
		names at: nameObject put: expires]
]

{ #category : #'remembering & forgetting' }
RSTRememberer >> rememberForEver: anObject naming: nameObject [ 
	"remember anObject for ever"
	^ self
		remember: anObject
		forSeconds: nil
		naming: nameObject
]
