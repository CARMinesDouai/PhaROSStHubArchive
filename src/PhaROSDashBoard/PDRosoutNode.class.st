"
I represent the node '/rosout'.
"
Class {
	#name : #PDRosoutNode,
	#superclass : #Object,
	#category : #'PhaROSDashBoard-Mocks'
}

{ #category : #'as yet unclassified' }
PDRosoutNode >> asString [

	^ '/rosout'
]

{ #category : #'as yet unclassified' }
PDRosoutNode >> info [

	^ '--------------------------------------------------------------------------------
Node [/rosout]
Publications: 
 * /rosout_agg [rosgraph_msgs/Log]

Subscriptions: 
 * /rosout [rosgraph_msgs/Log]

Services: 
 * /rosout/get_loggers
 * /rosout/set_logger_level


contacting node http://localhost:39071/ ...
Pid: 22978
Connections:
 * topic: /rosout
    * to: /turtlesim (http://localhost:36907/)
    * direction: inbound
    * transport: TCPROS

'
]

{ #category : #'as yet unclassified' }
PDRosoutNode >> isAlive [
	^ true
]

{ #category : #'as yet unclassified' }
PDRosoutNode >> kill [

	"doNothing"
]

{ #category : #'as yet unclassified' }
PDRosoutNode >> topics [

	 ^ #('/rosout' '/rosout_agg')
]
