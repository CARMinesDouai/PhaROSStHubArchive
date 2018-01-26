Class {
	#name : #'Stdr_msgsThermalSource',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource class >> rosMd5Sum [ 
^'b732f325d4ba0a2977192d50dca59310'
]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource class >> rosTypeDefinition [ 
^' string id
 float32 degrees
 geometry_msgs/Pose2D pose
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource class >> rosTypeName [ 
^'stdr_msgs/ThermalSource'
]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource class >> typeCreationOrder [ 
^363
]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource >> degrees [
	^ self getAt: #degrees. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource >> degrees: aValue [
	^ self at: #degrees put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource >> initialize [
	super initialize.
	 self id: ''. 
	 self degrees: 0.0. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSource >> pose: aValue [
	^ self at: #pose put: aValue. 

]
