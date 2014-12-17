Class {
	#name : #PhaROSModel,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'topics',
		'nodeToTopicLink',
		'announcer',
		'link',
		'realLinks',
		'services'
	],
	#classVars : [
		'Instance'
	],
	#category : #'PhaROSDashBoard-model'
}

{ #category : #'as yet unclassified' }
PhaROSModel class >> initInstance [

	Instance := nil
]

{ #category : #'as yet unclassified' }
PhaROSModel class >> instance [

	^ Instance ifNil: [ Instance := super new ]
]

{ #category : #'as yet unclassified' }
PhaROSModel class >> new [

	self error: 'Please, use instance instead.'
]

{ #category : #'as yet unclassified' }
PhaROSModel >> announce: anEvent [
	self announcer announce: anEvent
]

{ #category : #accessing }
PhaROSModel >> announcer [
	^ announcer
]

{ #category : #'adding elements' }
PhaROSModel >> cleanLinks [

	(link difference: realLinks) do:[:lnk |
		self announce: (OldLinkEvent new link: lnk)
	]
]

{ #category : #'adding elements' }
PhaROSModel >> extractNodeInfo: node [

	|topicName pubIndex subIndex servIndex aString topicFound contIndex serviceName serviceFound msgType myLink msgTypeFormated |
	
	aString := PhaROSSystemInfo instance infoOfNode: node rosName.
	pubIndex := (aString lines) indexOf:'Publications: '.
	subIndex := (aString lines) indexOf:'Subscriptions: '.
	servIndex := (aString lines) indexOf:'Services: '.
	contIndex := (aString lines) indexOf:'Connections:'.
	
	(pubIndex + 1) to: (subIndex -2) by: 1 do: [:e | 
		topicName := (aString lines at: e) substrings at: 2.
		topicFound := topics detect:[:t | t rosName = topicName].
		msgType:= ((aString lines at: e) substrings at: 3).
		msgTypeFormated := msgType copyFrom: 2 to: msgType size-1.
		
		myLink := link detect:[:l | (l key = node) and:[l value = topicFound]] 
			ifNone:[
				|lk|
				lk := (PRDLink from: node to: topicFound type: msgTypeFormated).
				link add: lk.
				self announce: (NewLinkEvent new link: lk).
				lk
				].
		
		realLinks add: myLink.
	].
	
	(subIndex + 1) to: (servIndex -2) by: 1 do: [:e | 
		topicName := (aString lines at: e) substrings at: 2.
		topicFound := topics detect:[:t | t rosName = topicName].
		
		myLink := link detect:[:l | (l key = topicFound) and:[l value = node]] 
			ifNone:[
				|lk|
				lk := (PRDLink from: topicFound to: node type: (PhaROSSystemInfo instance typeOfTopic: topicFound rosName) allButLast).
				link add: lk.
				self announce: (NewLinkEvent new link: lk).
				lk
				].
		
		realLinks add: myLink.
	].
	
	(servIndex + 1) to: (contIndex -5) by: 1 do: [:e | 
		serviceName := (aString lines at: e) substrings at: 2.
		serviceFound := services detect:[:t | t rosName = serviceName] 
			ifNone:[
				self services add: (PRDService new rosName: serviceName)
			].
		node services add: serviceFound.
	].
	
]

{ #category : #'as yet unclassified' }
PhaROSModel >> initialize [

	nodes := Set new.
	topics := Set new"PhaROSSystemInfo instance topicList asSet".
	link := Set new.
	nodeToTopicLink := Set new.
	realLinks := Set new.
	services := Set new.
	
	announcer := Announcer new.
]

{ #category : #'as yet unclassified' }
PhaROSModel >> initializeRealLinks [

	realLinks := Set new.
]

{ #category : #accessing }
PhaROSModel >> link [
	^ link
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
PhaROSModel >> nodes: aCollectionOfPRDNodes [
	nodes := aCollectionOfPRDNodes asSet
]

{ #category : #'adding elements' }
PhaROSModel >> nodesFromStrings: aCollectionOfStrings [

	((nodes collect:[:n | n rosName]) difference: aCollectionOfStrings) do:[:aNodeName | 
			| node |
			node := nodes detect:[:e | e rosName = aNodeName].
			nodes remove: node.
			self announce: (OldNodeEvent new node: node)
	].
	(aCollectionOfStrings difference: (nodes collect:[:n | n rosName])) do:[:aNodeName | 
			|newNode|
			newNode := PRDNode new.
			newNode rosName: aNodeName.
			nodes add: newNode.
			self announce: (NewNodeEvent new node: newNode)
	].
]

{ #category : #accessing }
PhaROSModel >> realLinks [
	^ realLinks
]

{ #category : #accessing }
PhaROSModel >> services [
	^ services
]

{ #category : #accessing }
PhaROSModel >> services: anObject [
	services := anObject asSet
]

{ #category : #accessing }
PhaROSModel >> topics [
	^ topics
]

{ #category : #accessing }
PhaROSModel >> topics: anObject [
	topics := anObject asSet
]

{ #category : #'adding elements' }
PhaROSModel >> topicsFromStrings: aCollectionOfStrings [
	
	aCollectionOfStrings do:[:aString |
		|newTopic|
		(topics noneSatisfy:[:n | aString = n rosName]) ifTrue:[
			newTopic := PRDTopic new.
			newTopic rosName: aString.
			topics add: newTopic.
			self announce: (NewTopicEvent new topic: newTopic)
		]
	].

	((topics collect:[:n | n rosName]) difference: aCollectionOfStrings) do:[:aTopicName | 
			| topic |
			topic := topics detect:[:e | e rosName = aTopicName].
			topics remove: topic.
			self announce: (OldTopicEvent new topic: topic)
	].
	(aCollectionOfStrings difference: (topics collect:[:n | n rosName])) do:[:aTopicName | 
			|newTopic|
			newTopic := PRDTopic new.
			newTopic rosName: aTopicName.
			topics add: newTopic.
			self announce: (NewTopicEvent new topic: newTopic)
	].
]

{ #category : #'as yet unclassified' }
PhaROSModel >> when: evt do: aOneArgBlock [
	"Define a callback for the event evt (which could be a class event or an instance of a class event. aOneArgBlock is evaluated whenever the event is received."
	self announcer when: evt do: aOneArgBlock
]
