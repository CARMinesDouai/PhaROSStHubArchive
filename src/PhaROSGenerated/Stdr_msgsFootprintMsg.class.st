Class {
	#name : #'Stdr_msgsFootprintMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg class >> rosMd5Sum [ 
^'85abf3c88ffa720da1b02b0368d5d55e'
]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg class >> rosTypeDefinition [ 
^' geometry_msgs/Point[] points
 float32 radius
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg class >> rosTypeName [ 
^'stdr_msgs/FootprintMsg'
]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg class >> typeCreationOrder [ 
^331
]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg >> initialize [
	super initialize.
	 self points: OrderedCollection new . 
	 self radius: 0.0. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg >> points [
	^ self getAt: #points. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg >> points: aValue [
	^ self at: #points put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg >> radius [
	^ self getAt: #radius. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsFootprintMsg >> radius: aValue [
	^ self at: #radius put: aValue. 

]
