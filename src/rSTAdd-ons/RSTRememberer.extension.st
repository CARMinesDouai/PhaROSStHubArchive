Extension { #name : #RSTRememberer }

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> allNamed: nameObject [ 
	"mp 4/20/2006 16:25"
	"answer all objects named nameObject"
	
	^ [:objects|
		self critical: [
			remembered keysAndValuesDo: [:object :names | 
				(names keys includes: nameObject) ifTrue:[
					objects add: object]]].
		objects] value: Bag new
]

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> critical: aBlock [
	"Evaluated (atomically) aBlock with the mutex in the receiver"
	
	mutex critical: aBlock
]

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> forget: anObject [
	"Removes (atomically) anObject from the receiver"
	
	self critical:[remembered removeKey: anObject]
]

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> forget: anObject named: nameObject [ 
	"forget anObject"
	
	self critical: [
		| names | 
		names := remembered 
						at: anObject 
						ifAbsent: [^ anObject].
		names 
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
	
	self critical: [
		| current toForget | 
		current := Time totalSeconds.
		remembered := remembered select: [:eachRemembered | 
			eachRemembered keysAndValuesRemove: [:name :expires | 
				expires notNil and: [expires <= current]].
			eachRemembered notEmpty]]
]
