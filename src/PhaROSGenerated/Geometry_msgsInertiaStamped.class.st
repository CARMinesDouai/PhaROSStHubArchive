Class {
	#name : #'Geometry_msgsInertiaStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped >> inertia [
	^ self getAt: #inertia. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped >> inertia: aValue [
	^ self at: #inertia put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsInertiaStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self inertia: Geometry_msgsInertia new. 

]
