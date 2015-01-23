"
A PhaROSLastSubscriptionValue is an object that subscribes to a ROS topic and holds on to the last message received from that topic.

See class side for instantiation. The last message received is in the 'value' instvar.
"
Class {
	#name : #PhaROSLastSubscriptionValue,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'PhaROS-Util'
}

{ #category : #'instance creation' }
PhaROSLastSubscriptionValue class >> onTopic: aPhaROSTopicString ofType: aTypeString forNode: aPackageObject [

	" to be called inside a PackageObject like this:
		PhaROSLastSubscriptionValue onTopic: '/example/string' ofType: 'std_msgs/String' forNode: self.
	 "
	| inst |
	inst := self new.
	(aPackageObject controller node buildConnectionFor: aPhaROSTopicString ) 
			typedAs: aTypeString; 
			for: [ :msg | inst value: msg ];
			connect .
	^inst
]

{ #category : #accesing }
PhaROSLastSubscriptionValue >> value [
	^value
]

{ #category : #accesing }
PhaROSLastSubscriptionValue >> value: anObject [
	value := anObject
]
