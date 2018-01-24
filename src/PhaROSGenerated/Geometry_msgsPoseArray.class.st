Class {
	#name : #'Geometry_msgsPoseArray',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray class >> rosMd5Sum [ 
^'916c28c5764443f268b296bb671b9d97'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Pose[] poses
'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray class >> rosTypeName [ 
^'geometry_msgs/PoseArray'
]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self poses: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray >> poses [
	^ self getAt: #poses. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseArray >> poses: aValue [
	^ self at: #poses put: aValue. 

]
