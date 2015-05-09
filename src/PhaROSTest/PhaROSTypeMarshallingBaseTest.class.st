Class {
	#name : #PhaROSTypeMarshallingBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'validValues',
		'invalidValues'
	],
	#category : #'PhaROSTest-Types'
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

{ #category : #'tests - support' }
PhaROSTypeMarshallingBaseTest >> baseFailSerialize [

	invalidValues do: [
			:val |
		
			self should:[val dump ]  raise: PhaROSUnexpextedValue.
		].
	
]

{ #category : #'tests - support' }
PhaROSTypeMarshallingBaseTest >> baseSerialize [
		validValues do: [
			:val |
			self assert: val key dump = val value.
			self assert: val key dump size = ((val key type dataTypeSizeFor: val key value) + 4).
		].
	
]

{ #category : #'tests - support' }
PhaROSTypeMarshallingBaseTest >> baseUnserialize [

	validValues do: [
		:val |
		self assert: ((self newTestedClassInstance newPacket load: val value ) value closeTo: val key value).
	].
	


	
	
		
]

{ #category : #'tests - support' }
PhaROSTypeMarshallingBaseTest >> baseUnserializeFail [
	
	self invalidByteArrays do: [
		:val |
		self should: [(self newTestedClassInstance newPacket load: val  )] raise: PhaROSUnexpextedValue.
	].
	
]

{ #category : #accessing }
PhaROSTypeMarshallingBaseTest >> expectedSize [
	^ self relatedClass dataTypeSize.
]

{ #category : #'tests - parametrization' }
PhaROSTypeMarshallingBaseTest >> invalidByteArrays [
	self subclassResponsibility.
]

{ #category : #'tests - parametrization' }
PhaROSTypeMarshallingBaseTest >> invalidValues [ 
	self subclassResponsibility.
]

{ #category : #accessing }
PhaROSTypeMarshallingBaseTest >> newTestedClassInstance [
	^ self relatedClass new.
]

{ #category : #'tests - parametrization' }
PhaROSTypeMarshallingBaseTest >> relatedClass [
	^ self subclassResponsibility.
]

{ #category : #running }
PhaROSTypeMarshallingBaseTest >> setUp [
	super setUp.
	PhaROSTimestamp initialize.
	
	validValues := self validValues collect: [ :assoc |
		(self newTestedClassInstance newPacket value: assoc key; yourself  )-> assoc value.
	].

	invalidValues := self invalidValues collect: [ :value |
		self newTestedClassInstance newPacket value: value ; yourself.
	].
	
	

	








]

{ #category : #'tests - parametrization' }
PhaROSTypeMarshallingBaseTest >> validValues [ 
	self subclassResponsibility.
]
