Class {
	#name : #'Rosgraph_msgsTopicStatistics',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics class >> rosMd5Sum [ 
^'10152ed868c5097a5e2e4a89d7daa710'
]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics class >> rosTypeDefinition [ 
^' string topic
 string node_pub
 string node_sub
 time window_start
 time window_stop
 int32 delivered_msgs
 int32 dropped_msgs
 int32 traffic
 duration period_mean
 duration period_stddev
 duration period_max
 duration stamp_age_mean
 duration stamp_age_stddev
 duration stamp_age_max
'
]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics class >> rosTypeName [ 
^'rosgraph_msgs/TopicStatistics'
]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics class >> typeCreationOrder [ 
^254
]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> delivered_msgs [
	^ self getAt: #delivered_msgs. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> delivered_msgs: aValue [
	^ self at: #delivered_msgs put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> dropped_msgs [
	^ self getAt: #dropped_msgs. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> dropped_msgs: aValue [
	^ self at: #dropped_msgs put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> initialize [
	super initialize.
	 self topic: ''. 
	 self node_pub: ''. 
	 self node_sub: ''. 
	 self window_start:  PhaROSTimestamp now. 
	 self window_stop:  PhaROSTimestamp now. 
	 self delivered_msgs: 0. 
	 self dropped_msgs: 0. 
	 self traffic: 0. 
	 self period_mean:  Duration seconds: 0. 
	 self period_stddev:  Duration seconds: 0. 
	 self period_max:  Duration seconds: 0. 
	 self stamp_age_mean:  Duration seconds: 0. 
	 self stamp_age_stddev:  Duration seconds: 0. 
	 self stamp_age_max:  Duration seconds: 0. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> node_pub [
	^ self getAt: #node_pub. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> node_pub: aValue [
	^ self at: #node_pub put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> node_sub [
	^ self getAt: #node_sub. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> node_sub: aValue [
	^ self at: #node_sub put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> period_max [
	^ self getAt: #period_max. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> period_max: aValue [
	^ self at: #period_max put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> period_mean [
	^ self getAt: #period_mean. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> period_mean: aValue [
	^ self at: #period_mean put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> period_stddev [
	^ self getAt: #period_stddev. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> period_stddev: aValue [
	^ self at: #period_stddev put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> stamp_age_max [
	^ self getAt: #stamp_age_max. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> stamp_age_max: aValue [
	^ self at: #stamp_age_max put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> stamp_age_mean [
	^ self getAt: #stamp_age_mean. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> stamp_age_mean: aValue [
	^ self at: #stamp_age_mean put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> stamp_age_stddev [
	^ self getAt: #stamp_age_stddev. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> stamp_age_stddev: aValue [
	^ self at: #stamp_age_stddev put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> topic [
	^ self getAt: #topic. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> topic: aValue [
	^ self at: #topic put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> traffic [
	^ self getAt: #traffic. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> traffic: aValue [
	^ self at: #traffic put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> window_start [
	^ self getAt: #window_start. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> window_start: aValue [
	^ self at: #window_start put: aValue. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> window_stop [
	^ self getAt: #window_stop. 

]

{ #category : #'as yet unclassified' }
Rosgraph_msgsTopicStatistics >> window_stop: aValue [
	^ self at: #window_stop put: aValue. 

]
