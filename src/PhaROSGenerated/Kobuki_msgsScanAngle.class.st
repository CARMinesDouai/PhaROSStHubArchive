Class {
	#name : #'Kobuki_msgsScanAngle',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsScanAngle class >> rosMd5Sum [ 
^'06e2c839dc5c7f5c13ac09a8b4ff0a6a'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsScanAngle class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float64 scan_angle
'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsScanAngle class >> rosTypeName [ 
^'kobuki_msgs/ScanAngle'
]

{ #category : #'as yet unclassified' }
Kobuki_msgsScanAngle class >> typeCreationOrder [ 
^177
]

{ #category : #'as yet unclassified' }
Kobuki_msgsScanAngle >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsScanAngle >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsScanAngle >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self scan_angle: 0.0. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsScanAngle >> scan_angle [
	^ self getAt: #scan_angle. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsScanAngle >> scan_angle: aValue [
	^ self at: #scan_angle put: aValue. 

]
