Class {
	#name : #'Nav_msgsPath',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsPath class >> rosMd5Sum [ 
^'6227e2b7e9cce15051f669a5e197bbf7'
]

{ #category : #'as yet unclassified' }
Nav_msgsPath class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/PoseStamped[] poses
'
]

{ #category : #'as yet unclassified' }
Nav_msgsPath class >> rosTypeName [ 
^'nav_msgs/Path'
]

{ #category : #'as yet unclassified' }
Nav_msgsPath class >> typeCreationOrder [ 
^207
]

{ #category : #'as yet unclassified' }
Nav_msgsPath >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Nav_msgsPath >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsPath >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self poses: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Nav_msgsPath >> poses [
	^ self getAt: #poses. 

]

{ #category : #'as yet unclassified' }
Nav_msgsPath >> poses: aValue [
	^ self at: #poses put: aValue. 

]
