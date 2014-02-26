Class {
	#name : #PhaROSPackage,
	#superclass : #Object,
	#instVars : [
		'controller'
	],
	#classInstVars : [
		'instance',
		'location'
	],
	#category : #'PhaROS-PackageManager'
}

{ #category : #abstract }
PhaROSPackage class >> author [
	self subclassResponsibility 
]

{ #category : #path }
PhaROSPackage class >> bin [
	^ self path ,'/bin'
]

{ #category : #path }
PhaROSPackage class >> build [
	^ self path ,'/build'
]

{ #category : #path }
PhaROSPackage class >> cMakeList [

	^ self path, '/CMakeLists.txt' 
]

{ #category : #path }
PhaROSPackage class >> changes [
	^ self path ,'/image/Pharo.changes'
]

{ #category : #abstract }
PhaROSPackage class >> cmake [
	self subclassResponsibility.
]

{ #category : #path }
PhaROSPackage class >> create: aLocation [
	location := aLocation.
	PhaROSPackageManager new create: self 
]

{ #category : #accessing }
PhaROSPackage class >> definedNodelets [
	^ {}
]

{ #category : #abstract }
PhaROSPackage class >> deployType: aType definedAs: aTypeDefinition [
	^ PhaROSSystemLauncher instance deployType: aType definedAs: aTypeDefinition at: self.
]

{ #category : #abstract }
PhaROSPackage class >> encodeFiles [
	| file |
	file := StandardFileStream readOnlyFileNamed: self cMakeList.

	self class compile: ('cmake
		^ ''{1} ''
	' format: { (file upToEnd copyReplaceAll: '''' with: '"')} ).
	
	file close.
	
	
	file := StandardFileStream readOnlyFileNamed: self packageXML.
	
	self class compile: (' xml
		^ ''{1}''
	' format: {(file upToEnd copyReplaceAll: '''' with: '"')}).
	
	file close.
]

{ #category : #path }
PhaROSPackage class >> image [
	^ self path ,'/image/Pharo.image'
]

{ #category : #path }
PhaROSPackage class >> imageFolder [
	^ self path ,'/image'
]

{ #category : #abstract }
PhaROSPackage class >> install: aLocation [
	location := aLocation.
	PhaROSPackageManager new install: self  
]

{ #category : #'initialize-release' }
PhaROSPackage class >> installScript: aScriptSelector [
	| script |
		script := StandardFileStream forceNewFileNamed: (self scripts, '/',( aScriptSelector asString copyReplaceAll: 'script' with:''  ) asLowercase).
		script  nextPutAll:  ('{1} instance {2}. ' format: { self name . aScriptSelector asString }), String crlf.
		script close. 
	
]

{ #category : #'initialize-release' }
PhaROSPackage class >> installScripts [ 
	self allMethods select: [ :m | (m selector asString beginsWith: 'script' ) and: [ m selector isUnary ] ] thenDo: [
		: scriptMethod |
		self installScript: scriptMethod selector.
	] 
]

{ #category : #'initialize-release' }
PhaROSPackage class >> instance [
	^ instance ifNil: [ instance := super new. ]
]

{ #category : #abstract }
PhaROSPackage class >> instance: anObject [
	instance := anObject .
]

{ #category : #abstract }
PhaROSPackage class >> isInstalled [ 
	^ location notNil
]

{ #category : #abstract }
PhaROSPackage class >> location [
	^ location ifNil:[ self error: 'location is not setted' ].
]

{ #category : #abstract }
PhaROSPackage class >> location: aLocation [
	aLocation ifNil: [ self error: 'Location is Nil! you must fix a location! ' ].
	aLocation asFileReference exists ifFalse: [
		 self error: 'Location does not exist! you must fix an existant location! '
	].
	location := aLocation.
]

{ #category : #path }
PhaROSPackage class >> mainBinary [
	^ self bin, '/pharos'.
]

{ #category : #path }
PhaROSPackage class >> mainEdit [
	^ self bin, '/edit'.
]

{ #category : #path }
PhaROSPackage class >> mainHeadless [
	^ self bin, '/headless'.
]

{ #category : #abstract }
PhaROSPackage class >> make [
	self isInstalled ifTrue: [
		PhaROSPackageManager new make: self.
	].
]

{ #category : #path }
PhaROSPackage class >> msg [
	^ self path ,'/msg'
]

{ #category : #'initialize-release' }
PhaROSPackage class >> new [
	self error: ' use instance'
]

{ #category : #path }
PhaROSPackage class >> nodeletsDependencies [ 
	^ self class nodeletsDependencies 
]

{ #category : #abstract }
PhaROSPackage class >> packageName [
	self subclassResponsibility 
]

{ #category : #path }
PhaROSPackage class >> packageXML [ 

	^ self path, '/package.xml' 
]

{ #category : #path }
PhaROSPackage class >> path [
	^ self location, '/', self packageName 
]

{ #category : #'initialize-release' }
PhaROSPackage class >> removeScript: aScriptSelector [
	FileSystem disk delete: (self scripts, '/',( aScriptSelector asString copyFrom: 'script' size) asLowercase).
		
]

{ #category : #accessing }
PhaROSPackage class >> rosDependencies [ 
	^ { #roscpp . #rospy . #std_msgs . #geometry_msgs . #message_generation . #message_runtime }
]

{ #category : #accessing }
PhaROSPackage class >> rosDependenciesString [
	^ self rosDependencies inject: '' into:  [: dep :acc | acc,' ', dep asString] .
]

{ #category : #path }
PhaROSPackage class >> scripts [
	^ self path ,'/image/scripts'
]

{ #category : #abstract }
PhaROSPackage class >> version [ 
	self subclassResponsibility.
]

{ #category : #path }
PhaROSPackage class >> vm [
	^ self path ,'/vm/pharo'
]

{ #category : #path }
PhaROSPackage class >> vmFolder [
	^ self path ,'/vm'
]

{ #category : #abstract }
PhaROSPackage class >> xml [
	self subclassResponsibility.
]

{ #category : #scripts }
PhaROSPackage >> buildController [ 
	self subclassResponsibility.
]

{ #category : #scripts }
PhaROSPackage >> controller [
	^ controller ifNil: [ controller := self buildController ].
]

{ #category : #scripts }
PhaROSPackage >> definedNodelets [
	^ {}
]

{ #category : #scripts }
PhaROSPackage >> finalize [
	self class instance: nil.
]

{ #category : #scripts }
PhaROSPackage >> quit [
	Smalltalk snapshot: false andQuit: true.
]

{ #category : #scripts }
PhaROSPackage >> scriptTest [
	Transcript open; show: (' {1} package has executed script test ' format: { self class name asString } ) cr.
]

{ #category : #scripts }
PhaROSPackage >> scriptUpdate [
	self stdout nextPutAll: ' Executing PureROS load'.
	self updatePackages.
	self stdout nextPutAll: ' Done.'.
	
	self quit.
]

{ #category : #scripts }
PhaROSPackage >> stdout [ 
	^  FileStream stdout.
]

{ #category : #scripts }
PhaROSPackage >> updatePackages [ 
	(Gofer it url:  'http://car.mines-douai.fr/squeaksource/PhaROS'
	username: ''
	password: '' ; package: 'PhaROS') update.

]
