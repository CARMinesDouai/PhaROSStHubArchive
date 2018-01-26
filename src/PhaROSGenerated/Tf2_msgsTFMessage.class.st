Class {
	#name : #'Tf2_msgsTFMessage',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsTFMessage class >> rosMd5Sum [ 
^'94810edda583a504dfda3829e70d7eec'
]

{ #category : #'as yet unclassified' }
Tf2_msgsTFMessage class >> rosTypeDefinition [ 
^' geometry_msgs/TransformStamped[] transforms
'
]

{ #category : #'as yet unclassified' }
Tf2_msgsTFMessage class >> rosTypeName [ 
^'tf2_msgs/TFMessage'
]

{ #category : #'as yet unclassified' }
Tf2_msgsTFMessage class >> typeCreationOrder [ 
^375
]

{ #category : #'as yet unclassified' }
Tf2_msgsTFMessage >> initialize [
	super initialize.
	 self transforms: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Tf2_msgsTFMessage >> transforms [
	^ self getAt: #transforms. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsTFMessage >> transforms: aValue [
	^ self at: #transforms put: aValue. 

]
