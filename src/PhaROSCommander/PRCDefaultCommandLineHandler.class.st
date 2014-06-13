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
PRCDefaultCommandLineHandler class >> isAbstract [
	^ false
]

{ #category : #'as yet unclassified' }
PRCDefaultCommandLineHandler class >> isResponsibleFor: aCommandLineArguments [
	^true 
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

{ #category : #'as yet unclassified' }
PRCDefaultCommandLineHandler >> helpText [
	
	^String streamContents: [  :s |
		|commandsHandlers max|
		commandsHandlers := self allHandlers reject:  [ :c | c = self class ].
		s << 'pharos usage:'; lf.

		max:=0.
		commandsHandlers do: [ :h |
			max :=  h commandName size max: max.
		].

		commandsHandlers do: [ :h |
			s tab << 'pharos ' << h commandName.
			(max - h commandName size) timesRepeat: [ s nextPut: Character space ]. 
			s tab << h shortHelpText ; lf
		]
	] 
	 
]

{ #category : #'as yet unclassified' }
PRCDefaultCommandLineHandler >> printHelp [
	self stderr
		nextPutAll: self helpText; lf

]

{ #category : #'as yet unclassified' }
PRCDefaultCommandLineHandler >> selectHandlers [
	| handlers |
	handlers := (self subCommandsRoot selectHandlersFor: commandLine).
	handlers := handlers sort: [ :a :b | a priority >= b priority ].
	^ handlers
]
