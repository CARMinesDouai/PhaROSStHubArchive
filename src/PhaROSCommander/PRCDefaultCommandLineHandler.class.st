"
pharos usage

	pharos install			- Installs a package 
	pharos create 			- Creates a new package based on an archetype
	pharos create-repository	- Creates a smalltalk script for creating your own repository
	pharos register-repository	- Register a new package repositry
	pharos list-repositories	- List registered repostiries
		
	
"
Class {
	#name : #PRCDefaultCommandLineHandler,
	#superclass : #DefaultCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCDefaultCommandLineHandler class >> isResponsibleFor: aCommandLineArguments [
	^ true.
]

{ #category : #'as yet unclassified' }
PRCDefaultCommandLineHandler >> activate [
	self loadNetworkSettings.
	super activate.
	self exitSuccess.
]

{ #category : #'as yet unclassified' }
PRCDefaultCommandLineHandler >> handleSubcommand [
	"check if there is an active subcommand"
	
	| handlers |
	
	handlers := self selectHandlers.
	
	"ignore the default command line handler"
	handlers first = self class
		ifTrue: [ ^ self ].
		
	^ handlers first activateWith: commandLine.
]

{ #category : #'as yet unclassified' }
PRCDefaultCommandLineHandler >> loadNetworkSettings [
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
