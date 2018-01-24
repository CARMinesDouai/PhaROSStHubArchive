Class {
	#name : #'Sensor_msgsCameraInfo',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo class >> rosMd5Sum [ 
^'c9a58c1b0b154e0e6da7578cb991d214'
]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo class >> rosTypeDefinition [ 
^' std_msgs/Header header
 int32 height
 int32 width
 string distortion_model
 float64[] D
 float64[9]  K
 float64[9]  R
 float64[12]  P
 int32 binning_x
 int32 binning_y
 sensor_msgs/RegionOfInterest roi
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo class >> rosTypeName [ 
^'sensor_msgs/CameraInfo'
]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> D [
	^ self getAt: #D. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> D: aValue [
	^ self at: #D put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> K [
	^ self getAt: #K. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> K: aValue [
	^ self at: #K put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> P [
	^ self getAt: #P. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> P: aValue [
	^ self at: #P put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> R [
	^ self getAt: #R. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> R: aValue [
	^ self at: #R put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> binning_x [
	^ self getAt: #binning_x. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> binning_x: aValue [
	^ self at: #binning_x put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> binning_y [
	^ self getAt: #binning_y. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> binning_y: aValue [
	^ self at: #binning_y put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> distortion_model [
	^ self getAt: #distortion_model. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> distortion_model: aValue [
	^ self at: #distortion_model put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self height: 0. 
	 self width: 0. 
	 self distortion_model: ''. 
	 self D: OrderedCollection new . 
	 self K:  (OrderedCollection new: 9). 
	 self R:  (OrderedCollection new: 9). 
	 self P:  (OrderedCollection new: 12). 
	 self binning_x: 0. 
	 self binning_y: 0. 
	 self roi: Sensor_msgsRegionOfInterest new. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> roi [
	^ self getAt: #roi. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> roi: aValue [
	^ self at: #roi put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> width [
	^ self getAt: #width. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsCameraInfo >> width: aValue [
	^ self at: #width put: aValue. 

]
