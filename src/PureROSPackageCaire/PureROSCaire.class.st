Class {
	#name : #PureROSCaire,
	#superclass : #PhaROSPackage,
	#instVars : [
		'process',
		'x',
		'y',
		'ax',
		'ay'
	],
	#category : #PureROSPackageCaire
}

{ #category : #'as yet unclassified' }
PureROSCaire class >> chunkTypeDefinition [
	^ ROSType message named: 'Chunks' package: 'caire' defined: {
		#UInt16 asClass named: #to .
		#UInt8 asClass named: #value.
	}  


]

{ #category : #'as yet unclassified' }
PureROSCaire class >> chunksMapTypeDefinition [
	^ ROSType message named: 'ChunksMapTransport' package: 'caire' defined: {  
		ROSType definedBy:'std_msgs/Header'   named: #header.
		ROSType definedBy:'nav_msgs/MapMetaData'   named: #info.
		Array named: #chunks  ofType: self chunkTypeDefinition .
	}.
	
	
	
]

{ #category : #'as yet unclassified' }
PureROSCaire class >> types [
	^ { self chunkTypeDefinition  . self chunksMapTypeDefinition }.
	



]

{ #category : #initialize }
PureROSCaire >> buildController [ 
	| ctroler |
	ctroler :=  PhaROSHandleController home.
	ctroler nodelets use: CaireNodelet as: #caire.
	^ ctroler
	
]

{ #category : #initialization }
PureROSCaire >> init [
	x := 0.0.
	y := 0.0.
	ax := 0.0.
	ay := 0.0.
]

{ #category : #utils }
PureROSCaire >> registerDelta: aVector [
	|dxM dyM|
	
	dxM := aVector x / 12350.
	dyM := aVector y / 12350.
	
	x := x + dxM.
	y := y + dyM.
	ax :=dxM / aVector z.
	ay := dyM / aVector z.
	Transcript show: '+D:'; show: aVector; cr.
	Transcript show: '@'; show: x@y; cr.
	Transcript show: 'Speed:' ; show: ax @ay; cr. 
	
]

{ #category : #accessing }
PureROSCaire >> rvizFile [
	^ self path, '/src/single_robot.rviz'

]

{ #category : #scripts }
PureROSCaire >> scriptExplorationMaster [

	process:= PhaROSSystemLauncher  instance launch: [: spec | 
		spec gmapping.
		spec moveBase.
		spec exploreNode.
		spec rviz.
	].

]

{ #category : #scripts }
PureROSCaire >> scriptMapCompressor [

	| publisher |	
	publisher := self controller node topicPublisher: '/chunk/map' typedAs: 'caire/ChunksMapTransport'.

	 ((self controller node buildConnectionFor: '/map') typedAs: 'nav_msgs/OccupancyGrid'; adapted: CaireChunkMap )
	  for: [
		: map |
		publisher send: [  : m | map intoCaireChunksMapTransport: m ].
	 ]; connect.
	 
	


]

{ #category : #scripts }
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

{ #category : #scripts }
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

{ #category : #scripts }
PureROSCaire >> scriptSmaJerry [

	"should be removed probably. outdated!"
	
	self init.
	self nodelets use: #SMAJerry asClass as: #jerry.

	self clock tickAt: 50 hz on:( { 
		 self nodelets jerry. 
	} asSensors infinityTolerance; for: [ 
		: vector |
		self registerDelta:( vector at:1) .
	 ])
]
