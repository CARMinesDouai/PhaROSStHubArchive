Class {
	#name : #ChatterNodelets,
	#superclass : #PhaROSStaticNodelet,
	#category : #'ChatterPackage-Nodelets'
}

{ #category : #'as yet unclassified' }
ChatterNodelets >> listener [
	^ ChatterListener for: ((self controller node buildConnectionFor:  '/chat/channel') typedAs: 'std_msgs/String' ; connect ).
]

{ #category : #'as yet unclassified' }
ChatterNodelets >> talker [
	^ ChatterTalker for: (self controller node topicPublisher: '/chat/channel' typedAs: 'std_msgs/String').
]
