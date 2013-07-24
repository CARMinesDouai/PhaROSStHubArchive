Class {
	#name : #PhaROSPackage,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'PhaROS-PackageManager'
}

{ #category : #'as yet unclassified' }
PhaROSPackage class >> instance [
	self = PhaROSPackage ifTrue: [
		self error: ' This class is abstract! '.
	].
	^ instance ifNil: [ 
		
		instance := super new.  
	].
]

{ #category : #'as yet unclassified' }
PhaROSPackage class >> new [ 
	self error: ' Use instance for creation! '
]

{ #category : #'as yet unclassified' }
PhaROSPackage class >> nodeletsDependencies [ 
	^ {}
]

{ #category : #'as yet unclassified' }
PhaROSPackage class >> rosDependencies [ 
	^ { #roscpp . #rospy . #std_msgs . #geometry_msgs }
]

{ #category : #abstract }
PhaROSPackage >> author [
	self subclassResponsibility 
]

{ #category : #path }
PhaROSPackage >> bin [
	^ self path ,'/bin'
]

{ #category : #path }
PhaROSPackage >> build [
	^ self path ,'/build'
]

{ #category : #path }
PhaROSPackage >> image [
	^ self path ,'/image/Pharo.image'
]

{ #category : #path }
PhaROSPackage >> imageFolder [
	^ self path ,'/image'
]

{ #category : #'initialize-release' }
PhaROSPackage >> initialize [
	
]

{ #category : #'initialize-release' }
PhaROSPackage >> installScript: aScriptSelector [
	| script |
		script := StandardFileStream forceNewFileNamed: (self scripts, '/',( aScriptSelector asString copyReplaceAll: 'script' with:''  ) asLowercase).
		script  nextPutAll:  ('{1} new {2}. ' format: { self class name . aScriptSelector asString }), String crlf.
		script close. 
	
]

{ #category : #'initialize-release' }
PhaROSPackage >> installScripts [ 
	self class allMethods select: [ :m | (m selector asString beginsWith: 'script' ) and: [ m selector isUnary ] ] thenDo: [
		: scriptMethod |
		self installScript: scriptMethod selector.
	] 
]

{ #category : #abstract }
PhaROSPackage >> location [
	^ self subclassResponsibility.
]

{ #category : #path }
PhaROSPackage >> mainBinary [
	^ self bin, '/pharos'.
]

{ #category : #path }
PhaROSPackage >> msg [
	^ self path ,'/msg'
]

{ #category : #abstract }
PhaROSPackage >> name [
	self subclassResponsibility 
]

{ #category : #path }
PhaROSPackage >> nodeletsDependencies [ 
	^ self class nodeletsDependencies 
]

{ #category : #path }
PhaROSPackage >> path [
	^ self location, '/', self name
]

{ #category : #'initialize-release' }
PhaROSPackage >> removeScript: aScriptSelector [
	FileSystem disk delete: (self scripts, '/',( aScriptSelector asString copyFrom: 'script' size) asLowercase).
		
]

{ #category : #accessing }
PhaROSPackage >> rosDependencies [
	^ self class rosDependencies
]

{ #category : #accessing }
PhaROSPackage >> rosDependenciesString [
	^ self rosDependencies inject: '' into:  [: dep :acc | acc,' ', dep asString] .
]

{ #category : #scripts }
PhaROSPackage >> scriptTest [
	Transcript open; show: (' {1} package has executed script test ' format: { self class name asString } ) cr.
]

{ #category : #path }
PhaROSPackage >> scripts [
	^ self path ,'/image/scripts'
]

{ #category : #abstract }
PhaROSPackage >> version [ 
	self subclassResponsibility.
]

{ #category : #path }
PhaROSPackage >> vm [
	^ self path ,'/vm/pharo'
]

{ #category : #path }
PhaROSPackage >> vmFolder [
	^ self path ,'/vm'
]
