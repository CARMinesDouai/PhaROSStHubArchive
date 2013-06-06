Class {
	#name : #PhaROSTransformationPackage,
	#superclass : #PhaROSStaticPackage,
	#instVars : [
		'rosnode',
		'db',
		'interested',
		'messages'
	],
	#category : #'PhaROS-Packages-TF'
}

{ #category : #'as yet unclassified' }
PhaROSTransformationPackage >> configure: aNode [
	rosnode := aNode.
	self consumeTF.
	
]

{ #category : #'as yet unclassified' }
PhaROSTransformationPackage >> consumeTF [ 
	| connection |
	connection := rosnode buildConnectionFor: '/tf'.
	connection typedAs: 'tf/tfMessage'; for: [ : msg | db process: msg ].
	connection connect. 
	
]

{ #category : #'as yet unclassified' }
PhaROSTransformationPackage >> initialize [ 

	messages := OrderedCollection new.
	interested := Set new.
]
