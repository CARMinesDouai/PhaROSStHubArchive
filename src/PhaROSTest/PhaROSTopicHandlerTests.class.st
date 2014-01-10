Class {
	#name : #PhaROSTopicHandlerTests,
	#superclass : #TestCase,
	#category : #'PhaROSTest-TopicHandlers'
}

{ #category : #subscribing }
PhaROSTopicHandlerTests >> testTopicAdaptedAndTypedBuilder [
	| node builder topicID flux  rslt | 
	
	node := PhaROSNodeMock new.
	topicID := 'aTopicID'.
	builder := (PhaROSTopicConectionBuilder node: node topicName: topicID)typedAs: 'aType'; adapted: #value \> #asString.
	
	flux := builder connect.
	
	self assert: node received =  #interestedIn:typedAs:for:.
	self assert: flux = node flux. 
	self assert: topicID = node topic.
	self assert: flux adapter  = (#value \> #asString) .
	self assert: flux condition  = PhaROSTopicFlux defaultConditional.
	self assert: (flux imInterestedIn: nil from: nil).
	 
	flux callback: [ : msg | rslt := msg ].
	flux  receive: [ 1+ 2 ] from: nil. 
	
	self assert: rslt = '3'.



]

{ #category : #subscribing }
PhaROSTopicHandlerTests >> testTopicAdaptedBuilder [
	| node builder topicID flux  rslt | 
	
	node := PhaROSNodeMock new.
	topicID := 'aTopicID'.
	builder := (PhaROSTopicConectionBuilder node: node topicName: topicID) adapted: #value \> #asString.
	
	flux := builder connect.
	
	self assert: node received = #interestedIn:for:.
	self assert: flux = node flux. 
	self assert: topicID = node topic.
	self assert: flux adapter  = (#value \> #asString) .
	self assert: flux condition  = PhaROSTopicFlux defaultConditional.
	self assert: (flux imInterestedIn: nil from: nil).
	 
	flux callback: [ : msg | rslt := msg ].
	flux  receive: [ 1+ 2 ] from: nil. 
	
	self assert: rslt = '3'.



]

{ #category : #subscribing }
PhaROSTopicHandlerTests >> testTopicConditionAdaptedAndTypedBuilder [
	| node builder topicID flux  rslt conditional | 
	
	node := PhaROSNodeMock new.
	topicID := 'aTopicID'.
	
	conditional := [ : msg | msg notNil and: [msg value < 4] ].
	builder := (PhaROSTopicConectionBuilder node: node topicName: topicID) typedAs:'type'; when: conditional; adapted: #value \> #asString.
	
	flux := builder connect.
	
	self assert: node received = #interestedIn:typedAs:for:.
	self assert: flux = node flux. 
	self assert: topicID = node topic.
	self assert: flux adapter  = (#value \> #asString) .
	self assert: flux condition  = conditional.
	self deny: (flux imInterestedIn: nil from: nil).
	 
	flux callback: [ : msg | rslt := msg ].

	flux  receive: [ 4 + 2 ] from: nil. 

	self assert: rslt isNil.

	
	flux  receive: [ 1+ 2 ] from: nil. 
	
	self assert: rslt = '3'.


]

{ #category : #subscribing }
PhaROSTopicHandlerTests >> testTopicConditionAndTypedBuilder [
	| node builder topicID flux  rslt conditional | 
	
	node := PhaROSNodeMock new.
	topicID := 'aTopicID'.
	
	conditional := [ : msg | false ].
	builder := (PhaROSTopicConectionBuilder node: node topicName: topicID) typedAs:'type'; when: conditional.
	
	flux := builder connect.
	
	self assert: node received = #interestedIn:typedAs:for:.
	self assert: flux = node flux. 
	self assert: topicID = node topic.
	self assert: flux adapter  = PhaROSTopicFlux defaultAdapter adaptToAdapter.
	self assert: flux condition  = conditional.
	self deny: (flux imInterestedIn: nil from: nil).
	 
	flux callback: [ : msg | rslt := msg ].
	flux  receive: [ 1+ 2 ] from: nil. 
	
	self assert: rslt isNil.



]

{ #category : #subscribing }
PhaROSTopicHandlerTests >> testTopicConditionBuilder [
	| node builder topicID flux  rslt conditional | 
	
	node := PhaROSNodeMock new.
	topicID := 'aTopicID'.
	
	conditional := [ : msg | false ].
	builder := (PhaROSTopicConectionBuilder node: node topicName: topicID) when: conditional.
	
	flux := builder connect.
	
	self assert: node received = #interestedIn:for:.
	self assert: flux = node flux. 
	self assert: topicID = node topic.
	self assert: flux adapter  = PhaROSTopicFlux defaultAdapter adaptToAdapter.
	self assert: flux condition  = conditional.
	self deny: (flux imInterestedIn: nil from: nil).
	 
	flux callback: [ : msg | rslt := msg ].
	flux  receive: [ 1+ 2 ] from: nil. 
	
	self assert: rslt isNil.



]

{ #category : #subscribing }
PhaROSTopicHandlerTests >> testTopicDefaultBuilder [
	| node builder topicID flux  rslt | 
	
	node := PhaROSNodeMock new.
	topicID := 'aTopicID'.
	builder := PhaROSTopicConectionBuilder node: node topicName: topicID.
	
	flux := builder connect.
	
	self assert: node received = #interestedIn:for:.
	self assert: flux = node flux. 
	self assert: topicID = node topic.
	self assert: flux adapter  = PhaROSTopicFlux defaultAdapter adaptToAdapter.
	self assert: flux condition  = PhaROSTopicFlux defaultConditional.
	self assert: (flux imInterestedIn: nil from: nil).
	 
	flux callback: [ : msg | rslt := msg ].
	flux  receive: [ 1+ 2 ] from: nil. 
	
	self assert: rslt = 3.



]

{ #category : #publishing }
PhaROSTopicHandlerTests >> testTopicPublisher [
	| publisher  typeID node topic  |


	node := PhaROSNodeMock new.
	topic := PhaROSTopic new name: 'topic'; type: 'type'; yourself .
 
	publisher := PhaROSTopicPublisher node: node topic: topic.

	publisher send: [].
	self assert: 'topic' = node topic.
	self assert: node received = #sendTo:typedAs:a:.
	
]

{ #category : #subscribing }
PhaROSTopicHandlerTests >> testTopicTypedBuilder [
	| node builder topicID flux  rslt typeName| 
	
	node := PhaROSNodeMock new.
	topicID := 'aTopicID'.
	typeName := 'aType'.
	builder := (PhaROSTopicConectionBuilder node: node topicName: topicID) typedAs: typeName.
	
	flux := builder connect.
	
	self assert: node received = #interestedIn:typedAs:for:.
	self assert: flux = node flux. 
	self assert: topicID = node topic.
	self assert: typeName = node type.
	self assert: flux adapter  = PhaROSTopicFlux defaultAdapter adaptToAdapter.
	self assert: flux condition  = PhaROSTopicFlux defaultConditional.
	self assert: (flux imInterestedIn: nil from: nil).
	 
	flux callback: [ : msg | rslt := msg ].
	flux  receive: [ 1+ 2 ] from: nil. 
	
	self assert: rslt = 3.



]
