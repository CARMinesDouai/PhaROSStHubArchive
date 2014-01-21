Class {
	#name : #PRCCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #activation }
PRCCommandLineHandler >> activate [ 	
	self help ifTrue:[
		self stdout nextPutAll: self helpMessage, String lf.
	] ifFalse:[
		[ self realActivate ] on: Error do: [ :e |
			self stderr nextPutAll: e messageText, String lf.
		].
	].
	Smalltalk snapshot: false andQuit: true.
]

{ #category : #validation }
PRCCommandLineHandler >> checkBoolean: aBoolean ifFail: aFailBlock [
 	(aBoolean compare: 'true' caseSensitive: false) = 2 ifTrue:[ ^ true ].
	(aBoolean compare: 'false' caseSensitive: false) = 2 ifTrue:[ ^ false ].
	^ aFailBlock value.
	
	 
]

{ #category : #validation }
PRCCommandLineHandler >> checkLocation: aLocation [ 
	
	^( aLocation exists and: [ 
		self isAValidCatkinWorkspace: aLocation.
	]) ifTrue:[ 
		aLocation 
	] ifFalse: [ 
		self error: aLocation pathString , ' is not a valid catkin workspace'
	] .
]

{ #category : #validation }
PRCCommandLineHandler >> checkPackage: aPackageName [ 
	^ (PRCCommandPackageRegistry existsPackageNamed: aPackageName ) ifTrue: [  aPackageName  ] ifFalse: [  self error: aPackageName, ' is not a valid package.' ].
]

{ #category : #validation }
PRCCommandLineHandler >> checkSilent: aBoolean [
	^ self checkBoolean: aBoolean ifFail: [ 
		 self error: aBoolean asString, ' is not a valid value for --silent. It should be true or false'.
	].
	
	 
]

{ #category : #validation }
PRCCommandLineHandler >> checkVersion: aByteSymbol [ 
	
	^ (({ #'1.4' . #'2.0' . #'3.0' } detect: [: t | t = aByteSymbol] ifNone: [ 
		{ #'14' . #'20' . #'30' } detect: [: t | t = aByteSymbol] ifNone: [ 
			self error: aByteSymbol asString, ' is not a valid Pharo version. 
				--version 1.4 => Pharo 1.4
				--version 2.0 => Pharo 2.0
				--version 3.0 => Pharo 3.0
			'
		]
	]) asString copyReplaceAll: '.' with: '') asSymbol .

]

{ #category : #accessing }
PRCCommandLineHandler >> forceNewIfNeededAt: aPackageFileReference [
	self forceNewPackage ifTrue: [
		(aPackageFileReference) exists ifTrue: [ 
			(aPackageFileReference) deleteRecursively.		
		]
	] ifFalse: [
		(aPackageFileReference) exists ifTrue: [ 
			self error: ' The package already exists in the source folder. Add --force-new for deleting the existant package'	.
		]
	].
]

{ #category : #resolving }
PRCCommandLineHandler >> forceNewPackage [
	^ self hasOption: 'force-new'
]

{ #category : #accessing }
PRCCommandLineHandler >> help [
	^ self hasOption: #help.
	
]

{ #category : #activation }
PRCCommandLineHandler >> helpMessage [
	^ self subclassResponsibility 
]

{ #category : #validation }
PRCCommandLineHandler >> isAValidCatkinWorkspace: aLocation [ 
	^ aLocation isDirectory and: [
		(aLocation / #src ) exists and: [ (aLocation / #src ) isDirectory ]
	 ].
]

{ #category : #accessing }
PRCCommandLineHandler >> location [

	^ (self checkLocation: (self optionAt: #location ifAbsent: [  self workingDirectory ] ) asFileReference ) pathString.
]

{ #category : #resolving }
PRCCommandLineHandler >> package [
	^ self checkPackage: (commandLine optionAt: #package ifAbsent:[ commandLine argumentAt: 1 ])
]

{ #category : #activation }
PRCCommandLineHandler >> realActivate [
	self subclassResponsibility 
]

{ #category : #resolving }
PRCCommandLineHandler >> silent [
	^ self checkSilent: (commandLine optionAt: #silent ifAbsent: [ 'true' ]).
]

{ #category : #resolving }
PRCCommandLineHandler >> version [
	
	^ self checkVersion: (self optionAt: #version ifAbsent: [ #'20' ]).
]

{ #category : #accessing }
PRCCommandLineHandler >> workingDirectory [
	^ OSProcessAccessor forThisOSProcess  environmentAt: #PWD.
]
