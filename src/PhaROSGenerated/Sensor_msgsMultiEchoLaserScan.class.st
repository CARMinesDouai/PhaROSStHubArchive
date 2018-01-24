Class {
	#name : #'Sensor_msgsMultiEchoLaserScan',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan class >> rosMd5Sum [ 
^'6fefb0c6da89d7c8abe4b339f5c2f8fb'
]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float32 angle_min
 float32 angle_max
 float32 angle_increment
 float32 time_increment
 float32 scan_time
 float32 range_min
 float32 range_max
 sensor_msgs/LaserEcho[] ranges
 sensor_msgs/LaserEcho[] intensities
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan class >> rosTypeName [ 
^'sensor_msgs/MultiEchoLaserScan'
]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> angle_increment [
	^ self getAt: #angle_increment. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> angle_increment: aValue [
	^ self at: #angle_increment put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> angle_max [
	^ self getAt: #angle_max. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> angle_max: aValue [
	^ self at: #angle_max put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> angle_min [
	^ self getAt: #angle_min. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> angle_min: aValue [
	^ self at: #angle_min put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self angle_min: 0.0. 
	 self angle_max: 0.0. 
	 self angle_increment: 0.0. 
	 self time_increment: 0.0. 
	 self scan_time: 0.0. 
	 self range_min: 0.0. 
	 self range_max: 0.0. 
	 self ranges: OrderedCollection new . 
	 self intensities: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> intensities [
	^ self getAt: #intensities. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> intensities: aValue [
	^ self at: #intensities put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> range_max [
	^ self getAt: #range_max. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> range_max: aValue [
	^ self at: #range_max put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> range_min [
	^ self getAt: #range_min. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> range_min: aValue [
	^ self at: #range_min put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> ranges [
	^ self getAt: #ranges. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> ranges: aValue [
	^ self at: #ranges put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> scan_time [
	^ self getAt: #scan_time. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> scan_time: aValue [
	^ self at: #scan_time put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> time_increment [
	^ self getAt: #time_increment. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiEchoLaserScan >> time_increment: aValue [
	^ self at: #time_increment put: aValue. 

]
