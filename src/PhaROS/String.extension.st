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
