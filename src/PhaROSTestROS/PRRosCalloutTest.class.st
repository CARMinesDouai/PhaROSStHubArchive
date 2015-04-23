"
These tests check the fundamentals of the API: Can we use the ROS command line utilities and does their output still conform to what we expect as output?
"
Class {
	#name : #PRRosCalloutTest,
	#superclass : #TestCase,
	#instVars : [
		'resource'
	],
	#category : #'PhaROSTestROS-SimpleAPI'
}

{ #category : #accessing }
PRRosCalloutTest class >> resources [
	 ^{ PRSimpleAPIResource }
]

{ #category : #running }
PRRosCalloutTest >> setUp [
	"Make sure the resource is available i.e. the ROS nodes have been started, and keep it"
	resource := self resources first current.
]

{ #category : #'publish-subscribe' }
PRRosCalloutTest >> testEcho [
	| process result list assocs  |
	
	"No dependencies on other tests"
	
	[	[process := (PipeableOSProcess  command: 'rostopic echo /turtle1/pose __name:=echo3') ] fork. 
		3 seconds wait.
		result :=  (process upToEnd readStream upToAll: '---').
	]
		ensure: [ OSProcess command: 'rosnode kill /echo3'].
	
	list := (resource tokenizeString: result).
	self assert: list size = 10.
	
	assocs := resource build: 5 associationsFrom: list.
	self assert: (assocs at: 1 ) key = 'x:'.
	self shouldnt: [Float readFrom: ((assocs at: 1 ) value) ] raise:  Error.

	self assert: (assocs at: 2 ) key = 'y:'.
	self shouldnt: [Float readFrom: ((assocs at: 2 ) value) ] raise:  Error.

	self assert: (assocs at: 3 ) key = 'theta:'.
	self shouldnt: [Float readFrom: ((assocs at:  3) value) ] raise:  Error.
		
	self assert: (assocs at: 4 ) key = 'linear_velocity:'.
	self shouldnt: [Float readFrom: ((assocs at: 4) value) ] raise:  Error.
	
	self assert: (assocs at: 5 ) key = 'angular_velocity:'.
	self shouldnt: [Float readFrom: ((assocs at: 5 ) value) ] raise:  Error.

	
]

{ #category : #'nodes-topics' }
PRRosCalloutTest >> testNodeList [
	| list |
	
	"No dependencies on other tests"
	
	list := resource tokenizeString:((PipeableOSProcess command: 'rosnode list') output).
	
	self assert:  (list includes:'/rosout').
	self assert: (list includes:'/turtle1').
	self assert: list size = 2.
"In case we run the teleop"
"	self assert: list size = 3.
	self assert: (list includes:'/turtle_teleop')."
]

{ #category : #'publish-subscribe' }
PRRosCalloutTest >> testPublish [
	| process result assocs |
	
	"Depends on testServiceCall and testEcho"
	
	OSProcess waitForCommand: ' rosservice call /reset'.

	OSProcess waitForCommand:
'rostopic pub -1 /turtle1/cmd_vel geometry_msgs/Twist "linear:
  x: 2.0
  y: 0.0
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 1.8"'.

	[	[process := (PipeableOSProcess  command: 'rostopic echo /turtle1/pose __name:=echo3') ] fork. 
		2 seconds wait.
		result :=  (process upToEnd readStream upToAll: '---').
	]
		ensure: [ OSProcess command: 'rosnode kill /echo3'].	
			
	assocs := resource build: 5 associationsFrom: (resource tokenizeString: result).
	
	self assert: (assocs at: 1 ) key = 'x:'.
	self assert: (Float readFrom: ((assocs at: 1 ) value)) = 6.60281658173.

	self assert: (assocs at: 2 ) key = 'y:'.
	self assert: (Float readFrom: ((assocs at: 2 ) value)) = 6.93898963928.

	self assert: (assocs at: 3 ) key = 'theta:'.
	self assert: (Float readFrom: ((assocs at:  3) value)) = 1.81439995766.
		
	self assert: (assocs at: 4 ) key = 'linear_velocity:'.
	self assert: (Float readFrom: ((assocs at: 4) value)) = 0.0.
	
	self assert: (assocs at: 5 ) key = 'angular_velocity:'.
	self assert: (Float readFrom: ((assocs at: 5 ) value)) = 0.0.

	OSProcess waitForCommand: ' rosservice call /reset'.
]

{ #category : #services }
PRRosCalloutTest >> testServiceCall [
	 |process result assocs|
	"Depends on testEcho"
	
	OSProcess waitForCommand: ' rosservice call /turtle1/teleport_absolute "x: 1.0 \y: 2.0 \theta: 3.0 " ' withCRs.

	[	[process := (PipeableOSProcess  command: 'rostopic echo /turtle1/pose __name:=echo3') ] fork. 
		2 seconds wait.
		result :=  (process upToEnd readStream upToAll: '---').
	]
		ensure: [ OSProcess command: 'rosnode kill /echo3'].	
			
	assocs := resource build: 5 associationsFrom: (resource tokenizeString: result).
	self assert: (assocs at: 1 ) key = 'x:'.
	self assert: (Float readFrom: ((assocs at: 1 ) value)) = 1.0.

	self assert: (assocs at: 2 ) key = 'y:'.
	self assert: (Float readFrom: ((assocs at: 2 ) value)) = 2.0.

	self assert: (assocs at: 3 ) key = 'theta:'.
	self assert: (Float readFrom: ((assocs at:  3) value)) = 3.0.
		
	self assert: (assocs at: 4 ) key = 'linear_velocity:'.
	self assert: (Float readFrom: ((assocs at: 4) value)) = 0.0.
	
	self assert: (assocs at: 5 ) key = 'angular_velocity:'.
	self assert: (Float readFrom: ((assocs at: 5 ) value)) = 0.0.

	OSProcess waitForCommand: ' rosservice call /reset'.
]

{ #category : #services }
PRRosCalloutTest >> testServiceList [
	| list |
	
	"No dependencies on other tests"
	
	list := resource tokenizeString:((PipeableOSProcess command: 'rosservice list') output).

	self assert:  (list includes: '/clear').
	self assert:  (list includes: '/kill').
	self assert:  (list includes: '/reset').
	self assert:  (list includes: '/rosout/get_loggers').
	self assert:  (list includes: '/rosout/set_logger_level').
	self assert:  (list includes: '/spawn').
	self assert:  (list includes: '/turtle1/get_loggers').
	self assert:  (list includes: '/turtle1/set_logger_level').
	self assert:  (list includes: '/turtle1/set_pen').
	self assert:  (list includes: '/turtle1/teleport_absolute').
	self assert:  (list includes: '/turtle1/teleport_relative').
	self assert: (list size) = 11.
"In case we run the teleop"
"	self assert: (list size) = 1.	
	self assert:  (list includes: '/turtle_teleop/get_loggers').
	self assert:  (list includes: '/turtle_teleop/set_logger_level')."


]

{ #category : #'nodes-topics' }
PRRosCalloutTest >> testTopicList [
	| list |
	
	"No dependencies on other tests"
	
	list := resource tokenizeString: ((PipeableOSProcess command: 'rostopic list') output ).

	self assert: (list includes:'/rosout').
	self assert: (list includes:'/rosout_agg').
	self assert: (list includes:'/turtle1/cmd_vel').
	self assert: (list includes:'/turtle1/color_sensor').
	self assert: (list includes:'/turtle1/pose').
	self assert: (list size = 5).
]
