Class {
	#name : #PhaROSSlave,
	#superclass : #Object,
	#instVars : [
		'owner'
	],
	#category : #'PhaROS-Network-XmlRpc'
}

{ #category : #'as yet unclassified' }
PhaROSSlave class >> for: aNode [
	^ self new owner: aNode; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSSlave >> getBusInfo: aCallerId [
	 | info node |
		
	info := owner topics inject: Set new into: [ :set :topic | 
		set addAll: (topic busInfoFor: owner). set. 
	].
	
	
	"info := { 
		{ '0' . '/turtlesim' . 'i' . 'TCPROS' . '/turtle1/command_velocity' }  
	}."
	
	 ^{ 1 . 'bus info' . info asArray }.
	
]

{ #category : #'as yet unclassified' }
PhaROSSlave >> getPid: aCallerId [
	 ^{ 1 . 'PID: 777' . 777 } .
]

{ #category : #'as yet unclassified' }
PhaROSSlave >> getPublications: aCallerId [
	^ { 1 . 'Success' . {} }.
]

{ #category : #'as yet unclassified' }
PhaROSSlave >> owner: aNode [
	owner := aNode.
]

{ #category : #'as yet unclassified' }
PhaROSSlave >> requestTopic: aCallerId for:aTopic availableFor: anArrayOfProtocols [
	(owner isRelatedWith: aTopic) ifTrue: [
		^ { 1 .  'Protocols' . {  'TCPROS'  .  owner domain  . owner publisher tcpPort }  }	
	].
	
]
