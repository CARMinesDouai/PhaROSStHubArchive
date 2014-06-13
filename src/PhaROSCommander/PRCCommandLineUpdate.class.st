Class {
	#name : #PRCCommandLineUpdate,
	#superclass : #PRCCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #accessing }
PRCCommandLineUpdate class >> commandName [
	^ 'update-tool'
]

{ #category : #help }
PRCCommandLineUpdate class >> shortHelpText [
	^ 'check if there is any update of the tool, and it update it'
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
