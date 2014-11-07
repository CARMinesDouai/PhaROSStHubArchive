Class {
	#name : #PhaROSModel,
	#superclass : #RTBuilder,
	#instVars : [
		'nodes',
		'topics',
		'nodeToTopicLink'
	],
	#classVars : [
		'Instance'
	],
	#category : #PhaROSDashBoard
}

{ #category : #'as yet unclassified' }
PhaROSModel class >> instance [

	^ Instance ifNil: [ Instance := super new ]
]

{ #category : #'as yet unclassified' }
PhaROSModel class >> new [

	self error: 'Please, use instance instead.'
]

{ #category : #'as yet unclassified' }
PhaROSModel >> extractNodeInfo: nodeString [

	|topicName pubIndex subIndex servIndex aString|
	
	aString := PhaROSSystemInfo instance infoOfNode: nodeString.
	pubIndex := (aString lines) indexOf:'Publications: '.
	subIndex := (aString lines) indexOf:'Subscriptions: '.
	servIndex := (aString lines) indexOf:'Services: '.

	(pubIndex + 1) to: (subIndex -2) by: 1 do: [:e | 
		topicName := (aString lines at: e) substrings at: 2.
		topics add: topicName.
		nodeToTopicLink add: (nodeString -> topicName)].
	(subIndex + 1) to: (servIndex -2) by: 3 do: [:e | 
		topicName := (aString lines at: e) substrings at: 2.
		topics add: topicName.
		nodeToTopicLink add: (topicName -> nodeString)].
	 

]

{ #category : #'as yet unclassified' }
PhaROSModel >> initialize [

	nodes := PhaROSSystemInfo instance nodeList asSet.
	topics := PhaROSSystemInfo instance topicList asSet.
	nodeToTopicLink := Set new.
]

{ #category : #accessing }
PhaROSModel >> nodeToTopicLink [
	^ nodeToTopicLink
]

{ #category : #accessing }
PhaROSModel >> nodeToTopicLink: anObject [
	nodeToTopicLink := anObject asSet
]

{ #category : #accessing }
PhaROSModel >> nodes [
	^ nodes
]

{ #category : #accessing }
PhaROSModel >> nodes: anObject [
	nodes := anObject asSet
]

{ #category : #accessing }
PhaROSModel >> topics [
	^ topics
]

{ #category : #accessing }
PhaROSModel >> topics: anObject [
	topics := anObject asSet
]
