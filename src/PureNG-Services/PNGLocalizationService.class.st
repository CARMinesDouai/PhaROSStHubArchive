"
This service provides 2D localization data. The localization provided usually refers to the origin of the robot frame. This is the middle of the wheels axis for a differential robot, or the middle of rear axle for a car robot.
"
Class {
	#name : #PNGLocalizationService,
	#superclass : #PNGService,
	#category : #'PureNG-Services'
}

{ #category : #constants }
PNGLocalizationService class >> serviceType [ 
	^ 16r8002
]
