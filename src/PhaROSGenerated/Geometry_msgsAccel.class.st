Class {
	#name : #'Geometry_msgsAccel',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsAccel >> angular [
	^ self getAt: #angular. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccel >> angular: aValue [
	^ self at: #angular put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccel >> initialize [
	super initialize.
	 self linear: Geometry_msgsVector3 new. 
	 self angular: Geometry_msgsVector3 new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccel >> linear [
	^ self getAt: #linear. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsAccel >> linear: aValue [
	^ self at: #linear put: aValue. 

]
