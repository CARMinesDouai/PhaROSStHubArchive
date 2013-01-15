"
This service exposes a differential robot. A differential robot is controlled through a linear speed and an angular speed. The linear speed component is obtained by applying the same speed to the left and right wheels. The angular speed component is obtained by applying speeds with opposite signs on the left and right wheels.
"
Class {
	#name : #PNGDifferentialService,
	#superclass : #PNGService,
	#category : #'PureNG-Kernel'
}

{ #category : #constants }
PNGDifferentialService class >> serviceType [ 
	^ 16r4005
]
