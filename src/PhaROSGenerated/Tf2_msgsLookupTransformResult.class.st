Class {
	#name : #'Tf2_msgsLookupTransformResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult class >> rosMd5Sum [ 
^'3fe5db6a19ca9cfb675418c5ad875c36'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult class >> rosTypeDefinition [ 
^' geometry_msgs/TransformStamped transform
 tf2_msgs/TF2Error error
'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult class >> rosTypeName [ 
^'tf2_msgs/LookupTransformResult'
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult class >> typeCreationOrder [ 
^370
]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult >> error [
	^ self getAt: #error. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult >> error: aValue [
	^ self at: #error put: aValue. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult >> initialize [
	super initialize.
	 self transform: Geometry_msgsTransformStamped new. 
	 self error: Tf2_msgsTF2Error new. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult >> transform [
	^ self getAt: #transform. 

]

{ #category : #'as yet unclassified' }
Tf2_msgsLookupTransformResult >> transform: aValue [
	^ self at: #transform put: aValue. 

]
