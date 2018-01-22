Class {
	#name : #'Geometry_msgsQuaternionStamped',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self quaternion: Geometry_msgsQuaternion new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped >> quaternion [
	^ self getAt: #quaternion. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsQuaternionStamped >> quaternion: aValue [
	^ self at: #quaternion put: aValue. 

]
