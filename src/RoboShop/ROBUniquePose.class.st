Class {
	#name : #ROBUniquePose,
	#superclass : #Object,
	#instVars : [
		'id',
		'point',
		'orientation'
	],
	#category : #'RoboShop-Lab-Places'
}

{ #category : #constructor }
ROBUniquePose class >> point: aPoint orientation: anOrientation id: anID [
	^ self new point: aPoint; orientation: anOrientation; id: anID; yourself.
]

{ #category : #'as yet unclassified' }
ROBUniquePose >> asDump [
 
	^ ' ROBUniquePose point: ({1}) orientation: {2} id: {3}' format: { ((point at: #x)roundUpTo: 0.001) @ ((point at:#y) roundUpTo: 0.0001). (orientation at:#z)roundUpTo: 0.0001 . id }
]

{ #category : #accessing }
ROBUniquePose >> id [
	^ id
]

{ #category : #'as yet unclassified' }
ROBUniquePose >> id: anID [
	id := anID.
	
]

{ #category : #accessing }
ROBUniquePose >> orientation [
	^ orientation
]

{ #category : #'as yet unclassified' }
ROBUniquePose >> orientation: anOrientation [
	orientation := anOrientation
]

{ #category : #accessing }
ROBUniquePose >> point [
	^ point
]

{ #category : #'as yet unclassified' }
ROBUniquePose >> point: aPoint [
	point := aPoint
]
