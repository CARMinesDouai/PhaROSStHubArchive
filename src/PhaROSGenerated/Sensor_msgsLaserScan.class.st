Class {
	#name : #'Sensor_msgsLaserScan',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan class >> rosMd5Sum [ 
^'90c7ef2dc6895d81024acba2ac42f369'
]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float32 angle_min
 float32 angle_max
 float32 angle_increment
 float32 time_increment
 float32 scan_time
 float32 range_min
 float32 range_max
 float32[] ranges
 float32[] intensities
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan class >> rosTypeName [ 
^'sensor_msgs/LaserScan'
]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> angle_increment [
	^ self getAt: #angle_increment. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> angle_increment: aValue [
	^ self at: #angle_increment put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> angle_max [
	^ self getAt: #angle_max. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> angle_max: aValue [
	^ self at: #angle_max put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> angle_min [
	^ self getAt: #angle_min. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> angle_min: aValue [
	^ self at: #angle_min put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> initialize [
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
Sensor_msgsLaserScan >> intensities [
	^ self getAt: #intensities. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> intensities: aValue [
	^ self at: #intensities put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> range_max [
	^ self getAt: #range_max. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> range_max: aValue [
	^ self at: #range_max put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> range_min [
	^ self getAt: #range_min. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> range_min: aValue [
	^ self at: #range_min put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> ranges [
	^ self getAt: #ranges. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> ranges: aValue [
	^ self at: #ranges put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> scan_time [
	^ self getAt: #scan_time. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> scan_time: aValue [
	^ self at: #scan_time put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> time_increment [
	^ self getAt: #time_increment. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserScan >> time_increment: aValue [
	^ self at: #time_increment put: aValue. 

]
