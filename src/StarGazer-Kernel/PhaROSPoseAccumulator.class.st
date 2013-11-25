Class {
	#name : #PhaROSPoseAccumulator,
	#superclass : #Object,
	#instVars : [
		'px',
		'py',
		'pz',
		'ox',
		'oy',
		'oz',
		'ow',
		'cocient'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #'as yet unclassified' }
PhaROSPoseAccumulator >> accumulate: aPose [ 
	self accumulate: aPose pondered: 1.
]

{ #category : #'as yet unclassified' }
PhaROSPoseAccumulator >> accumulate: aPose pondered: nTimes [

	px := px +(aPose position x * nTimes).
	py := py + (aPose position y * nTimes).
	pz := pz + (aPose position z * nTimes).
	
	
	ox := ox + (aPose orientation x * nTimes).
	oy := oy + (aPose orientation y * nTimes).
	oz := oz + (aPose orientation z * nTimes).
	ow := ow + (aPose orientation w * nTimes).

	cocient := cocient + nTimes.
	
]

{ #category : #'as yet unclassified' }
PhaROSPoseAccumulator >> initialize [ 
	px := py := pz := 0.0. 
	ox := oy := oz := ow := 0.0. 
	cocient := 0.
]

{ #category : #'as yet unclassified' }
PhaROSPoseAccumulator >> value [
	| quaternion position |
	
	position := PhaROSPosition x: px / cocient 
								y: py / cocient 
								z: pz / cocient.
								
	quaternion := PhaROSQuaternion x: ox / cocient
									   y: oy / cocient
 									   z: oz / cocient
									   w: ow / cocient.

	^ (PhaROSPose position: position orientation: quaternion) roundUpTo: 0.001.
]
