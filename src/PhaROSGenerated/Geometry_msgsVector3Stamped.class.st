Class {
	#name : #'Geometry_msgsVector3Stamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self vector: Geometry_msgsVector3 new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped >> vector [
	^ self getAt: #vector. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3Stamped >> vector: aValue [
	^ self at: #vector put: aValue. 

]
