Class {
	#name : #Imu3DVector,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'covarianceAccumulator'
	],
	#category : #ImusensorsPackage
}

{ #category : #'instance-creation' }
Imu3DVector class >> new [
	^(self new: 3)
		initialize;
		yourself
]

{ #category : #'instance-creation' }
Imu3DVector class >> x: x y: y z: z [
	^self new
		x: x y: y z: z;
		yourself
]

{ #category : #'instance-creation' }
Imu3DVector class >> zero [
	^self x: 0 y: 0 z: 0
]

{ #category : #accessing }
Imu3DVector >> covarianceFloatArray [
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
Imu3DVector >> covarianceMatrix [
	^covarianceAccumulator covarianceMatrix
]

{ #category : #'initialize - release' }
Imu3DVector >> initialize [
	super initialize.
	covarianceAccumulator := DhbCovarianceAccumulator new: 3
]

{ #category : #accessing }
Imu3DVector >> x [
	^self at: 1
]

{ #category : #accessing }
Imu3DVector >> x: newX y: newY z: newZ [
	self at: 1 put: newX.
	self at: 2 put: newY.
	self at: 3 put: newZ.
	covarianceAccumulator accumulate: self
]

{ #category : #accessing }
Imu3DVector >> y [
	^self at: 2
]

{ #category : #accessing }
Imu3DVector >> z [
	^self at: 3
]
