Class {
	#name : #TftfMessage,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
TftfMessage class >> rosTypeDefinition [ 
^' geometry_msgs/TransformStamped[] transforms
'
]

{ #category : #'as yet unclassified' }
TftfMessage class >> rosTypeName [ 
^'tf/tfMessage'
]

{ #category : #'as yet unclassified' }
TftfMessage >> initialize [
	super initialize.
	 self transforms: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
TftfMessage >> transforms [
	^ self getAt: #transforms. 

]

{ #category : #'as yet unclassified' }
TftfMessage >> transforms: aValue [
	^ self at: #transforms put: aValue. 

]
