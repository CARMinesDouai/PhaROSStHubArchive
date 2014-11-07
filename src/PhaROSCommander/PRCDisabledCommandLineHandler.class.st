"
The PRCDisabledCommandLineHandler class is here to disable subclasses by making them abstract (see class side isAbstract method)
"
Class {
	#name : #PRCDisabledCommandLineHandler,
	#superclass : #PRCCommandLineHandler,
	#category : #PhaROSCommander
}

{ #category : #'as yet unclassified' }
PRCDisabledCommandLineHandler class >> isAbstract [
	^ true
]
