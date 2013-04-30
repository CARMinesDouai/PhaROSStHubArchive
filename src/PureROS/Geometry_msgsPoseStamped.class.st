Class {
	#name : #'Geometry_msgsPoseStamped',
	#superclass : #PhaROSValue,
	#category : #'PureROS-PhaROSTypes'
}

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self pose: Geometry_msgsPose new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoseStamped >> pose: aValue [
	^ self at: #pose put: aValue. 

]
