Class {
	#name : #'Sensor_msgsNavSatStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus class >> rosTypeDefinition [ 
^' int8 STATUS_NO_FIX=-1
 int8 STATUS_FIX=0
 int8 STATUS_SBAS_FIX=1
 int8 STATUS_GBAS_FIX=2
 uint16 SERVICE_GPS=1
 uint16 SERVICE_GLONASS=2
 uint16 SERVICE_COMPASS=4
 uint16 SERVICE_GALILEO=8
 int8 status
 uint16 service
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus class >> rosTypeName [ 
^'sensor_msgs/NavSatStatus'
]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus class >> service_compass [
	^4

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus class >> service_galileo [
	^8

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus class >> service_glonass [
	^2

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus class >> service_gps [
	^1

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus class >> status_fix [
	^0

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus class >> status_gbas_fix [
	^2

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus class >> status_no_fix [
	^-1

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus class >> status_sbas_fix [
	^1

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus >> initialize [
	super initialize.
	 self status: 0. 
	 self service: 0. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus >> service [
	^ self getAt: #service. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus >> service: aValue [
	^ self at: #service put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatStatus >> status: aValue [
	^ self at: #status put: aValue. 

]
