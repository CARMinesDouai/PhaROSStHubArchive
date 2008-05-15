Extension { #name : #RSTRememberer }

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> allNamed: nameObject [ 
	"Answer all objects named nameObject"
	
	^ [:objects|
		remembered keysAndValuesDo: [:object :names | 
			(names keys includes: nameObject) ifTrue:[
				objects add: object]].
		objects] value: IdentityBag new
]

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> critical: aBlock [
	"Evaluated (atomically) aBlock with the mutex in the receiver"
	
	mutex critical: aBlock
]

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> forget: anObject [
	"Removes (atomically) anObject from the receiver"
	
	"Atomic write"
	self critical:[remembered removeKey: anObject]
]

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> forget: anObject named: nameObject [ 
	"forget anObject"
	| names | 
	names := remembered 
				at: anObject 
				ifAbsent: [^ anObject].

	"Atomic write"
	self critical: [names 
					removeKey: nameObject 
					ifAbsent: [].
	names isEmpty ifTrue: [remembered removeKey: anObject]]

]

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> forgetAll [
	"Removes all objects from the receiver"
	remembered ifNotNilDo:[:r|
		r values  do:[:anObject|
			(remembered keyAtValue: anObject) ifNotNilDo:[:obj| self forget: obj]]]
]

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> maintenance [
	"Forget expired objects"
	
	| current | 
	current := Time totalSeconds.
	remembered := remembered select: [:eachRemembered | 
		self critical:[
			eachRemembered keysAndValuesRemove: [:name :expires | 
				expires notNil and:[
				expires <= current]]].
		eachRemembered notEmpty]
]
