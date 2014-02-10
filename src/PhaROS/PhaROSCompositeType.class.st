Class {
	#name : #PhaROSCompositeType,
	#superclass : #PhaROSType,
	#instVars : [
		'typeName',
		'typeDefinition',
		'relatedClass',
		'md5Sum',
		'constants'
	],
	#classInstVars : [
		'types'
	],
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSCompositeType class >> definedBy: aROSTypeId named: aName [ 
	 ^ PhaROSFieldDefinition named: aName type: (PhaROSTypeBrowser instance type: aROSTypeId ).
]

{ #category : #construction }
PhaROSCompositeType class >> initialize [ 
	super initialize.
	types := Dictionary new.
]

{ #category : #construction }
PhaROSCompositeType class >> named: aByteString [
	self flag: #whatMustIDoInThisCase.
	types at:aByteString asSymbol ifPresent:[ :p | ^ p ].
	
	^ types at: aByteString asSymbol put:  (super new typeName: aByteString ; yourself).
]

{ #category : #construction }
PhaROSCompositeType class >> named: aByteString definedBy: anArray withConstants: aConstantsArray. [
	^ (self named: aByteString) useTypeDefinition:  anArray ; useConstants: aConstantsArray yourself.
]

{ #category : #construction }
PhaROSCompositeType class >> new [
	self error: 'You must use at least #named: construction method'.
]

{ #category : #'pseudo-dsl' }
PhaROSCompositeType class >> registerAlterName [ 
	"Do not apply"
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
PhaROSCompositeType >> constants [ 
	^ constants ifNil: [ constants := Dictionary new ].
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
	 ^ relatedClass name , ' new'



]

{ #category : #deploying }
PhaROSCompositeType >> dependencies [ 

	| return packageName packageNameType |
	
	"
		dependencies are related with the package owner of each type. 
		The dependencies exists if the type related with the type is package type (std_msg/Int32 by example.) but no the basic types as Int32 it self. Check more in the type definition in the documentation of ROS
		
		int32 val
		std_msgs/Header
		
		int this case, int32 does not imply any dependency, but Header indeed it mean it. 
	"
	
	return := Set new.
	packageName := (( '/' split: self typeName ) at: 1).
	
	typeDefinition keysAndValuesDo: [:k :v | 
		 packageNameType := ( '/' split: v typeName ) .
		packageNameType size > 1 ifTrue: [
			packageNameType := packageNameType at:1 .
			packageNameType = packageName ifFalse: [
				return add: packageNameType.
		 	].		
		]
	].
	^ return.

]

{ #category : #serializing }
PhaROSCompositeType >> doItSilently: aBlock [
	aBlock value.

]

{ #category : #'initialize-release' }
PhaROSCompositeType >> initialize [ 
	"attribute's name  => attribute's type"
	typeDefinition := OrderPreservingDictionary new.
	constants := Dictionary new.
]

{ #category : #serializing }
PhaROSCompositeType >> isAPossibleSize: aSize [
	^ true.
]

{ #category : #serializing }
PhaROSCompositeType >> isAPossibleValue: aValue [
	^ aValue isBasic not.
]

{ #category : #'as yet unclassified' }
PhaROSCompositeType >> isZeroSized [
	^ typeDefinition size = 0
]

{ #category : #serializing }
PhaROSCompositeType >> md5Sum [ 

	md5Sum ifNil: [
		md5Sum:= PhaROSTypeBrowser instance md5Sum: typeName.
	].
	^ md5Sum
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
	^ relatedClass
]

{ #category : #serializing }
PhaROSCompositeType >> relatedClass: aClass [
	relatedClass := aClass.
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
PhaROSCompositeType >> useConstants: aConstantsArray [ 
	aConstantsArray do: [ : constant |
		self constants at: constant name put: constant value.
	]
	
]

{ #category : #'initialize-release' }
PhaROSCompositeType >> useTypeDefinition: anArrayOfFields [
	anArrayOfFields do: [ : field |
		
		typeDefinition at: field name put: field type.
	]
	
]
