Class {
	#name : #PhaROSActionNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'clients',
		'servers'
	],
	#category : #'PhaROS-Nodelets-Action'
}

{ #category : #'as yet unclassified' }
PhaROSActionNodelet >> clientFor: anAction [
	^ clients at: anAction ifAbsentPut: [ PhaROSActionClient for: anAction ].
]

{ #category : #'as yet unclassified' }
PhaROSActionNodelet >> initialize [ 
	clients := Dictionary new.
	servers := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSActionNodelet >> serverFor: anAction [
	^ servers at: anAction ifAbsentPut: [ PhaROSActionServer for: anAction ].
]
