Class {
	#name : #PhaROSTypeMarshallingBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'validValues',
		'invalidValues'
	],
	#category : #'PhaROS-Types-Test'
}

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest class >> writeTestIfNeed: aSelector [
 | testSelector callSelector | 

	testSelector := 'test', aSelector asString capitalized.
	callSelector := 'base', aSelector asString capitalized.
	
	
	self methodDict at: aSelector ifAbsent: [
		self compile:( '
			{1}
				^ super {2}.
		' translated format: { testSelector . callSelector }).
	].
	"PhaROSTypeMarshallingBaseTest allSubclasses do: #initialize."
	
]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> baseFailSerialize [

	invalidValues do: [
			:val |
		
			self should:[val dump ]  raise: PhaROSUnexpextedValue.
		].
	
]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> baseSerialize [
		validValues do: [
			:val |
			self assert: val key dump = val value.
			self assert: val key dump size = ((val key type dataTypeSizeFor: val key value) + 4).
		].
	
]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> baseUnserialize [

	validValues do: [
		:val |
		self assert: ((self newTestedClassInstance newPacket load: val value ) value closeTo: val key value).
	].
	


	
	
		
]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> baseUnserializeFail [
	
	self invalidByteArrays do: [
		:val |
		self should: [(self newTestedClassInstance newPacket load: val  )] raise: PhaROSUnexpextedValue.
	].
	
]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> expectedLenght [
	self subclassResponsibility.
]

{ #category : #accessing }
PhaROSTypeMarshallingBaseTest >> expectedSize [
	^ self relatedClass dataTypeSize.
]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> invalidByteArrays [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> invalidValues [ 
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> newTestedClassInstance [
	^ self relatedClass new.
]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> relatedClass [
	^ self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> setUp [
	super setUp.
	PhaROSTimestamp initialize.
	

	validValues := self validValues collect: [
		:assoc |
		(self newTestedClassInstance newPacket value: assoc key; yourself  )-> assoc value.
	].

	invalidValues := self invalidValues collect: [
		:value |
		self newTestedClassInstance newPacket value: value ; yourself.
	].
	
	

	








]

{ #category : #'as yet unclassified' }
PhaROSTypeMarshallingBaseTest >> validValues [ 
	self subclassResponsibility.
]
