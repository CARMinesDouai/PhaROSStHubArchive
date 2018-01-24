Class {
	#name : #TurtlesimPose,
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
TurtlesimPose class >> rosMd5Sum [ 
^'863b248d5016ca62ea2e895ae5265cf9'
]

{ #category : #'as yet unclassified' }
TurtlesimPose class >> rosTypeDefinition [ 
^' float32 x
 float32 y
 float32 theta
 float32 linear_velocity
 float32 angular_velocity
'
]

{ #category : #'as yet unclassified' }
TurtlesimPose class >> rosTypeName [ 
^'turtlesim/Pose'
]

{ #category : #'as yet unclassified' }
TurtlesimPose >> angular_velocity [
	^ self getAt: #angular_velocity. 

]

{ #category : #'as yet unclassified' }
TurtlesimPose >> angular_velocity: aValue [
	^ self at: #angular_velocity put: aValue. 

]

{ #category : #'as yet unclassified' }
TurtlesimPose >> initialize [
	super initialize.
	 self x: 0.0. 
	 self y: 0.0. 
	 self theta: 0.0. 
	 self linear_velocity: 0.0. 
	 self angular_velocity: 0.0. 

]

{ #category : #'as yet unclassified' }
TurtlesimPose >> linear_velocity [
	^ self getAt: #linear_velocity. 

]

{ #category : #'as yet unclassified' }
TurtlesimPose >> linear_velocity: aValue [
	^ self at: #linear_velocity put: aValue. 

]

{ #category : #'as yet unclassified' }
TurtlesimPose >> theta [
	^ self getAt: #theta. 

]

{ #category : #'as yet unclassified' }
TurtlesimPose >> theta: aValue [
	^ self at: #theta put: aValue. 

]

{ #category : #'as yet unclassified' }
TurtlesimPose >> x [
	^ self getAt: #x. 

]

{ #category : #'as yet unclassified' }
TurtlesimPose >> x: aValue [
	^ self at: #x put: aValue. 

]

{ #category : #'as yet unclassified' }
TurtlesimPose >> y [
	^ self getAt: #y. 

]

{ #category : #'as yet unclassified' }
TurtlesimPose >> y: aValue [
	^ self at: #y put: aValue. 

]
