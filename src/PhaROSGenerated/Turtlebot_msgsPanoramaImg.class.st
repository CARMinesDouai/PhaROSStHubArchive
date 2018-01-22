Class {
	#name : #'Turtlebot_msgsPanoramaImg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
