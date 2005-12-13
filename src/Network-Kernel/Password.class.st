"
""Hold a password.  There are three ways to get the password.

If there is no password (sequence == nil), ask the user for it.

If the use supplied one during this session, return that.  It is cleared at shutDown.

If sequence is a number, get the server passwords off the disk.  File 'sqk.info' must be in the same folder 'Squeak.sources' file.  Decode the file.  Return the password indexed by sequence.""
"
Class {
	#name : #Password,
	#superclass : #Object,
	#instVars : [
		'cache',
		'sequence'
	],
	#category : #'Network-Kernel'
}

{ #category : #'as yet unclassified' }
Password class >> shutDown [
	"Forget all cached passwords, so they won't stay in the image"

	self allSubInstancesDo: [:each | each cache: nil].
]

{ #category : #accessing }
Password >> cache: anObject [
	cache _ anObject
]

{ #category : #'as yet unclassified' }
Password >> decode: string [
	"Xor with secret number -- just so file won't have raw password in it"
	| kk rand |
	rand _ Random new seed: 234237.
	kk _ (ByteArray new: string size) collect: [:bb | (rand next * 255) asInteger].
	1 to: kk size do: [:ii |
		kk at: ii put: ((kk at: ii) bitXor: (string at: ii) asciiValue)].
	^ kk asString
]

{ #category : #accessing }
Password >> passwordFor: serverDir [
	"Returned the password from one of many sources.  OK if send in a nil arg."

	| sp msg |
	cache ifNotNil: [^ cache].
	sequence ifNotNil: [
		(sp _ self serverPasswords) ifNotNil: [
			sequence <= sp size ifTrue: [^ sp at: sequence]]].
	msg _ serverDir isRemoteDirectory
		ifTrue: [serverDir moniker]
		ifFalse: ['this directory'].
	(serverDir user = 'anonymous') & (serverDir typeWithDefault == #ftp) ifTrue: [
			^ cache _ FillInTheBlank request: 'Please let this anonymous ftp\server know your email address.\This is the polite thing to do.' withCRs
			initialAnswer: 'yourName@company.com'].

	^ cache _ FillInTheBlank requestPassword: 'Password for ', serverDir user, ' at ', msg, ':'.
		"Diff between empty string and abort?"
]

{ #category : #accessing }
Password >> sequence [
	^sequence
]

{ #category : #accessing }
Password >> sequence: anNumber [
	sequence _ anNumber
]

{ #category : #'as yet unclassified' }
Password >> serverPasswords [
	"Get the server passwords off the disk and decode them. The file 'sqk.info' must be in some folder that Squeak thinks is special (vm folder, or default directory).  (Note: This code works even if you are running with no system sources file.)"

	| sfile |
	(sfile _ FileDirectory lookInUsualPlaces: 'sqk.info') ifNil: [^ nil].
		"If not there, Caller will ask user for password"
		"If you don't have this file, and you really do want to release an update, 
		 contact Ted Kaehler."
	^ (self decode: (sfile contentsOfEntireFile)) findTokens: String cr

]
