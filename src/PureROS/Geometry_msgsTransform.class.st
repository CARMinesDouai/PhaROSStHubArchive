Class {
	#name : #'Geometry_msgsTransform',
	#superclass : #PhaROSValue,
	#category : #'PureROS-PhaROSTypes'
}

{ #category : #'as yet unclassified' }
Geometry_msgsTransform >> initialize [
	super initialize.
	 self translation: Geometry_msgsVector3 new. 
	 self rotation: Geometry_msgsQuaternion new. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransform >> rotation [
	^ self getAt: #rotation. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransform >> rotation: aValue [
	^ self at: #rotation put: aValue. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransform >> translation [
	^ self getAt: #translation. 

]

{ #category : #'as yet unclassified' }
Geometry_msgsTransform >> translation: aValue [
	^ self at: #translation put: aValue. 

]
