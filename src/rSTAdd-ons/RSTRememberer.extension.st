Extension { #name : #RSTRememberer }

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> forget: anObject [
	"Removes (atomically) anObject from the receiver"
	mutex critical:[remembered removeKey: anObject]
]

{ #category : #'*rSTAdd-ons' }
RSTRememberer >> forgetAll [
	"Removes all objects from the receiver"
	remembered keys do:[:anObject|
		self forget: anObject]
]
