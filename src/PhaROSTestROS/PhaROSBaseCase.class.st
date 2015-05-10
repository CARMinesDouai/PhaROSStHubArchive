Class {
	#name : #PhaROSBaseCase,
	#superclass : #TestCase,
	#instVars : [
		'masterUrl',
		'master',
		'process'
	],
	#category : #'PhaROSTestROS-Kernel'
}

{ #category : #accessing }
PhaROSBaseCase >> callerId [
	^ '/testId'.
]

{ #category : #'default parameters' }
PhaROSBaseCase >> defaultMasterIp [
	^ 'localhost'
]

{ #category : #'default parameters' }
PhaROSBaseCase >> defaultMasterPort [
	^ 11311
]

{ #category : #accessing }
PhaROSBaseCase >> masterUrl [
	^ masterUrl ifNil: [ 
			masterUrl := OSEnvironment default at: 'ROS_MASTER_URI' 
								ifAbsent: [ 'http://', self defaultMasterIp, ':', self defaultMasterPort asString ] ]
]

{ #category : #'setup / teardown' }
PhaROSBaseCase >> setUp [
	PhaROSSystem cleanAll.
	master := PhaROSMaster url: self masterUrl
	
]

{ #category : #actions }
PhaROSBaseCase >> startUpMaster [
	PhaROSSystemInfo instance launchExternalROSMaster

]

{ #category : #actions }
PhaROSBaseCase >> startUpTurtle [
	process := PhaROSSystemLauncher instance roslaunchForTests: 
	'
	<launch>
		<node name="turtlesim" pkg="turtlesim" type="turtlesim_node" />
	</launch>'.
]

{ #category : #'setup / teardown' }
PhaROSBaseCase >> tearDown [ 

	PhaROSSystem cleanAll.
	process ifNotNil: [ process finalize ].
	process := nil.
]
