Class {
	#name : #PRCCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCCommandLineHandler class >> isAbstract [
	^ self = PRCCommandLineHandler
]

{ #category : #help }
PRCCommandLineHandler class >> shortHelpText [
	^ self subclassResponsibility 
]

{ #category : #activation }
PRCCommandLineHandler >> activate [ 	

	self activateHelp.
	self loadNetworkSettings.
	[ self realActivate ] on: Error do: [ :e |
		self stderr nextPutAll: e messageText, String lf.
		self exitFailure.
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
	
	^ (({ #'14' . #'20' . #'30' . #'40' . #'Stable' . #'Alpha' } detect: [: t | t = aByteSymbol] ifNone: [ 
			self error: aByteSymbol asString, ' is not a valid Pharo version. Allowed versions are:
				--version=14
				--version=20
				--version=30
				--version=40
				--version=Stable
				--version=Alpha
			'
	]) asString copyReplaceAll: '.' with: '') asSymbol .

]

{ #category : #accessing }
PRCCommandLineHandler >> forceNewIfNeededAt: aPackageFileReference [
	(aPackageFileReference) exists ifTrue: [ 
		self forceNewPackage ifTrue: [
			(aPackageFileReference) deleteRecursively 
		] ifFalse: [
			^ self error: ' The package already exists in the source folder. Add --force-new for deleting the existant package' 
		].
	].
	aPackageFileReference createDirectory
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

{ #category : #activation }
PRCCommandLineHandler >> loadNetworkSettings [
	| currentConfiguration |
	
	currentConfiguration := (OSProcess thisOSProcess environmentAt: #http_proxy) ifNil: [ (OSProcess thisOSProcess environmentAt: #HTTP_PROXY) ].

	currentConfiguration ifNil: [ 
		NetworkSystemSettings useHTTPProxy: false.
	 ] ifNotNil: [ 
		currentConfiguration ifEmpty: [ 
			NetworkSystemSettings useHTTPProxy: false.
		 ] ifNotEmpty: [  
			currentConfiguration := currentConfiguration asZnUrl.
			NetworkSystemSettings useHTTPProxy: true.
			NetworkSystemSettings httpProxyServer: currentConfiguration host.
			NetworkSystemSettings httpProxyPort: currentConfiguration port.		
		].
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

{ #category : #accessing }
PRCCommandLineHandler >> pharoUser [

	^  (self optionAt: #'pharo-user' ifAbsent: [  'pharos' ] ).
]

{ #category : #resolving }
PRCCommandLineHandler >> readRepositories [
	| repos |
	repos := OrderedCollection new.
	
	repos add: {'directory'->'PhaROSDeploymentDirectory' . 'password'->'' .  'repository' -> 'PhaROSDeploymentDirectory' . 'url'->'http://smalltalkhub.com/mc/CAR/PhaROS/main' . 'user' ->'' } asDictionary.
	repos add: {'directory'->'PeriphericsDirectory' . 'password' ->'' . 'repository'->'PeriphericsDirectory' . 'url'->'http://smalltalkhub.com/mc/CAR/PhaROSPeripherics/main' . 'user'->''} asDictionary.
	^ repos
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
	
	^ self checkVersion: (self optionAt: #version ifAbsent: [ 'Stable' ]).
]

{ #category : #accessing }
PRCCommandLineHandler >> workingDirectory [
	^ (FileLocator home / 'PhaROS-ws') pathString
]
