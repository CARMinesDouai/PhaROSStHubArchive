Class {
	#name : #'Sensor_msgsNavSatFix',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> covariance_type_approximated [
	^1

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> covariance_type_diagonal_known [
	^2

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> covariance_type_known [
	^3

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> covariance_type_unknown [
	^0

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> rosMd5Sum [ 
^'2d3a8cd499b9b4a0249fb98fd05cfa48'
]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> rosTypeDefinition [ 
^' int8 COVARIANCE_TYPE_UNKNOWN=0
 int8 COVARIANCE_TYPE_APPROXIMATED=1
 int8 COVARIANCE_TYPE_DIAGONAL_KNOWN=2
 int8 COVARIANCE_TYPE_KNOWN=3
 std_msgs/Header header
 sensor_msgs/NavSatStatus status
 float64 latitude
 float64 longitude
 float64 altitude
 float64[9]  position_covariance
 int8 position_covariance_type
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> rosTypeName [ 
^'sensor_msgs/NavSatFix'
]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> altitude [
	^ self getAt: #altitude. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> altitude: aValue [
	^ self at: #altitude put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Sensor_msgsNavSatStatus new. 
	 self latitude: 0.0. 
	 self longitude: 0.0. 
	 self altitude: 0.0. 
	 self position_covariance:  (OrderedCollection new: 9). 
	 self position_covariance_type: 0. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> latitude [
	^ self getAt: #latitude. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> latitude: aValue [
	^ self at: #latitude put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> longitude [
	^ self getAt: #longitude. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> longitude: aValue [
	^ self at: #longitude put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> position_covariance [
	^ self getAt: #position_covariance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> position_covariance: aValue [
	^ self at: #position_covariance put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> position_covariance_type [
	^ self getAt: #position_covariance_type. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> position_covariance_type: aValue [
	^ self at: #position_covariance_type put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> status: aValue [
	^ self at: #status put: aValue. 

]
