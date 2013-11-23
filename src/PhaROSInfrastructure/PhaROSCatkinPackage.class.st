Class {
	#name : #PhaROSCatkinPackage,
	#superclass : #Object,
	#instVars : [
		'location',
		'package',
		'rosDependancies',
		'cmake',
		'xml'
	],
	#classInstVars : [
		'locations'
	],
	#category : #'PhaROSInfrastructure-CatkinPackage'
}

{ #category : #'as yet unclassified' }
PhaROSCatkinPackage class >> generatesMessagesDependancies [
	^{ #roscpp . #rospy . #std_msgs . #geometry_msgs . #message_generation . #message_runtime }
]

{ #category : #'as yet unclassified' }
PhaROSCatkinPackage class >> initialize [
	locations := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSCatkinPackage class >> install: aPackage in: aLocation [
	^ self install: aPackage in: aLocation dependingOn: {}.
]

{ #category : #'as yet unclassified' }
PhaROSCatkinPackage class >> install: aPackage in: aLocation dependingOn: aCollectionOfROSDependancies [
	| instance |
	(self respondsTo: ('create{1} ' format: { aPackage name }) )ifTrue: [ 
		instance := self perform: ('create{1} ' format: { aPackage name }) asSymbol.
	 ] ifFalse: [ 
		instance := self new pharosPackage: aPackage; rosDependencies: aCollectionOfROSDependancies; yourself.
	 ].

	^instance location: aLocation;  install; yourself.
]

{ #category : #path }
PhaROSCatkinPackage >> bin [
	^ self path ,'/bin'
]

{ #category : #path }
PhaROSCatkinPackage >> build [
	^ self path ,'/build'
]

{ #category : #path }
PhaROSCatkinPackage >> cMakeList [

	^ self path, '/CMakeLists.txt' 
]

{ #category : #path }
PhaROSCatkinPackage >> changes [
	^ self path ,'/image/Pharo.changes'
]

{ #category : #abstract }
PhaROSCatkinPackage >> cmake [
	^ cmake
]

{ #category : #abstract }
PhaROSCatkinPackage >> cmake: aCMakeDefinition [
	cmake := aCMakeDefinition.
]

{ #category : #abstract }
PhaROSCatkinPackage >> deployType: aType definedAs: aTypeDefinition [
	^ PhaROSSystemLauncher instance deployType: aType definedAs: aTypeDefinition at: self.
]

{ #category : #abstract }
PhaROSCatkinPackage >> encodeCMAKE [
	| file |
	file := StandardFileStream readOnlyFileNamed: self cMakeList.
	
	self class compile: ('cmake{1}
		^ ''{2} ''
	' format: { package name . (file upToEnd copyReplaceAll: '''' with: '"')} ).
	
	file close.
	^ 'cmake{1}' format: { package name }.
	
	
]

{ #category : #abstract }
PhaROSCatkinPackage >> encodeFiles [
	self encodeXML.
	self encodeCMAKE.
]

{ #category : #abstract }
PhaROSCatkinPackage >> encodeXML [
	| file |

	file := StandardFileStream readOnlyFileNamed: self packageXML.
	
	self class compile: (' xml{1}
		^ ''{2}''
	' format: {package name . (file upToEnd copyReplaceAll: '''' with: '"')}).
	
	file close.
	^ 'xml{1}' format: { package name }.
	
	
]

{ #category : #abstract }
PhaROSCatkinPackage >> generateConstructor [
	self class compile: ('create{1} 
		^ PhaROSCatkinPackage new pharosPackage: { 1 }; cmake:{ 2}; xml: { 3 }; rosDependancies: { 4 }; yourself. 
	' format: { package name . self encodeCMAKE . self encodeXML . rosDependancies asString }
	
	 ) classified: ('constructor-{1}'format: { package name })
]

{ #category : #path }
PhaROSCatkinPackage >> image [
	^ self path ,'/image/Pharo.image'
]

{ #category : #path }
PhaROSCatkinPackage >> imageFolder [
	^ self path ,'/image'
]

{ #category : #abstract }
PhaROSCatkinPackage >> install [

	self cmake ifNil: [ 
		PhaROSPackageManager new install: self  
	] ifNotNil: [
		PhaROSPackageManager new create: self  
	] .


	self generateConstructor.
]

{ #category : #abstract }
PhaROSCatkinPackage >> location [
	^ location ifNil:[ self error: 'location is not setted' ].
]

{ #category : #abstract }
PhaROSCatkinPackage >> location: aLocation [
	
	location := aLocation.
]

{ #category : #path }
PhaROSCatkinPackage >> mainBinary [
	^ self bin, '/pharos'.
]

{ #category : #path }
PhaROSCatkinPackage >> mainEdit [
	^ self bin, '/edit'.
]

{ #category : #path }
PhaROSCatkinPackage >> mainHeadless [
	^ self bin, '/headless'.
]

{ #category : #abstract }
PhaROSCatkinPackage >> make [
		PhaROSPackageManager new make: self.
	
]

{ #category : #path }
PhaROSCatkinPackage >> msg [
	^ self path ,'/msg'
]

{ #category : #path }
PhaROSCatkinPackage >> packageName [
	^ package name
]

{ #category : #path }
PhaROSCatkinPackage >> packageXML [ 

	^ self path, '/package.xml' 
]

{ #category : #path }
PhaROSCatkinPackage >> path [
	^ self location, '/', self packageName 
]

{ #category : #accessing }
PhaROSCatkinPackage >> pharosPackage [
	^package
]

{ #category : #accessing }
PhaROSCatkinPackage >> pharosPackage: aPackage [ 
	package := aPackage
]

{ #category : #accessing }
PhaROSCatkinPackage >> rosDependencies [ 
	^ rosDependancies 
]

{ #category : #accessing }
PhaROSCatkinPackage >> rosDependencies: aCollection [ 
	 rosDependancies := aCollection
]

{ #category : #accessing }
PhaROSCatkinPackage >> rosDependenciesString [
	^ self rosDependencies inject: '' into:  [: dep :acc | acc,' ', dep asString] .
]

{ #category : #'initialize-release' }
PhaROSCatkinPackage >> scriptMethods [


	^ package allMethods select: [ :m | (m selector asString beginsWith: 'script' ) and: [ m selector isUnary ] ] 
]

{ #category : #path }
PhaROSCatkinPackage >> scripts [
	^ self path ,'/image/scripts'
]

{ #category : #path }
PhaROSCatkinPackage >> vm [
	^ self path ,'/vm/pharo'
]

{ #category : #path }
PhaROSCatkinPackage >> vmFolder [
	^ self path ,'/vm'
]

{ #category : #abstract }
PhaROSCatkinPackage >> xml [
	^ xml
]

{ #category : #abstract }
PhaROSCatkinPackage >> xml: aPackageXMLDef [
	cmake := aPackageXMLDef .
]
