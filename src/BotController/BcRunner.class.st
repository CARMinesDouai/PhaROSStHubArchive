"
I am a runner that drives the activity of a controller.

I am abstract. Subclasses must implement:
-start
Start the activity
-stop
Terminates the activty
"
Class {
	#name : #BcRunner,
	#superclass : #BcControllerPart,
	#category : #'BotController-Runners'
}

{ #category : #living }
BcRunner >> start [
	self subclassResponsibility 
]

{ #category : #living }
BcRunner >> stop [
	self subclassResponsibility 
]
