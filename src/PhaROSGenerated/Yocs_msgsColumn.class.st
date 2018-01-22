Class {
	#name : #'Yocs_msgsColumn',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> initialize [
	super initialize.
	 self name: ''. 
	 self radius: 0.0. 
	 self height: 0.0. 
	 self pose: Geometry_msgsPoseWithCovarianceStamped new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> radius [
	^ self getAt: #radius. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsColumn >> radius: aValue [
	^ self at: #radius put: aValue. 

]
