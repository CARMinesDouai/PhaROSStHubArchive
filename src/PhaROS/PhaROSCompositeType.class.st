Class {
	#name : #PhaROSCompositeType,
	#superclass : #PhaROSType,
	#instVars : [
		'typeName',
		'typeDefinition',
		'relatedClass'
	],
	#classInstVars : [
		'types'
	],
	#category : #'PhaROS-Kernel-Types'
}

{ #category : #construction }
PhaROSCompositeType class >> initialize [ 
	types := Dictionary new.
]

{ #category : #construction }
PhaROSCompositeType class >> named: aByteString [
	self flag: #whatMustIDoInThisCase.
	types at:aByteString asSymbol ifPresent:[ :p | ^ p ].
	
	^ types at: aByteString asSymbol put:  (super new typeName: aByteString ; yourself).
]

{ #category : #construction }
PhaROSCompositeType class >> named: aByteString definedBy: anArray [ 
	^ (self named: aByteString) useTypeDefinition:  anArray ; yourself.
]

{ #category : #construction }
PhaROSCompositeType class >> new [
	self error: 'You must use at least #named: construction method'.
]

{ #category : #construction }
PhaROSCompositeType class >> newInstanceOf: aName [
	^ (types at: aName) newInstance.
	
]

{ #category : #construction }
PhaROSCompositeType class >> remove: aName [
	types at:aName ifPresent: [
		:type |
		type erase.
		types removeKey: aName.
	]
	
]

{ #category : #construction }
PhaROSCompositeType class >> reset [
	self initialize.
]

{ #category : #serializing }
PhaROSCompositeType >> asArrayType [
	^ PhaROSArrayType of: self relatedClass. 
]

{ #category : #serializing }
PhaROSCompositeType >> buildRelatedClass [
	| class|
	
	
	Smalltalk at:(self relatedClassName asSymbol) ifPresent:[
		:cl |
		^ cl.	
	].
	
	
	self doItSilently: [
		class := self createClass.
		
		self installMethodsIn: class.
	].


	^ class  .







]

{ #category : #serializing }
PhaROSCompositeType >> createAnonymousClass [
		((ClassBuilder new)
					name: self typeName asSymbol
					inEnvironment: (SystemDictionary withOrganizer: (SystemOrganizer new))
					subclassOf: PhaROSValue
					type: PhaROSValue typeOfClass
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					category: 'really-dont-care')  setTraitComposition: {} asTraitComposition ; yourself.
]

{ #category : #serializing }
PhaROSCompositeType >> createClass [

	^ PhaROSValue subclass: self relatedClassName asSymbol
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PhaROSGenerated'.
	
	
]

{ #category : #serializing }
PhaROSCompositeType >> dataTypeSize [
	"beware of recursive structures!"
	
	^ typeDefinition values inject:0 into:[ :acc :t | acc + t dataTypeSize ].
]

{ #category : #serializing }
PhaROSCompositeType >> dataTypeSizeFor: aValue [ 
	"beware of recursive structures!"
	| acc |
	acc := 0.
	
	typeDefinition keysAndValuesDo:[ :attributeName :type |
			acc := acc + (type dataTypeSizeFor: (aValue perform: attributeName asSymbol)).
	 ].

	^ acc.
]

{ #category : #serializing }
PhaROSCompositeType >> decode: aFLDecoder [ 
	| instance |
	instance := self relatedClass new.
	self typeDefinition keysAndValuesDo:  [ :name :type |
		instance at: name put: (type decode: aFLDecoder).
	].
	^ instance.
]

{ #category : #serializing }
PhaROSCompositeType >> defaultValueString [
	 ^ self relatedClassName, ' new'



]

{ #category : #serializing }
PhaROSCompositeType >> doItSilently: aBlock [
	aBlock value.

]

{ #category : #serializing }
PhaROSCompositeType >> erase [
	relatedClass ifNotNil:[
		relatedClass removeFromSystem
	].
]

{ #category : #'initialize-release' }
PhaROSCompositeType >> initialize [ 
	"attribute's name  => attribute's type"
	typeDefinition := OrderPreservingDictionary new.
]

{ #category : #serializing }
PhaROSCompositeType >> installMethodsIn: aClass [
	| init |
	init := OrderedCollection new.
	self typeDefinition keysAndValuesDo:  [
			:name :type |
			aClass compile: (('{1}' , String crlf, String tab, '^ self getAt: #{1}. ', String crlf) translated format: { name} ).
			aClass compile: (('{1}: aValue' , String crlf, String tab, '^ self at: #{1} put: aValue. ', String crlf ) translated format: { name } ).
			type isCollectionType ifTrue: [
				aClass compile: (('add{1}: aValue' , String crlf, String tab, '^ self {2} add: aValue. ', String crlf ) translated format: { (name capitalized copyFrom:1 to: name size -1 ) . name } ).
			].
			init add:( (String tab, ' self {1}: {2}. ', String crlf) translated format: { name . type defaultValueString }).
		].
		aClass compile: (init inject:'initialize', String crlf, String tab, 'super initialize.', String crlf into:[ :acc :line | acc, line ]).
]

{ #category : #serializing }
PhaROSCompositeType >> isAPossibleSize: aSize [
	^ aSize > 3.
]

{ #category : #serializing }
PhaROSCompositeType >> isAPossibleValue: aValue [
	^ aValue isBasic not.
]

{ #category : #serializing }
PhaROSCompositeType >> new [ 
	^ self.
]

{ #category : #serializing }
PhaROSCompositeType >> newInstance [ 
	^ self relatedClass new.
]

{ #category : #serializing }
PhaROSCompositeType >> relatedClass [
	^ relatedClass ifNil: [
			relatedClass := self buildRelatedClass.
	  ]
]

{ #category : #serializing }
PhaROSCompositeType >> relatedClassName [

	 ^ (self typeName copyReplaceAll: '/' with:'' ) capitalized 



]

{ #category : #serializing }
PhaROSCompositeType >> serialize:aValue into: aFLEncoder [ 

	^ self typeDefinition keysAndValuesDo:  [ :name :type |
		type serialize: (aValue getAt: name) into: aFLEncoder.
	].
	

]

{ #category : #'as yet unclassified' }
PhaROSCompositeType >> setEncodeDecodeSelectors [ 
	
]

{ #category : #serializing }
PhaROSCompositeType >> typeDefinition [ 
	^typeDefinition 
]

{ #category : #serializing }
PhaROSCompositeType >> typeName [ 
	^typeName.
]

{ #category : #serializing }
PhaROSCompositeType >> typeName: aTypeName [
	typeName := aTypeName.
]

{ #category : #'initialize-release' }
PhaROSCompositeType >> useTypeDefinition: anArray [
	anArray do: [ :assoc |
		typeDefinition at: assoc key put: assoc value.
	]
	
]
