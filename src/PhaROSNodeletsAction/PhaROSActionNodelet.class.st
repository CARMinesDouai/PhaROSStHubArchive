Class {
	#name : #PhaROSActionNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'clients',
		'servers'
	],
	#category : #PhaROSNodeletsAction
}

{ #category : #'as yet unclassified' }
PhaROSActionNodelet class >> actionTypeDefinition [
	^ PhaROSCompositeType named: 'pharos/PhaROSAction' definedBy: {
		#header -> (PhaROSTypeBrowser instance definition: 'std_msgs/Header'). 
		#body -> (PhaROSArrayType ofType: PhaROSUInt8Type new)
	}  withConstants: {}.
]

{ #category : #'as yet unclassified' }
PhaROSActionNodelet class >> types [
	^ { #PhaROSAction -> self actionTypeDefinition }.
]

{ #category : #'as yet unclassified' }
PhaROSActionNodelet >> initialize [ 
	clients := Dictionary new.
	servers := Dictionary new.
]
