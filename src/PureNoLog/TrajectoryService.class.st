Class {
	#name : #TrajectoryService,
	#superclass : #RobulabService,
	#category : #'PureNoLog-Services'
}

{ #category : #'as yet unclassified' }
TrajectoryService >> limitSpeed: aSpeed [
	^ 2.0 min: aSpeed.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> load: aConnector [

	|  decoder |

"	decoder := (self getWith: aConnector) decoder."
]

{ #category : #'as yet unclassified' }
TrajectoryService >> moveFrom: aPoint to: anOtherPoint with: aSpeed [
	| x1 y1 x2 y2 speed encoder|
	
	
	
	" 32 * 4 spaces for the 64bits float. 16 for the only one 32 bit float "
	
	encoder := PureEncoder forArray: (String new: (32 * 4 + 16)).
	
	encoder encodefloat64: aPoint x.
	encoder encodefloat64: aPoint y.
	encoder encodefloat64: anOtherPoint x.
	encoder encodefloat64: anOtherPoint y.
	
	encoder encodefloat32: aSpeed.
	
	

	self insert: encoder contents.
]

{ #category : #'as yet unclassified' }
TrajectoryService >> pause [
	self upDate: '2'.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> relatedNotificationClass [
	^ TrajectoryNotification
]

{ #category : #'as yet unclassified' }
TrajectoryService >> reset [
	self upDate: '3'.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> resetDistance [
	self upDate: '5'.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> resetPath [
	self upDate: '4'.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> status [
	^ self get.
	
]

{ #category : #'as yet unclassified' }
TrajectoryService >> stop [
	self upDate: '0'.
	
]
