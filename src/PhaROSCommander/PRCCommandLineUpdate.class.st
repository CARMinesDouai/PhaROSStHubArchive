"
usage: pharos update [OPTIONS]
 
Options:
   --help                     Shows this text
   --dev                      Load the bleedingEdge version of PhaROSCommander
"
Class {
	#name : #PRCCommandLineUpdate,
	#superclass : #PRCCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #accessing }
PRCCommandLineUpdate class >> commandName [
	^ 'update'
]

{ #category : #help }
PRCCommandLineUpdate class >> shortHelpText [
	^ 'update the PhaROS commander tool'
]

{ #category : #'as yet unclassified' }
PRCCommandLineUpdate >> exitSuccess [
	Smalltalk snapshot: true andQuit: true.
	super exitSuccess 
]

{ #category : #'as yet unclassified' }
PRCCommandLineUpdate >> realActivate [ 	

	ConfigurationOfPhaROSCommander perform: self versionNameToLoad asSelector

]
