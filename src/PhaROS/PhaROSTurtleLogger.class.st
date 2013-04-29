Class {
	#name : #PhaROSTurtleLogger,
	#superclass : #PhaROSNode,
	#category : #'PhaROS-Experiments-RoboShopDeliverable1'
}

{ #category : #examples }
PhaROSTurtleLogger class >> loggerExample [
	"self loggerExample"
	| master |
	master := PhaROSMaster url: 'http://127.0.0.1:11311/'.
	^ master
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
	self interestedIn: '/turtle1/command_velocity' 
	
]
