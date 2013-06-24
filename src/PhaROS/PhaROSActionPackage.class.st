Class {
	#name : #PhaROSActionPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'clients',
		'servers'
	],
	#category : #'PhaROS-Packages-Action'
}

{ #category : #'as yet unclassified' }
PhaROSActionPackage >> clientFor: anAction [
	^ clients at: anAction ifAbsentPut: [ PhaROSActionClient for: anAction ].
]

{ #category : #'as yet unclassified' }
PhaROSActionPackage >> initialize [ 
	clients := Dictionary new.
	servers := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSActionPackage >> serverFor: anAction [
	^ servers at: anAction ifAbsentPut: [ PhaROSActionServer for: anAction ].
]
