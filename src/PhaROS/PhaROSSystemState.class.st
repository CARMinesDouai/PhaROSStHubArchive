Class {
	#name : #PhaROSSystemState,
	#superclass : #Object,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'topicPublishersDict',
		'topicSubscribersDict',
		'serviceProvidersDict'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'instance creation' }
PhaROSSystemState class >> from: statusArray [
	^self new
		from: statusArray;
		yourself
]

{ #category : #'initialize-release' }
PhaROSSystemState >> addAssociationsFrom: array into: dict [
	array do: [:element|
		dict at: element first put: element second]

]

{ #category : #'initialize-release' }
PhaROSSystemState >> addProviders: providers forService: service [
	| previousProviders |
	previousProviders := serviceProvidersDict at: service ifAbsent: [#()].
	serviceProvidersDict at: service put: (providers, previousProviders) 
]

{ #category : #'initialize-release' }
PhaROSSystemState >> addPublishers: publishers forTopic: topic [
	| previousPublishers |
	previousPublishers := topicPublishersDict at: topic ifAbsent: [#()].
	topicPublishersDict at: topic put: (publishers, previousPublishers) 
]

{ #category : #'initialize-release' }
PhaROSSystemState >> addSubscribers: subscribers forTopic: topic [
	| previousSubscribers |
	previousSubscribers := topicSubscribersDict at: topic ifAbsent: [#()].
	topicSubscribersDict at: topic put: (subscribers, previousSubscribers)
]

{ #category : #'initialize-release' }
PhaROSSystemState >> from: statusArray [
	{topicPublishersDict.  topicSubscribersDict. serviceProvidersDict} with: statusArray do: [:dict :array|
		self addAssociationsFrom: array into: dict]

]

{ #category : #'initialize-release' }
PhaROSSystemState >> initialize [ 
	super initialize.
	serviceProvidersDict := Dictionary new.
	topicPublishersDict := Dictionary new.
	topicSubscribersDict := Dictionary new
]

{ #category : #quering }
PhaROSSystemState >> publishedTopics [
	 ^ self publisherTopics union: self subscriberTopics.
]

{ #category : #quering }
PhaROSSystemState >> publisherTopics [
	 ^ topicPublishersDict keys asSet.
]

{ #category : #quering }
PhaROSSystemState >> subscriberTopics [ 
	 ^ topicSubscribersDict keys asSet.
]

{ #category : #comparing }
PhaROSSystemState >> valuesToCompareForEquality [
	^{topicPublishersDict . topicSubscribersDict . serviceProvidersDict }
]
