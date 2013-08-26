Class {
	#name : #PhaROSTurtleLogger,
	#superclass : #PhaROSDelegateNode,
	#category : #'PhaROS-Experiments-RoboShopDeliverable1'
}

{ #category : #examples }
PhaROSTurtleLogger class >> loggerExample [
	"self loggerExample"
	| controller |
	controller := PhaROSMasiveNodeController localhost.
	^ controller
		create: self
		named: '/myTurtleLogger'
		domain: '127.0.0.1'
		tcpPort: 9999 
		xmlRpcPort: 6123
]

{ #category : #'initialize-release' }
PhaROSTurtleLogger >> start [ 
	super start.
	self receiverDelegate:  [ :message :channel |
       							Transcript show: message value asString].
	self subscriber:  '/turtle1/command_velocity'  typedAs: 'turtlesim/Velocity'.
	
]
