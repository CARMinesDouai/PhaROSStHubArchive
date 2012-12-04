Class {
	#name : #PhaROSSubscriber,
	#superclass : #Object,
	#instVars : [
		'owner',
		'channels',
		'receivedMessages'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #construction }
PhaROSSubscriber class >> for: aRoStNode [ 
	^ self new owner: aRoStNode; yourself.
]

{ #category : #accessing }
PhaROSSubscriber >> initialize [ 
	receivedMessages := OrderedCollection new.
	channels  := Dictionary new.
]

{ #category : #service }
PhaROSSubscriber >> interestedIn: aTopic [ 

	| currentChannels newChannels |
	
	currentChannels  :=  channels at: aTopic name ifAbsentPut: [ Set new ].
	
	newChannels := aTopic allInputChannelsFor: self  but: currentChannels.
	
	newChannels do: [ :ch | ch subscribe: self ].
	
	
	^  channels at: aTopic name put: currentChannels, newChannels.
	
]

{ #category : #accessing }
PhaROSSubscriber >> master [
	^owner master.
]

{ #category : #accessing }
PhaROSSubscriber >> owner [
	^ owner
]

{ #category : #accessing }
PhaROSSubscriber >> owner: aRoStNode [ 
	owner := aRoStNode.
]

{ #category : #accessing }
PhaROSSubscriber >> receive: aMessage from: aChannel [ 

	self receivedMessages add: aMessage.
	owner receive: aMessage from: aChannel.
]

{ #category : #accessing }
PhaROSSubscriber >> receivedMessages [
	^ receivedMessages.
]

{ #category : #accessing }
PhaROSSubscriber >> subscribedTo: aChannel [ 
	self flag:#whatThisMeans.
]

{ #category : #service }
PhaROSSubscriber >> unregisterFromAllTopics [ 
	channels do: [ : s | s do: [ : ch | ch unsubscribe: self ] ].
	channels removeAll.

]

{ #category : #accessing }
PhaROSSubscriber >> unregisterPublisher: aRoStPublisher [ 
	channels keysAndValuesDo:[ :k :v | 
		v remove: aRoStPublisher ifAbsent:[].
		v size = 0 ifTrue: [
			channels removeKey: k.	
		].
	].
	
]

{ #category : #accessing }
PhaROSSubscriber >> xmlRpcUrl [
	^owner xmlRpcUrl.
]
