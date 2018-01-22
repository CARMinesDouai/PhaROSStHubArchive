Class {
	#name : #'Stereo_msgsDisparityImage',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage class >> rosTypeDefinition [ 
^' std_msgs/Header header
 sensor_msgs/Image image
 float32 f
 float32 T
 sensor_msgs/RegionOfInterest valid_window
 float32 min_disparity
 float32 max_disparity
 float32 delta_d
'
]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage class >> rosTypeName [ 
^'stereo_msgs/DisparityImage'
]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> T [
	^ self getAt: #T. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> T: aValue [
	^ self at: #T put: aValue. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> delta_d [
	^ self getAt: #delta_d. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> delta_d: aValue [
	^ self at: #delta_d put: aValue. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> f [
	^ self getAt: #f. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> f: aValue [
	^ self at: #f put: aValue. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> image [
	^ self getAt: #image. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> image: aValue [
	^ self at: #image put: aValue. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self image: Sensor_msgsImage new. 
	 self f: 0.0. 
	 self T: 0.0. 
	 self valid_window: Sensor_msgsRegionOfInterest new. 
	 self min_disparity: 0.0. 
	 self max_disparity: 0.0. 
	 self delta_d: 0.0. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> max_disparity [
	^ self getAt: #max_disparity. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> max_disparity: aValue [
	^ self at: #max_disparity put: aValue. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> min_disparity [
	^ self getAt: #min_disparity. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> min_disparity: aValue [
	^ self at: #min_disparity put: aValue. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> valid_window [
	^ self getAt: #valid_window. 

]

{ #category : #'as yet unclassified' }
Stereo_msgsDisparityImage >> valid_window: aValue [
	^ self at: #valid_window put: aValue. 

]
