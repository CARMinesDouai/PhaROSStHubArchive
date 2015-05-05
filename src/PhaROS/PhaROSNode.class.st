"
http://wiki.ros.org/Nodes
"
Class {
	#name : #PhaROSNode,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'name resolution' }
PhaROSNode >> basename [
	"
	'base_link' copyAfterLast: $/.
	'/kompai2/scan' copyAfterLast: $/.
	"
	^ self name copyAfterLast: $/
]

{ #category : #accessing }
PhaROSNode >> name [
	^ name
]

{ #category : #accessing }
PhaROSNode >> name: aName [
	name := aName

]

{ #category : #'name resolution' }
PhaROSNode >> namespace [
	"
	'base_link' copyUpToLast: $/.
	'/kompai2/scan' copyUpToLast: $/.
	"
	^ self name copyUpToLast: $/
]

{ #category : #'name resolution' }
PhaROSNode >> resolveName: aName [
	(aName first = $/) ifTrue: [ ^ aName ].
	^ self namespace,'/',aName
]
