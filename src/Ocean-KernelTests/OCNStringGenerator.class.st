Class {
	#name : #OCNStringGenerator,
	#superclass : #Object,
	#instVars : [
		'randomStringSize',
		'dataToSend'
	],
	#classVars : [
		'randomStringsDict'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Ocean-KernelTests-Support'
}

{ #category : #'as yet unclassified' }
OCNStringGenerator class >> default [ 
	^default ifNil: [ default := self new]
]

{ #category : #'as yet unclassified' }
OCNStringGenerator class >> initialize [ 
	randomStringsDict := Dictionary new
]

{ #category : #'as yet unclassified' }
OCNStringGenerator class >> randomStringOfSize: size [
	^self default randomStringOfSize: size
]

{ #category : #'as yet unclassified' }
OCNStringGenerator >> createRandomString [

	| fileStream randomString shorterSize sizeToGenerate sizeAlreadyExisting existingString index |
	
	sizeToGenerate := self randomStringSize.
	
	randomStringsDict isEmpty ifTrue: [ | sizeToReadFromFile|
		sizeToReadFromFile := sizeToGenerate min: 2000.
		"retrieve random string from source file"
		fileStream := (StandardFileStream readOnlyFileNamed: Smalltalk changesName).
		[ randomString := (fileStream next: sizeToReadFromFile) ] ensure: [ fileStream close].	
		
		"replace non-ascii characters"
		randomString withIndexDo: [ :v :i | ((randomString at: i) asciiValue > 127) ifTrue: [ randomString at: i put: $a ] ].
		randomStringsDict at: sizeToReadFromFile put: randomString
	].
	
	randomStringsDict 
		at: sizeToGenerate 
		ifPresent: [:value| self dataToSend: value. ^self].
			
	sizeAlreadyExisting := randomStringsDict keys max.
	existingString := randomStringsDict at: sizeAlreadyExisting.
		
	randomString := ByteString new: sizeToGenerate.
	index := 0.
			
	 [ index < sizeToGenerate ] whileTrue: [ |sizeToCopy|
		sizeToCopy := sizeToGenerate - index.
		sizeToCopy := sizeToCopy min: sizeAlreadyExisting.
			
		randomString replaceFrom: index + 1
			to: index + sizeToCopy
			with: existingString
			startingAt: 1.
		index := index + sizeToCopy.
	].
		
	self dataToSend: randomString.
	randomStringsDict at: sizeToGenerate put: randomString

]

{ #category : #'as yet unclassified' }
OCNStringGenerator >> dataToSend [
	^ dataToSend
]

{ #category : #'as yet unclassified' }
OCNStringGenerator >> dataToSend: anObject [
	^ dataToSend := anObject
]

{ #category : #'as yet unclassified' }
OCNStringGenerator >> randomStringOfSize: dataSize [
	self randomStringSize: dataSize.
	self createRandomString.
	^self dataToSend
]

{ #category : #'as yet unclassified' }
OCNStringGenerator >> randomStringSize [
	^randomStringSize ifNil: [randomStringSize := 10000000]
]

{ #category : #'as yet unclassified' }
OCNStringGenerator >> randomStringSize: anObject [
	^ randomStringSize := anObject
]
