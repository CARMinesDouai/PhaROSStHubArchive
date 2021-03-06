"
PhaROSMessageTypeBuilder  named: #blaa package: #ble defined: { 
		UInt8 named: #bla .
		String named: #sarasa .
		FixedArray named: #lala sized: 30 ofType: UInt16.
		ROSType definedBy: 'std_msgs/Header' named: #header.
	}.

Is in charge of generating Ros definition of a type, Pharo definition of the type, and generate the related class in pharo. 
"
Class {
	#name : #PhaROSMessageTypeBuilder,
	#superclass : #Object,
	#instVars : [
		'name',
		'definition',
		'package'
	],
	#classVars : [
		'TypeCreationOrder'
	],
	#category : #'PhaROS-Types-DSL'
}

{ #category : #'instance creation' }
PhaROSMessageTypeBuilder class >> named: aTypeName  defined: aDefinition [
	| packageTypeName |
	
	packageTypeName := '/' split: aTypeName.
	
	^self named: (packageTypeName at:2) package: (packageTypeName at:1) defined: aDefinition.
]

{ #category : #'instance creation' }
PhaROSMessageTypeBuilder class >> named: aTypeName package: aPackageName defined: aDefinition [

	^ self new  name: aTypeName; 
				package: aPackageName; 
				definition: (PhaROSTypeDefinition for: aDefinition) ; 
				yourself.
]

{ #category : #'type parsing' }
PhaROSMessageTypeBuilder class >> parseRosLine: aLine typePool: aTypePool [
	
	^ (aLine indexOf: $=) = 0 ifTrue: [ 
		PhaROSFieldDefinition parseRosLine: aLine typePool: aTypePool
	 ] ifFalse: [ 
		PhaROSConstantDefinition parseRosLine: aLine typePool: aTypePool.
	 ]
]

{ #category : #building }
PhaROSMessageTypeBuilder >> build [
	^ (PhaROSCompositeType 	named: package, '/', name 
								definedBy: definition fields
								withConstants: definition constants) relatedClass: self relatedClass; yourself.
]

{ #category : #'related class building' }
PhaROSMessageTypeBuilder >> buildClass [
	| class |
		class :=  PhaROSValue subclass: self classname asSymbol
					instanceVariableNames: ''
					classVariableNames: ''
					poolDictionaries: ''
					category: 'PhaROSGenerated'.
		
		self installMethodsIn: class.
		self installConstantsIn: class.
		^ class
]

{ #category : #'related class building' }
PhaROSMessageTypeBuilder >> classname [
	 ^ (package, name)  capitalized 



]

{ #category : #accessing }
PhaROSMessageTypeBuilder >> definition [
	^ definition
]

{ #category : #accessing }
PhaROSMessageTypeBuilder >> definition: anArrayOfAssociations [
	definition := anArrayOfAssociations
]

{ #category : #dependencies }
PhaROSMessageTypeBuilder >> dependencies [
	^ self build dependencies.
]

{ #category : #proto }
PhaROSMessageTypeBuilder >> forPhaROSTyping [
	^ self build
]

{ #category : #'related class building' }
PhaROSMessageTypeBuilder >> initTypeCreationOrder [
	TypeCreationOrder := (PhaROSValue allSubclasses 
		select: [ :typeClass | typeClass respondsTo: #typeCreationOrder ]
		thenCollect: [ :each | each typeCreationOrder ]) max
		
]

{ #category : #'related class building' }
PhaROSMessageTypeBuilder >> installConstantsIn: aClass [
	
	self definition constants do: [ :constant |
		aClass class compile: constant classAccessor .
	].
]

{ #category : #'related class building' }
PhaROSMessageTypeBuilder >> installMethodsIn: aClass [

	self definition fields do: [ : field | 
		aClass compile: field setter.
		aClass compile: field getter.
		field hasToInstallHelper ifTrue: [ 
			aClass compile: field helper.
		].
	 ].
	
	aClass compile: ((self definition fields collect: #initializer) inject: 'initialize', String crlf, String tab, 'super initialize.', String crlf into:[ :acc :line | acc, line ]).
	
	"save ros definitions on class-side too"
	aClass class compile: 'rosTypeName ', String lf, '^', self name printString.
	aClass class compile: 'rosTypeDefinition ', String lf, '^', self rosdefinition printString.	
	aClass class compile: 'rosMd5Sum ', String lf, '^', (PhaROSTypeBrowser instance md5Sum: self name) printString.
	aClass class compile: 'typeCreationOrder ', String lf, '^', self typeCreationOrder asString
		
]

{ #category : #proto }
PhaROSMessageTypeBuilder >> isServiceType [
	^ false
]

{ #category : #accessing }
PhaROSMessageTypeBuilder >> name [
	^ package asString, '/', name asString.
]

{ #category : #accessing }
PhaROSMessageTypeBuilder >> name: aTypeName [
	name := aTypeName
]

{ #category : #accessing }
PhaROSMessageTypeBuilder >> package: aPackageName [
	package := aPackageName
]

{ #category : #building }
PhaROSMessageTypeBuilder >> relatedClass [
	^ Smalltalk at:(self classname asSymbol) ifAbsent: [ 
		self buildClass.	
	 ] 
	
]

{ #category : #converting }
PhaROSMessageTypeBuilder >> rosdefinition [
	^ definition rosdefinition.
]

{ #category : #accessing }
PhaROSMessageTypeBuilder >> shortName [
	^ name
]

{ #category : #'related class building' }
PhaROSMessageTypeBuilder >> typeCreationOrder [
	TypeCreationOrder ifNil: [ self initTypeCreationOrder ].
	TypeCreationOrder := TypeCreationOrder + 1.
	^ TypeCreationOrder
]
