Class {
	#name : #'Turtlebot_calibrationScanAngle',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_calibrationScanAngle class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float64 scan_angle
'
]

{ #category : #'as yet unclassified' }
Turtlebot_calibrationScanAngle class >> rosTypeName [ 
^'turtlebot_calibration/ScanAngle'
]

{ #category : #'as yet unclassified' }
Turtlebot_calibrationScanAngle >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtlebot_calibrationScanAngle >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_calibrationScanAngle >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self scan_angle: 0.0. 

]

{ #category : #'as yet unclassified' }
Turtlebot_calibrationScanAngle >> scan_angle [
	^ self getAt: #scan_angle. 

]

{ #category : #'as yet unclassified' }
Turtlebot_calibrationScanAngle >> scan_angle: aValue [
	^ self at: #scan_angle put: aValue. 

]
