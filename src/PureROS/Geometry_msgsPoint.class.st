Class {
	#name : #'Geometry_msgsPoint',
	#superclass : #PhaROSValue,
	#category : #'PureROS-PhaROSTypes'
}

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> initialize [
	super initialize.
	 self x: 0.0. 
	 self y: 0.0. 
	 self z: 0.0. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> y: aValue [
	^ self at: #y put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> z [
	^ self getAt: #z. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsPoint >> z: aValue [
	^ self at: #z put: aValue. 

]
