"
.Singleton object in charge of browsing definition of types in ros world. Based on PhaROSSystemLauncher, it executes a rosmsg command, interpret it and generate a definition or a type (#definition: #type:). Also works with services types with #serviceDefinition: #serviceType:

It has inside also a map that caches the definitions of definitions. 
"
Class {
	#name : #PhaROSTypeBrowser,
	#superclass : #Object,
	#instVars : [
		'browse'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'PhaROS-Util'
}

{ #category : #'as yet unclassified' }
PhaROSTypeBrowser class >> instance [
	^ instance ifNil: [
		instance := super new.	
		instance fillWithExistingGeneratedTypeClasses
		"instance register: 
					(PhaROSType composite: {
						#loggers -> (PhaROSArrayType of: (PhaROSTypeBrowser instance definition: 'roscpp/Logger') ).
					} named: 'roscpp/GetLoggersResponse' withConstants:{})
				at: 'roscpp/GetLoggersResponse'. 
	
		instance register: 
					(PhaROSType composite: {
					} named: 'roscpp/GetLoggersRequest' withConstants:{})
				at: 'roscpp/GetLoggersRequest'. 
		instance register: 
					(PhaROSType composite: {
					} named: 'std_srvs/EmptyRequest' withConstants:{})
				at: 'std_srvs/EmptyRequest'. 
		instance register: 
					(PhaROSType composite: {
					} named: 'std_srvs/EmptyResponse' withConstants:{})
				at: 'std_srvs/EmptyResponse'. "
	].
]

{ #category : #'as yet unclassified' }
PhaROSTypeBrowser class >> new [
	self error: 'Use instance!'.
]

{ #category : #'as yet unclassified' }
PhaROSTypeBrowser class >> reset [
	instance := nil.
	PhaROSCompositeType reset.
]

{ #category : #browsing }
PhaROSTypeBrowser >> browseAll [
	| stdout |
	
	stdout :=  FileStream stdout
			wantsLineEndConversion: true;
			converter; "Force lazy initialization of converter"
			yourself.

	(String lf split: (PhaROSSystemLauncher instance rosMsg:'list'))  do: [ :typeId | 
		typeId ~= '' ifTrue:[
			stdout nextPutAll: typeId, String crlf .
			(PhaROSTypeBrowser instance type: typeId) md5Sum ]].
]

{ #category : #accessing }
PhaROSTypeBrowser >> browser [
	^ browse.
]

{ #category : #definition }
PhaROSTypeBrowser >> definition: aTypeId [

	| firstLevel |

	(aTypeId isNil or: [ aTypeId isEmpty ]) ifTrue: [ PhaROSTypeError signal: 'Type error' ].
	
	^ (self browser at: aTypeId ifAbsentPut: [
	
			firstLevel := (Character lf split:( PhaROSSystemLauncher instance rosMsgShow: aTypeId ) ) select: [ :str | (str beginsWith: ' ') not & (str size > 3) ] .
						
			self typeNamed: aTypeId for: firstLevel

		]) 


]

{ #category : #private }
PhaROSTypeBrowser >> fillWithExistingGeneratedTypeClasses [
	
	| existingTypeClasses processLater count |
		
	"we miss classes if we restrict on the Generated RPackage"
	"[ existingTypeClasses := (RPackageOrganizer default  packageNamed: 'PhaROSGenerated') classes ] on: KeyNotFound do: [ :e | ^ self ]."
	
	existingTypeClasses := PhaROSValue allSubclasses select: [ :c | c respondsTo: #rosTypeName ].
	processLater := OrderedCollection new.
	count := 1.
	
	[ existingTypeClasses notEmpty and: [count < 5] ] whileTrue: [
		|aTypeClass aTypeId|
		aTypeClass := existingTypeClasses removeFirst.
		aTypeId := aTypeClass rosTypeName.
		
		[  
			self browser at: aTypeId ifAbsentPut: [
				|firstLevel newMessageType newType|
				firstLevel := (Character cr split: aTypeClass rosTypeDefinition) select: [ :str | str trim size > 3 ] thenCollect: [:each | each trim].
	
				newMessageType := self typeNamed: aTypeId for: firstLevel.
				newType := newMessageType build.
				newType md5Sum: aTypeClass rosMd5Sum.
				newMessageType
			]	
		] on: Error do: [ :e | 
			"we cannot add this type because it probably depends on other types not build yet"
			existingTypeClasses add: aTypeClass ].
		
		existingTypeClasses ifEmpty: [ 
			existingTypeClasses := processLater.
			processLater := OrderedCollection new.
			count := count + 1 ]
	]
	
]

{ #category : #'initialize-release' }
PhaROSTypeBrowser >> initialize [ 

	browse := Dictionary new.
	
	browse at: 'byte' put: (PhaROSBasicTypeBuilder for:  PhaROSInt8Type new).
	browse at: 'char' put: (PhaROSBasicTypeBuilder for:  PhaROSInt8Type new).
	browse at: 'bool' put: (PhaROSBasicTypeBuilder for:  PhaROSBoolType new).
	browse at: 'float32' put: (PhaROSBasicTypeBuilder for:  PhaROSFloat32Type new).
	browse at: 'float64' put: (PhaROSBasicTypeBuilder for:  PhaROSFloat64Type new).
	
	browse at: 'int8' put: (PhaROSBasicTypeBuilder for:  PhaROSInt8Type new).
	browse at: 'int16' put: (PhaROSBasicTypeBuilder for:  PhaROSInt16Type new).
	browse at: 'int32' put: (PhaROSBasicTypeBuilder for:  PhaROSInt32Type new).
	browse at: 'int64' put: (PhaROSBasicTypeBuilder for:  PhaROSInt64Type new).
	
	browse at: 'uint8' put: (PhaROSBasicTypeBuilder for:  PhaROSUInt8Type new).
	browse at: 'uint16' put: (PhaROSBasicTypeBuilder for:  PhaROSUInt16Type new).
	browse at: 'uint32' put: (PhaROSBasicTypeBuilder for:  PhaROSUInt32Type new).
	browse at: 'uint64' put: (PhaROSBasicTypeBuilder for:  PhaROSUInt64Type new).
	
	browse at: 'time' put: (PhaROSBasicTypeBuilder for:  PhaROSTimeType new).
	browse at: 'duration' put: (PhaROSBasicTypeBuilder for:  PhaROSDurationType new).
	browse at: 'string' put: (PhaROSBasicTypeBuilder for:  PhaROSStringType new).
	
	

	









]

{ #category : #calling }
PhaROSTypeBrowser >> md5Sum: aTypeId [
	| md5 |
	md5 := PhaROSSystemLauncher instance rosMsgMd5: aTypeId. 
	" put the \n character away "
	^ md5 = '' ifTrue: [ md5 ] ifFalse: [ md5 copyFrom: 1 to: md5 size -1 ].
	
]

{ #category : #private }
PhaROSTypeBrowser >> register: aType at: aName [
	browse at:aName put: aType.
]

{ #category : #definition }
PhaROSTypeBrowser >> serviceDefinition: aTypeId [

	
	^ (self browser at: aTypeId ifAbsentPut: [
			| code instructions request response type |
			
			code :=  '---' split: (PhaROSSystemLauncher instance rosSrvShow: aTypeId).
			
			instructions := (Character lf split:( code at:1 ) ) select: [ :str | (str beginsWith: ' ') not & (str size > 3) ] .
			request := self typeNamed:( '{1}Request' format:{ aTypeId} )for: (instructions).
			
			
			instructions := (Character lf split:( code at:2 ) ) select: [ :str | (str beginsWith: ' ') not & (str size > 3) ] .
			response := self typeNamed:( '{1}Response' format:{ aTypeId} )for: (instructions).
			
			
			PhaROSServiceTypeBuilder named: aTypeId  request: request response: response.
		]) 


]

{ #category : #type }
PhaROSTypeBrowser >> serviceType: aTypeId [
	^ (self serviceDefinition: aTypeId) build
]

{ #category : #type }
PhaROSTypeBrowser >> type: aTypeId [
	^ (self definition: aTypeId) build
]

{ #category : #private }
PhaROSTypeBrowser >> typeNamed: aTypeId for: firstLevel [ 
	
	^ PhaROSROSType message named: aTypeId defined: (
			firstLevel collect: [ : f | PhaROSMessageTypeBuilder parseRosLine: f typePool: self ]
	).
	
	
]
