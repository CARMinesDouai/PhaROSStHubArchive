Class {
	#name : #PRCCommandLineUpdate,
	#superclass : #PRCCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCCommandLineUpdate class >> commandName [
	^ 'update-tool'
]

{ #category : #'as yet unclassified' }
PRCCommandLineUpdate >> activate [ 	

	self activateHelp.
	self loadNetworkSettings.
	[ 
		ConfigurationOfPhaROSCommander loadBleedingEdge.
	 ] on: Error do: [ :e |
		self stderr nextPutAll: e messageText, String lf.
		self exitFailure.
	].
	Smalltalk snapshot: true andQuit: true.
]
