Class {
	#name : #PhaROSInteractiveMarkerServer,
	#superclass : #Object,
	#instVars : [
		'markers',
		'name'
	],
	#category : #'PhaROS-Packages-InteractiveMarker'
}

{ #category : #init }
PhaROSInteractiveMarkerServer >> completeUpdate: aNode throught:  aChannel [
	aChannel sendAMessage: [ : msg | 
		(markers collect: #marker )	 do: [ 
			: marker | 
			msg markers add: marker.	
		].
	] to: aNode.
	
]

{ #category : #package }
PhaROSInteractiveMarkerServer >> configure: aPackage [
	self connectFeedbackThrought: aPackage.
	self connectToHeartbeat: aPackage.
	self connectInitializerThrought: aPackage.
]

{ #category : #feedback }
PhaROSInteractiveMarkerServer >> connectFeedbackThrought: aPackage [
	| connection | 
	
	connection := aPackage rosnode buildConnectionFor: self feedbackTopic.
	connection typedAs: self feedbackTopicType; for: [ :msg | self processFeedback: msg ].
	connection connect.
]

{ #category : #init }
PhaROSInteractiveMarkerServer >> connectInitializerThrought: aPackage [
	aPackage node atSubscribing: self initTopic do: [ : node :channel | self completeUpdate: node throught: channel.  ].
]

{ #category : #update }
PhaROSInteractiveMarkerServer >> connectToHeartbeat: aPackage [
	aPackage rosnode registerHeartbeat: [ : node | self partialUpdate: node ].
]

{ #category : #feedback }
PhaROSInteractiveMarkerServer >> feedbackTopic [
	^ '/{1}/feedback' format: {name normalizeFrame}
]

{ #category : #feedback }
PhaROSInteractiveMarkerServer >> feedbackTopicType [
	^ 'visualization_msgs/InteractiveMarkerFeedback'
]

{ #category : #init }
PhaROSInteractiveMarkerServer >> initTopic [
	^ '/{1}/update_full' format: {name normalizeFrame}
]

{ #category : #init }
PhaROSInteractiveMarkerServer >> initTopicType [
	^ 'visualization_msgs/InteractiveMarkerInit'.
]

{ #category : #accessing }
PhaROSInteractiveMarkerServer >> name: aName [
	name := aName
]

{ #category : #update }
PhaROSInteractiveMarkerServer >> partialUpdate: aNode [
	aNode sendTo: self updateTopic  typedAs:  self updateTopicType  a: [ : msg | 
		msg markers addAll: (markers select: #isDirty thenCollect: #marker). 
	].
]

{ #category : #feedback }
PhaROSInteractiveMarkerServer >> processFeedback: aMessage [
	Transcript show: aMessage; cr.
]

{ #category : #update }
PhaROSInteractiveMarkerServer >> updateTopic [
	^ '/{1}/update' format: {name normalizeFrame}
]

{ #category : #update }
PhaROSInteractiveMarkerServer >> updateTopicType [
	^ 'visualization_msgs/InteractiveMarkerUpdate'.
]
