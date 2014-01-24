Class {
	#name : #PRCCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #activation }
PRCCommandLineHandler >> activate [ 	

	self activateHelp.
	[ self realActivate ] on: Error do: [ :e |
		self stderr nextPutAll: e messageText, String lf.
		self halt.
	].
	self exitSuccess.
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
	^ self checkPackage: aPackageName  ifFail: [ self error: aPackageName, ' is not a valid package.'  ]
]

{ #category : #validation }
PRCCommandLineHandler >> checkPackage: aPackageName ifFail: aBlock [
	^ (PRCCommandPackageRegistry existsPackageNamed: aPackageName ) ifTrue: [  aPackageName  ] ifFalse: [  
		aBlock cull: aPackageName.
	].
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

{ #category : #validation }
PRCCommandLineHandler >> isAValidCatkinWorkspace: aLocation [ 
	^ aLocation isDirectory and: [
		(aLocation / #src ) exists and: [ (aLocation / #src ) isDirectory ]
	 ].
]

{ #category : #resolving }
PRCCommandLineHandler >> loadRepositories [
	
	self readRepositories do:[
		:repo | 
		" We load the package, and register the directory class to the package registry "
			Gofer it url: (repo at:'url') username: (repo at:'user') password: (repo at:'password') ; package: (repo at:'repository'); load.
			PRCCommandPackageRegistry register: (Smalltalk at: (repo at: 'directory') asSymbol) 
	].
]

{ #category : #accessing }
PRCCommandLineHandler >> location [

	^ (self checkLocation: (self optionAt: #location ifAbsent: [  self workingDirectory ] ) asFileReference ) pathString.
]

{ #category : #resolving }
PRCCommandLineHandler >> package [
	^ self checkPackage: (commandLine optionAt: #package ifAbsent:[ commandLine argumentAt: 1 ]) ifFail: [ 
		self loadRepositories.
		self checkPackage: (commandLine optionAt: #package ifAbsent:[ commandLine argumentAt: 1 ])
	 ].
]

{ #category : #'as yet unclassified' }
PRCCommandLineHandler >> pharoUser [

	^  (self optionAt: #'pharo-user' ifAbsent: [  'pharos' ] ).
]

{ #category : #resolving }
PRCCommandLineHandler >> readRepositories [
	| repositoriesFile errors repositories |
	repositoriesFile := 	(FileLocator workingDirectory / self repositoriesFileName ).
	repositories := OrderedCollection new.
	
	repositoriesFile exists ifTrue: [ 
		| content stream |
		stream := (repositoriesFile openWritable: false) readStream.
		content := stream upToEnd.
		stream close.
		
		"We want to load as much directories as we can. And also is mechanism of resolving, so if some repository fails, we just show a warning. error collection is for collecting the exceptions"
		errors := OrderedCollection new. 
		
		"The repositories file haste the following format
			'url={1}|repository={2}|directory={3}|user:{4}|password:{5};'	
		"
		(';' split: content) do: [ 	: entr |
			| repo entry |
			entry := entr copyReplaceAll: String lf with: ''. 
			entry := entry copyReplaceAll: String cr with: ''.
			entry := entry copyReplaceAll: String space with: ''.
			entry := entry copyReplaceAll: String tab with: ''.
			entry isEmpty ifFalse: [
				[
					repo := Dictionary new. 
					('|' split: entry ) do: [ :field  |
						| nameValue |
						nameValue := '=' split: field .
						repo at: (nameValue at:1) put: (nameValue at:2).
					].
					repositories add: repo.
					
				
				] on: Error do: [ :e |  errors add: 'WARNING- Corrupt entry in repositories file entry [', entry, ']:', e messageText ].
			]
		 ].
	
		errors do: [  :e | self stdout nextPutAll: e, String lf ].
	 ] ifFalse: [ 
		"If there is no reigstered repository we show INFO just to remember user he may add repositories"
		self stdout nextPutAll: 'INFO- There are not repositories registered', String lf
	 ].
	^ repositories.
]

{ #category : #activation }
PRCCommandLineHandler >> realActivate [
	self subclassResponsibility 
]

{ #category : #resolving }
PRCCommandLineHandler >> repositoriesFileName [
	^ 'repositories'
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
