Class {
	#name : #'Sensor_msgsRegionOfInterest',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> do_rectify [
	^ self getAt: #do_rectify. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> do_rectify: aValue [
	^ self at: #do_rectify put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> height [
	^ self getAt: #height. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> height: aValue [
	^ self at: #height put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> initialize [
	super initialize.
	 self x_offset: 0. 
	 self y_offset: 0. 
	 self height: 0. 
	 self width: 0. 
	 self do_rectify: false. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> width [
	^ self getAt: #width. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> width: aValue [
	^ self at: #width put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> x_offset [
	^ self getAt: #x_offset. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> x_offset: aValue [
	^ self at: #x_offset put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> y_offset [
	^ self getAt: #y_offset. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsRegionOfInterest >> y_offset: aValue [
	^ self at: #y_offset put: aValue. 

]
