Class {
	#name : #'Turtlebot_msgsPanoramaImg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg class >> rosMd5Sum [ 
^'aedf66295b374a7249a786af27aecc87'
]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string pano_id
 float64 latitude
 float64 longitude
 float64 heading
 string geo_tag
 sensor_msgs/Image image
'
]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg class >> rosTypeName [ 
^'turtlebot_msgs/PanoramaImg'
]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> geo_tag [
	^ self getAt: #geo_tag. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> geo_tag: aValue [
	^ self at: #geo_tag put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> heading [
	^ self getAt: #heading. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> heading: aValue [
	^ self at: #heading put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> image [
	^ self getAt: #image. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> image: aValue [
	^ self at: #image put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self pano_id: ''. 
	 self latitude: 0.0. 
	 self longitude: 0.0. 
	 self heading: 0.0. 
	 self geo_tag: ''. 
	 self image: Sensor_msgsImage new. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> latitude [
	^ self getAt: #latitude. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> latitude: aValue [
	^ self at: #latitude put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> longitude [
	^ self getAt: #longitude. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> longitude: aValue [
	^ self at: #longitude put: aValue. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> pano_id [
	^ self getAt: #pano_id. 

]

{ #category : #'as yet unclassified' }
Turtlebot_msgsPanoramaImg >> pano_id: aValue [
	^ self at: #pano_id put: aValue. 

]
