Class {
	#name : #'Geometry_msgsVector3',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsVector3 >> initialize [
	super initialize.
	 self x: 0.0. 
	 self y: 0.0. 
	 self z: 0.0. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3 >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3 >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3 >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3 >> y: aValue [
	^ self at: #y put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3 >> z [
	^ self getAt: #z. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsVector3 >> z: aValue [
	^ self at: #z put: aValue. 

]
