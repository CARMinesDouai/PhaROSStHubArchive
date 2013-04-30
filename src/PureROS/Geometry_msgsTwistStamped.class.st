Class {
	#name : #'Geometry_msgsTwistStamped',
	#superclass : #PhaROSValue,
	#category : #'PureROS-PhaROSTypes'
}

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self twist: Geometry_msgsTwist new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTwistStamped >> twist: aValue [
	^ self at: #twist put: aValue. 

]
