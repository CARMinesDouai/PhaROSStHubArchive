Class {
	#name : #PureROSCaire,
	#superclass : #PhaROSPackage,
	#instVars : [
		'process'
	],
	#category : #PureROSPackageCaire
}

{ #category : #'as yet unclassified' }
PureROSCaire >> buildController [ 
	| ctroler |
	ctroler :=  PhaROSHandleController home.
	ctroler nodelets use: CaireNodelet as: #caire.
	^ ctroler
	
]

{ #category : #'as yet unclassified' }
PureROSCaire >> rvizFile [
	^ self path, '/src/single_robot.rviz'

]

{ #category : #'as yet unclassified' }
PureROSCaire >> scriptExplorationMaster [

	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec gmapping.
		spec moveBase.
		spec exploreNode.
		spec rviz.
	].

]

{ #category : #'as yet unclassified' }
PureROSCaire >> scriptMapCompressor [

	| publisher |	
	publisher := self controller node topicPublisher: '/chunk/map' typedAs: 'caire/ChunksMapTransport'.

	 ((self controller node buildConnectionFor: '/map') typedAs: 'nav_msgs/OccupancyGrid'; adapted: CaireChunkMap )
	  for: [
		: map |
		publisher send: [  : m | map intoCaireChunksMapTransport: m ].
	 ]; connect.
	 
	


]

{ #category : #'as yet unclassified' }
PureROSCaire >> scriptMapFusion [
	| mapFusor out |  
	
	
	mapFusor := self controller nodelets caire mapFuser.
	out := self controller nodelets caire defaultOutput. 
	
	mapFusor on: #FusedMapUpdate do: [: updatedMap | 
		out send: [ :m | updatedMap intoOccupancyGrid: m ].
	].

		" Sensor processor "
	self clock tickAt: 1 hz on: ({
		 ((self controller node buildConnectionFor: '/p3dx0/map') typedAs: 'nav_msgs/OccupancyGrid'; adapted: CaireMap ).
		 ((self controller node buildConnectionFor: '/p3dx1/map') typedAs: 'nav_msgs/OccupancyGrid'; adapted: CaireMap ).
	} asSensors infinityTolerance;
	  for: [
		: maps |
		" Model feeding "
		 mapFusor registerMaps: maps. 
	 ]; yourself
	 ).
	



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
	].

]
