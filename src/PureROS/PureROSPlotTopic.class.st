"
You just send as method the name of the variable of the topic type. If you want to specify more than one variable in the end (x y z, by example) you send the last message field:{ #x . #y . #z}. 

	



"
Class {
	#name : #PureROSPlotTopic,
	#superclass : #Object,
	#instVars : [
		'filters',
		'topicId',
		'variables'
	],
	#category : #'PureROS-Util'
}

{ #category : #'as yet unclassified' }
PureROSPlotTopic class >> for: aTopicId [
	^ self new topicId: aTopicId ; yourself.
]

{ #category : #'as yet unclassified' }
PureROSPlotTopic >> doesNotUnderstand: aMessage [

	aMessage selector numArgs = 0 ifTrue: [
		filters add: aMessage selector. 		
		^ self.
	].

	super doesNotUnderstand: aMessage.
]

{ #category : #'as yet unclassified' }
PureROSPlotTopic >> fields: anArrayOfFields [
	variables := anArrayOfFields collect: #asString.
	^ self .
]

{ #category : #'as yet unclassified' }
PureROSPlotTopic >> initialize [ 
	filters := OrderedCollection new.
	variables := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
PureROSPlotTopic >> plotLine [
	| topicVar |
	topicVar := filters inject: topicId into: [ : acc : f | acc,'/', f ].
	
	^ variables size > 0 ifTrue: [
		variables allButFirst inject: (topicVar,'/', variables first) into: [ :acc :v | acc,':',v ].	
	] ifFalse:[
		topicVar.
	].
	
	
]

{ #category : #'as yet unclassified' }
PureROSPlotTopic >> topicId: aTopicId [
	topicId := aTopicId 
	
]
