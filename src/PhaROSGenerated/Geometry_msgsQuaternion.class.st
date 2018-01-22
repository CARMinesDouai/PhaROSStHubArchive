Class {
	#name : #'Geometry_msgsQuaternion',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternion >> initialize [
	super initialize.
	 self x: 0.0. 
	 self y: 0.0. 
	 self z: 0.0. 
	 self w: 0.0. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternion >> w [
	^ self getAt: #w. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternion >> w: aValue [
	^ self at: #w put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternion >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternion >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternion >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternion >> y: aValue [
	^ self at: #y put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternion >> z [
	^ self getAt: #z. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternion >> z: aValue [
	^ self at: #z put: aValue. 

]
