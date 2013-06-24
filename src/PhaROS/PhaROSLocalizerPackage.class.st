"
This package has its mean to receive vectors in form of geometry_msgs/Pose (or polimorphic) that point to an id. With that data, this package obtain the best positioning. It learns from the measures and also give feedback. The more info it accumulates the more accuracy it have. 
"
Class {
	#name : #PhaROSLocalizerPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'entities',
		'mapping'
	],
	#category : #'PhaROS-Packages-Localizer'
}

{ #category : #accessing }
PhaROSLocalizerPackage class >> expectedRate [
	^ 0.1
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerPackage class >> mapTopic [
	^'/localizer/entities'
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerPackage class >> mapTopicType [ 
	^ 'nav_msgs/GridCells'
]

{ #category : #accessing }
PhaROSLocalizerPackage class >> measureThreshold [
	^ 0.0000000000001
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerPackage >> broadcastEntities [
	| points |
	
	points := entities values inject: OrderedCollection new into: [  :acc : e | acc addAll: e asGeometry_msgsPointCollection. acc ].
	mapping send: [ : msg | 
			msg header frame_id: '/map'.
			msg cell_width: 0.05.
			msg cell_height: 0.05.
			msg cells addAll:  points
	].	


]

{ #category : #'as yet unclassified' }
PhaROSLocalizerPackage >> entities [
	^ entities values.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerPackage >> initialize [ 
	entities := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerPackage >> learn: aTopicFlux [
	aTopicFlux for: [ : measure : chn : stamp |  self register: measure ].
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerPackage >> map [
	mapping ifNil: [
		mapping := self rosnode topicPublisher: PhaROSLocalizerPackage mapTopic typedAs: PhaROSLocalizerPackage mapTopicType.
		self rosnode enableHeartbeatAt: ( PhaROSLocalizerPackage expectedRate ).
		self rosnode registerHeartbeat: [ 
			self broadcastEntities.
		].
		
	].
]

{ #category : #'as yet unclassified' }
PhaROSLocalizerPackage >> register: aMeasure [ 
	| measure | 
	self flag: #uncoupleLandmarkFromLocalizerPackage.
	measure := PhaROSLocalizerMeasure fromPharosSGLandMark: aMeasure.
	(entities at: measure id ifAbsentPut: [ PhaROSLocalizerEntity for: measure id ]) add: measure .
]
