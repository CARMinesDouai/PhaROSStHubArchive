Class {
	#name : #'Geometry_msgsWrenchStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsWrenchStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrenchStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrenchStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self wrench: Geometry_msgsWrench new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrenchStamped >> wrench [
	^ self getAt: #wrench. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsWrenchStamped >> wrench: aValue [
	^ self at: #wrench put: aValue. 

]
