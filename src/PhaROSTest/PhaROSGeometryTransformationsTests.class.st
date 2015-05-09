Class {
	#name : #PhaROSGeometryTransformationsTests,
	#superclass : #TestCase,
	#category : #'PhaROSTest-Util'
}

{ #category : #tests }
PhaROSGeometryTransformationsTests >> testPositionRotation [
	| position rotation |
	position := PhaROSPosition x: 1 y: 1  z:0.
	
	rotation := (position rotate: Float pi / 4 ) + (position rotate: (Float pi / 4) + (Float pi /2 )).
	self assert: ((rotation x truncateTo: 0.01) = (-1 * (2 sqrt ) truncateTo: 0.01) ).
	self assert: ((rotation y truncateTo: 0.01) = ( (2 sqrt ) truncateTo: 0.01) ).

	 
	rotation := (position rotate: Float pi / 4 ) + (position rotate: (Float pi / 4) + (Float pi)).
	self assert: (rotation x truncateTo: 0.01) = 0.0.
	self assert: (rotation y truncateTo: 0.01) = 0.0.
	
]

{ #category : #tests }
PhaROSGeometryTransformationsTests >> testQuaternionAsRPY [
	| ang |
	<expectedFailure>
	ang := PhaROSQuaternion zero asRPY .
	
	self assert: ang roll = 0.0.
	self assert: ang pitch = 0.0.
	self assert: ang yaw = 0.0.	
	

	

	ang := (PhaROSQuaternion x: 0.0 y: 0.001 z: 0.0 w: -1.0) asRPY.
	
	self assert: ang roll = Float pi.
	self assert: ang pitch = Float pi.
	self assert: ang yaw = Float pi.	
	

	
]

{ #category : #tests }
PhaROSGeometryTransformationsTests >> testRPYAsQuaternion [
	| ang |
	
	ang := PhaROSRPYOrientation zero asQuaternion  .
	
	self assert: ang x = 0.0.
	self assert: ang y = 0.0.
	self assert: ang z = 0.0.	
	self assert: ang w = 1.0.
	

	ang := (PhaROSRPYOrientation roll: Float pi pitch: Float pi  yaw: Float pi ) asQuaternion .
	
	self assert: ang x = 0.0.
	self assert: ang y = 0.001.
	self assert: ang z = 0.0.	
	self assert: ang w = -1.0.
	
]

{ #category : #tests }
PhaROSGeometryTransformationsTests >> testTransformation [
	| util |
	util := PhaROSGeometryTransformations new.
	(util  quaternationFromEulerFor: 0.0 and: 0.0 and: 0.0 ) with: #(0.0 0.0 0.0 1.0) do: [ :a :b | self assert: (a closeTo: b)].
	(util  quaternationFromEulerFor: 1.0 and: 0.0 and: 0.0 ) with: #(0.48 0.0 0.0 0.878) do: [ :a :b | self assert: (a closeTo: b)].
	(util  quaternationFromEulerFor: 0.0 and: 1.0 and: 0.0 ) with: #(0.0 -0.47900000000000004 0.0 0.878) do: [ :a :b | self assert: (a closeTo: b)].
	(util  quaternationFromEulerFor: 0.0 and: 0.0 and: 1.0 ) with: #(0.0 0.0 0.48 0.878) do: [ :a :b | self assert: (a closeTo: b)].
	(util  quaternationFromEulerFor: 1.0 and: 0.0 and: 1.0 ) with: #(0.421 0.23 0.421 0.771) do: [ :a :b | self assert: (a closeTo: b)].
	(util  quaternationFromEulerFor: 1.0 and: 1.0 and: 0.0 ) with: #(0.421 -0.42 -0.229 0.771) do: [ :a :b | self assert: (a closeTo: b)].
	(util  quaternationFromEulerFor: 0.0 and: 1.0 and: 1.0 ) with: #(-0.229 -0.42 0.421 0.771) do: [ :a :b | self assert: (a closeTo: b)].
	(util  quaternationFromEulerFor: 1.0 and: 1.0 and: 1.0 ) with: #(0.168 -0.167 0.168 0.5660000000000001) do: [ :a :b | self assert: (a closeTo: b)].
	


]

{ #category : #tests }
PhaROSGeometryTransformationsTests >> testTransformationBack [
	| util |
	<expectedFailure>
	util := PhaROSGeometryTransformations new.
	#(0.0  0.0  0.0) with: (util eulerFromQuaternation:#(0.0 0.0 0.0 1.0) ) do: [ :a :b | self assert: (a closeTo: b)].
	#(0.0  0.0  1.0006) with: (util eulerFromQuaternation:#(0.0 0.0 0.48 0.878) ) do: [ :a :b | self assert: (a closeTo: b)].
	#(1.0006  0.0  0.0) with: (util eulerFromQuaternation:#(0.48 0.0 0.0 0.878) ) do: [ :a :b | self assert: (a closeTo: b)].
	#(0.0  1.0  0.0) with: (util eulerFromQuaternation:#(0.0 -0.47900000000000004 0.0 0.878) ) do: [ :a :b | self assert: (a closeTo: b)].
	#(1.0  0.0  1.0) with: (util eulerFromQuaternation:#(0.421 0.23 0.421 0.771) ) do: [ :a :b | self assert: (a closeTo: b)].
	#(1.0  1.0  0.0) with: (util eulerFromQuaternation:#(0.421 -0.42 -0.229 0.771) ) do: [ :a :b | self assert: (a closeTo: b)].
	#(0.0  1.0  1.0) with: (util eulerFromQuaternation:#(-0.229 -0.42 0.421 0.771) ) do: [ :a :b | self assert: (a closeTo: b)].
	#(1.0  1.0  1.0) with: (util eulerFromQuaternation:#(0.168 -0.167 0.168 0.5660000000000001) ) do: [ :a :b | self assert: (a closeTo: b)].
	


]
