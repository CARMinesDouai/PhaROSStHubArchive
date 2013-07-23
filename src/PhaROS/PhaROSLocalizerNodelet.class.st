"
This nodelet has its mean to receive vectors in form of geometry_msgs/Pose (or polimorphic) that point to an id. With that data, this package obtain the best positioning. It learns from the measures and also give feedback. The more info it accumulates the more accuracy it have. 

	In order to achive this we have the message 

	learn: aTopicFlux
	
	which configure the localizer to consume information from this topic, and register all the measures.
	
	This nodelet also allows to broadcast the localized entities as {PhaROSLocalizerNodelet mapTopicType} with the localization of each entity in a grid, taking as base the /map frame coordinate system. To start this broadcasting you just need to send the message
	
	
	map -- it open a publishing topic named { PhaROSLocalizerNodelet mapTopic} 
	
	Finally, in order to keep this results out of the image and be able to load them in other images, there are two more messages
	
	fileout: aPath --- it dumps all the entities in a .st file. 
	filein: aPath --- it loads a dump.
	

"
Class {
	#name : #PhaROSLocalizerNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'entities',
		'mapping'
	],
	#category : #'PhaROS-Nodelets-Localizer'
}

{ #category : #accessing }
PhaROSLocalizerNodelet class >> expectedRate [
	^ 0.1
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet class >> mapTopic [
	^'/localizer/entities'
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet class >> mapTopicType [ 
	^ 'nav_msgs/GridCells'
]

{ #category : #accessing }
PhaROSLocalizerNodelet class >> measureThreshold [
	^ 0.0000000000001
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet >> broadcastEntities [
	| points |
	
	points := entities values inject: OrderedCollection new into: [  :acc : e | acc addAll: e asGeometry_msgsPointCollection. acc ].
	mapping send: [ : msg | 
			msg header frame_id: '/map'.
			msg cell_width: 0.05.
			msg cell_height: 0.05.
			msg cells addAll:  points
	].	

	(Delay forMilliseconds: 1000) wait.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet >> entities [
	^ entities values.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet >> filein: aFileName [
	| fl buffer |
	
	fl := StandardFileStream readOnlyFileNamed: aFileName.
	buffer := fl upToEnd.
	('---' split: buffer) do: [
		: entity | 
		|re|
		entity size > 3 ifTrue: [
			self class compile: 'DoIt ^', entity.
			re := self DoIt.
			entities at: re id put: re.
		] ifFalse:[ 
			
		]
	].

]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet >> fileout: aFileName [
	| fl |
	
	fl := StandardFileStream forceNewFileNamed: aFileName.
	fl nextPutAll: (self entities inject: '' into: [ : acc : ent | acc, ent asDump, '---']).
	fl flush.
	fl close.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet >> initialize [ 
	entities := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet >> learn: aTopicFlux [
	aTopicFlux for: [ : measure : chn : stamp |  self register: measure ].
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet >> map [
	mapping ifNil: [
		mapping := self rosnode topicPublisher: PhaROSLocalizerNodelet mapTopic typedAs: PhaROSLocalizerNodelet mapTopicType.
		
		self paralellize looping broadcastEntities.
		
	].
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet >> register: aMeasure [ 
	| measure | 
	self flag: #uncoupleLandmarkFromLocalizerPackage.
	measure := PhaROSLocalizerMeasure fromPharosSGLandMark: aMeasure.
	(entities at: measure id ifAbsentPut: [ PhaROSLocalizerEntity for: measure id ]) add: measure .
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerNodelet >> scannedEntities [ 
	^ self entities select: #complete
]
