Class {
	#name : #SGROSPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'rosnode'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #'as yet unclassified' }
SGROSPackage >> configure: aNode [
	rosnode := aNode.
]

{ #category : #'as yet unclassified' }
SGROSPackage >> landmarkTopic [
	^ '/stargazer/landmark'
]

{ #category : #'as yet unclassified' }
SGROSPackage >> landmarkTopicType [
	^  'pharos/SGLandMark'
]
