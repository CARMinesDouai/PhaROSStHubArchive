"
I emulate PhaROSSystemInfo behavior for testing purposes.
"
Class {
	#name : #PhaROSSystemInfoMock,
	#superclass : #Object,
	#instVars : [
		'nodeDict'
	],
	#category : #'PhaROSDashBoard-Mocks'
}

{ #category : #'as yet unclassified' }
PhaROSSystemInfoMock >> getNode: aString [

	^ nodeDict at: aString
]

{ #category : #'as yet unclassified' }
PhaROSSystemInfoMock >> infoOfNode: aNodeName [

	^ (self getNode: aNodeName) info
]

{ #category : #'as yet unclassified' }
PhaROSSystemInfoMock >> initialize [

	super initialize.
	nodeDict := {'/rosout' -> PDRosoutNode new . '/turtlesim' -> PDTurtlesimNode new} asDictionary.
	
]

{ #category : #'as yet unclassified' }
PhaROSSystemInfoMock >> killNode: aNodeName [

	(self getNode: aNodeName) kill.
	^  'killing ',aNodeName,'
killed'
]

{ #category : #'as yet unclassified' }
PhaROSSystemInfoMock >> nodeList [

	^ (nodeDict values select: #isAlive) collect: #asString
]

{ #category : #'as yet unclassified' }
PhaROSSystemInfoMock >> pingNode: aString [

	^ (self getNode: aString) ping
]

{ #category : #'as yet unclassified' }
PhaROSSystemInfoMock >> topicList [

	^ (nodeDict values select: #isAlive) flatCollect: #topics
]
