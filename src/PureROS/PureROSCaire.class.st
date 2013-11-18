Class {
	#name : #PureROSCaire,
	#superclass : #PhaROSPackage,
	#instVars : [
		'process'
	],
	#category : #'PureROS-Package'
}

{ #category : #'as yet unclassified' }
PureROSCaire class >> author [
	^ 'ZhiYan'
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> description [
	^' Caire - Exploration - Multirobots '
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> packageName [ 
	^ 'caire'
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> version [
	^ '0.1.0'
]

{ #category : #'as yet unclassified' }
PureROSCaire >> rvizFile [
	^ self path, '/src/single_robot.rviz'

]

{ #category : #'as yet unclassified' }
PureROSCaire >> scriptFrontierBasedExploration [

	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec exploreNode.
		spec rviz.
	].

]

{ #category : #'as yet unclassified' }
PureROSCaire >> scriptMappingForExploration [

	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		
		spec kompaiTF.
		spec odometry.
		
		spec gmapping.
		spec moveBase.

		spec compressor.
		
		spec relay: '/raw_command_velocity' to: '/command_velocity' named: 'smoother_by_pass'.
		spec staticZeroTFFrom: '/base_link'  to: '/laser'.  
		spec relay: '/kompai2/pose' to: '/pose' named: 'pose_relay'.
		spec relay: '/kompai/scan' to: '/scan' named: 'scan_relay'.
		spec relay: '/pharos/out/tf' to: '/tf' named: 'tf_out_relay'.
		spec relay: '/tf' to: '/pharos/in/tf' named: 'tf_in_relay'.
		
		"spec rviz. Unmatched comment quote ->"
	].

]
