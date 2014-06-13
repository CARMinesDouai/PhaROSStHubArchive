Class {
	#name : #PRCCommandLineHandlerRepository,
	#superclass : #PRCDisabledCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCCommandLineHandlerRepository class >> commandName [
	^ 'repository'
]

{ #category : #'as yet unclassified' }
PRCCommandLineHandlerRepository >> realActivate [
	
	commandLine arguments isEmpty ifTrue: [ 
		self printHelp.	
	 ].
	
	PRCDefaultCommandLineHandler new commandLine: (commandLine argumentAt: 1)
]
