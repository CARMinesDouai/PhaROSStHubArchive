Class {
	#name : #Vector3DWithConvariance,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'covarianceAccumulator'
	],
	#category : #ImusensorsPackage
}

{ #category : #'instance-creation' }
Vector3DWithConvariance class >> new [
	^(self new: 3)
		initialize;
		yourself
]

{ #category : #'instance-creation' }
Vector3DWithConvariance class >> x: x y: y z: z [
	^self new
		x: x y: y z: z;
		yourself
]

{ #category : #'instance-creation' }
Vector3DWithConvariance class >> zero [
	^self x: 0 y: 0 z: 0
]

{ #category : #accessing }
Vector3DWithConvariance >> covarianceFloatArray [
	| array arrayIndex |
	array := Array new: 9.
	arrayIndex := 1.
	self covarianceMatrix rowsDo: [ :row | 
		row do: [ : element |
			array at: arrayIndex put: element asFloat.
			arrayIndex := arrayIndex + 1.
		]
	].
	^array
]

{ #category : #accessing }
Vector3DWithConvariance >> covarianceMatrix [
	^covarianceAccumulator covarianceMatrix
]

{ #category : #'initialize - release' }
Vector3DWithConvariance >> initialize [
	super initialize.
	covarianceAccumulator := DhbCovarianceAccumulator new: 3
]

{ #category : #accessing }
Vector3DWithConvariance >> x [
	^self at: 1
]

{ #category : #accessing }
Vector3DWithConvariance >> x: newX y: newY z: newZ [
	self at: 1 put: newX.
	self at: 2 put: newY.
	self at: 3 put: newZ.
	covarianceAccumulator accumulate: self
]

{ #category : #accessing }
Vector3DWithConvariance >> y [
	^self at: 2
]

{ #category : #accessing }
Vector3DWithConvariance >> z [
	^self at: 3
]
