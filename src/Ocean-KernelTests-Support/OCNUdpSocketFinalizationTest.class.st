Class {
	#name : #OCNUdpSocketFinalizationTest,
	#superclass : #OCNSocketFinalizationTest,
	#category : #'Ocean-KernelTests'
}

{ #category : #'as yet unclassified' }
OCNUdpSocketFinalizationTest class >> shouldBeSubclassedForBackendTesting [
	^true
]

{ #category : #accessing }
OCNUdpSocketFinalizationTest >> socketClass [
	^OCNUdpSocketForFinalizationTest
]

{ #category : #accessing }
OCNUdpSocketFinalizationTest >> stateTestingSelectors [ 
	^#(isClean isBound isDestroyed)
]
