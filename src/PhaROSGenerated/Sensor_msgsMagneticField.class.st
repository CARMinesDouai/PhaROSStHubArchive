Class {
	#name : #'Sensor_msgsMagneticField',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField class >> rosMd5Sum [ 
^'2f3b0b43eed0c9501de0fa3ff89a45aa'
]

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField class >> rosTypeDefinition [ 
^' std_msgs/Header header
 geometry_msgs/Vector3 magnetic_field
 float64[9]  magnetic_field_covariance
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField class >> rosTypeName [ 
^'sensor_msgs/MagneticField'
]

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField class >> typeCreationOrder [ 
^272
]

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self magnetic_field: Geometry_msgsVector3 new. 
	 self magnetic_field_covariance:  (OrderedCollection new: 9). 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField >> magnetic_field [
	^ self getAt: #magnetic_field. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField >> magnetic_field: aValue [
	^ self at: #magnetic_field put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField >> magnetic_field_covariance [
	^ self getAt: #magnetic_field_covariance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMagneticField >> magnetic_field_covariance: aValue [
	^ self at: #magnetic_field_covariance put: aValue. 

]
