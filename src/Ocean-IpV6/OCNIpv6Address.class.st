Class {
	#name : #OCNIpv6Address,
	#superclass : #OCNIpAddress,
	#category : #'Ocean-IpV6'
}

{ #category : #'instance creation' }
OCNIpv6Address class >> newFromString: aStringIpAddress [
	|addressToCheck|
	"verify that aStringIpAddress is a valid ipv6"
	 addressToCheck := aStringIpAddress asLowercase.
	
	
	({(addressToCheck size <= 39).
	('abcdef:0123456789' includesAllOf: addressToCheck).
	((addressToCheck  splitOn: '::') size <= 2).
	((addressToCheck occurrencesOf: ':') <= 7)} anySatisfy:  [ :each | each not ])
	ifTrue: [ ^self signalInvalidStringAddressException: aStringIpAddress ].
	
"	(aStringIpAddress matchesRegex: '((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}((b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b).){3}(b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b))|(([0-9A-Fa-f]{1,4}:){0,5}:((b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b).){3}(b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b))|(::([0-9A-Fa-f]{1,4}:){0,5}((b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b).){3}(b((25[0-5])|(1d{2})|(2[0-4]d)|(d{1,2}))b))|([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})|(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:))') ifFalse: [ ^self signalInvalidStringAddressException: aStringIpAddress ]."
	
	^self new
		ip: addressToCheck;
		yourself	
]

{ #category : #'instance creation' }
OCNIpv6Address class >> signalInvalidStringAddressException: aStringIpAddress [
	OCNInvalidIpStringAddressError new
		invalidStringAddress:  aStringIpAddress ;
		signal
	
]

{ #category : #printing }
OCNIpv6Address >> ipString [ 
	^self ip
]

{ #category : #testing }
OCNIpv6Address >> isIpv6 [

	^true
]
