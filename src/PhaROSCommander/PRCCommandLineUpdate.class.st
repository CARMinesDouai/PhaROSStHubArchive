"
usage: pharos update

Effects:
1. 	update the PhaROSCommander code to the latest version (bleedingEdge) 
2.	removed cached PhaROS images 

Options:
   --help                     Shows this text

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
	
	| rmCommand |
	self stdout: 'Update the PhaROSCommander code'.
	
	Gofer it
		smalltalkhubUser: 'CAR' project: 'PhaROS';
		package: 'PhaROSCommander' ;
		update.
	
	self stdout: 'Remove cached images'.
	rmCommand :=  ('rm -fr {1}/Pharo*-PhaROS-*.image {1}/Pharo*-PhaROS-*.changes' 
							format: { Smalltalk imageDirectory pathString }).
	OSProcess command: rmCommand
]
