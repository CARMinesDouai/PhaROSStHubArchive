"
pharos usage

	
	
	pharos install			- Installs a package 
	pharos create 			- Creates a new package based on an archetype
	pharos create-repository	- Creates a smalltalk script for creating your own repository
	pharos register-repository	- Register a new package repositry
	pharos list-repositories	- List registered repostiries
	pharos update-tool	      - check if there is any update of the tool, and it update it.
	pharos ros-install		- installs a ros
		
	
"
Class {
	#name : #PRCDefaultCommandLineHandler,
	#superclass : #BasicCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCDefaultCommandLineHandler class >> isResponsibleFor: aCommandLineArguments [
	^false 
]

{ #category : #'as yet unclassified' }
PRCDefaultCommandLineHandler >> activate [
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
