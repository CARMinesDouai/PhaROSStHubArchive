"
pharos usage

	pharos install			- Installs a package 
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
PRCDefaultCommandLineHandler >> handleSubcommand [
	"check if there is an active subcommand"
	
	| handlers |
	
	handlers := self selectHandlers.
	
	"ignore the default command line handler"
	handlers first = self class
		ifTrue: [ ^ self ].
		
	^ handlers first activateWith: commandLine.
]
