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

{ #category : #utility }
PRCCommandLineUpdate >> exitSuccess [
	Smalltalk snapshot: true andQuit: true.
	super exitSuccess 
]

{ #category : #activation }
PRCCommandLineUpdate >> realActivate [ 	
	
	self stdout: 'Update the PhaROSCommander code'.
	self shouldLoadBleedingEdge
		ifTrue: [ ConfigurationOfPhaROSCommander loadBleedingEdge ]
		ifFalse: [ ConfigurationOfPhaROSCommander loadStable ].
	
	self stdout: 'Remove cached images'.
	OSProcess command: ('OSProcess waitForCommand: ''cd {1} && rm -fr '' Pharo*-PhaROS-*.{image,changes}' format: { Smalltalk imageDirectory pathString.  })
]
