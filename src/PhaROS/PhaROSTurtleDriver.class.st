Class {
	#name : #PhaROSTurtleDriver,
	#superclass : #PhaROSNode,
	#instVars : [
		'process'
	],
	#category : #'PhaROS-Experiments-RoboShopDeliverable1'
}

{ #category : #examples }
PhaROSTurtleDriver class >> driverExample [
	"self driverExample"
	| controller |
	controller := PhaROSMasiveNodeController localhost.
	^ controller
		create: self
		named: '/myTurtleDriver'
		domain: '127.0.0.1'
		tcpPort: 20202 
		xmlRpcPort: 21212
]

{ #category : #controlling }
PhaROSTurtleDriver >> publishingLoop [
	|delay|
	delay := 1 second asDelay.
	[
		delay wait.
            self 
			sendTo: '/turtle1/command_velocity' 
			a: [ :message |
  		            	message angular: 1.0.
    		           		message linear: 2.0]
	] repeat
]

{ #category : #controlling }
PhaROSTurtleDriver >> start [

	super start.
	process := [self publishingLoop] newProcess.
	process
		name: 'Turtle Driver';
		priority: Processor userBackgroundPriority;
		resume
]

{ #category : #controlling }
PhaROSTurtleDriver >> stop [
	super stop.
	process terminate
]
