Extension { #name : #String }

{ #category : #'*rSTAdd-ons' }
String >> isIpAddress [
	"Answers true if the receiver can represent an ip address"
	
	^ (self includes: $.) and:[
	(self subStrings: '.') allSatisfy: [:candidate|
		candidate asNumber isInteger and:[
		candidate asNumber between: 0 and: 255]]]
	
]
