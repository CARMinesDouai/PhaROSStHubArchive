"
I am a fake node that emulate turtlesim node.
I exist for testing purposes.
"
Class {
	#name : #PDTurtlesimNode,
	#superclass : #PDNode,
	#instVars : [
		'isAlive'
	],
	#category : #'PhaROSDashBoard-Mocks'
}

{ #category : #'as yet unclassified' }
PDTurtlesimNode >> asString [

	^ '/turtlesim'
]

{ #category : #'as yet unclassified' }
PDTurtlesimNode >> info [

^ '--------------------------------------------------------------------------------
Node [/turtlesim]
Publications: 
 * /turtle1/color_sensor [turtlesim/Color]
 * /rosout [rosgraph_msgs/Log]
 * /turtle1/pose [turtlesim/Pose]

Subscriptions: 
 * /turtle1/cmd_vel [unknown type]

Services: 
 * /turtle1/teleport_absolute
 * /turtlesim/get_loggers
 * /turtlesim/set_logger_level
 * /reset
 * /spawn
 * /clear
 * /turtle1/set_pen
 * /turtle1/teleport_relative
 * /kill


contacting node http://localhost:36907/ ...
Pid: 25467
Connections:
 * topic: /rosout
    * to: /rosout
    * direction: outbound
    * transport: TCPROS

'
]

{ #category : #'as yet unclassified' }
PDTurtlesimNode >> initialize [

	super initialize.

	isAlive := true.
]

{ #category : #'as yet unclassified' }
PDTurtlesimNode >> isAlive [
	^ isAlive
]

{ #category : #'as yet unclassified' }
PDTurtlesimNode >> kill [

	isAlive := false.
]

{ #category : #'as yet unclassified' }
PDTurtlesimNode >> ping [

^ self isAlive ifTrue: [ #('rosnode: node is [/turtlesim]' 'pinging /turtlesim with a timeout of 3.0s' 'xmlrpc reply from http://localhost:36907/	time=0.586033ms') ]
			ifFalse: [ #('rosnode: node is [/turtlesim]') ]
]

{ #category : #'as yet unclassified' }
PDTurtlesimNode >> topics [

 	^ #('/turtle1/cmd_vel' '/turtle1/color_sensor' '/turtle1/pose')
]
