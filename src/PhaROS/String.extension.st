Extension { #name : #String }

{ #category : #'*PhaROS' }
String class >> constant: aName value: aValue [  
	
	^ PhaROSStringType constant: aName value: aValue  
]

{ #category : #'*PhaROS' }
String >> evaluateExpression: aByteString [ 
	self class compile:  'DoIt ^', aByteString.
	^ self DoIt
]

{ #category : #'*PhaROS' }
String class >> forPhaROSTyping [
		^ PhaROSStringType 
]

{ #category : #'*PhaROS' }
String >> format [
	"format the receiver with aCollection  
	 
	simplest example:  
	'foo {1} bar' format: {Date today}.
	 
	complete example:  
	'\{ \} \\ foo {1} bar {2}' format: {12. 'string'}.  
	"
	| result stream |
	result := String new writeStream.
	stream := self readStream.

	[stream atEnd]
		whileFalse: [| currentChar | 
			currentChar := stream next.
			currentChar == ${
				ifTrue: [| expression | 
					expression := self getEnclosedExpressionFrom: stream.
					result
						nextPutAll: (self evaluateExpression: expression)]
				ifFalse: [
					currentChar == $\
						ifTrue: [stream atEnd
								ifFalse: [result nextPut: stream next]]
						ifFalse: [result nextPut: currentChar]]].

	^ result contents
]

{ #category : #'*PhaROS' }
String >> isValidROSName [
	"Checks if is a valid ROS name for a topic, a node or parameter 
http://wiki.ros.org/Names | http://www.cse.sc.edu/~jokane/agitr/agitr-letter-names.pdf
This implementation does not care about private names (those which starts with ~)-
 
Not valid:  'kompai1/scan' isValidROSName 
Not valid:  '/kompai1/1scan' isValidROSName
Not valid:  '/kompai1/scan$' isValidROSName
Valid: '/kompai1/scan' isValidROSName
"

	| containsJustAlphaNumericOrUnderscore names |
	containsJustAlphaNumericOrUnderscore := [ :str | (str reject: [ :ch | ch isAlphaNumeric or: [ ch = $_ ] ]) isEmpty ].	
	" First character should be '/' "
	self first = $/.	
	" Then, all names should start with a letter and then just alphanumerics or underscore are allowed  "
	names := ($/ split: self) reject: #isEmpty.
	^ (names
		reject: [ :name | 
			name first isLetter
				and: [ 
					name size > 1
						ifTrue: [ containsJustAlphaNumericOrUnderscore value: (name copyFrom: 2 to: name size) ] ] ]) isEmpty
]

{ #category : #'*PhaROS' }
String class >> named: aName [ 
	"This extention method is related wih PhaROS-Types-DSL package. Is for type definition from image side "
	^PhaROSStringType named: aName
]

{ #category : #'*PhaROS' }
String >> normalizeFrame [
	
	^ (self at: 1 ) = $/ ifTrue: [
		self copyFrom: 2 to: self size.	
	   ] ifFalse: [
		self.
	   ].
	
]

{ #category : #'*PhaROS' }
String >> normalizeParameterName [
		| normalizedName  |
	normalizedName := self.
	
	normalizedName first = $/ ifFalse: [ 
		normalizedName := '/', normalizedName.
	].
	normalizedName last = $/ ifFalse: [ 
		normalizedName := normalizedName, '/'.	
	 ].
	[ (normalizedName indexOf:'//') = 0] whileFalse: [ normalizedName := normalizedName copyReplaceAll: '//' with: '/'  ].

	^ normalizedName.
]

{ #category : #'*PhaROS' }
String class >> parameterClass [
	^ String
]
