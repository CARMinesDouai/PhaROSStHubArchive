Class {
	#name : #'Sensor_msgsImu',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> angular_velocity [
	^ self getAt: #angular_velocity. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> angular_velocity: aValue [
	^ self at: #angular_velocity put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> angular_velocity_covariance [
	^ self getAt: #angular_velocity_covariance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> angular_velocity_covariance: aValue [
	^ self at: #angular_velocity_covariance put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self orientation: Geometry_msgsQuaternion new. 
	 self orientation_covariance:  (OrderedCollection new: 9). 
	 self angular_velocity: Geometry_msgsVector3 new. 
	 self angular_velocity_covariance:  (OrderedCollection new: 9). 
	 self linear_acceleration: Geometry_msgsVector3 new. 
	 self linear_acceleration_covariance:  (OrderedCollection new: 9). 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> linear_acceleration [
	^ self getAt: #linear_acceleration. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> linear_acceleration: aValue [
	^ self at: #linear_acceleration put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> linear_acceleration_covariance [
	^ self getAt: #linear_acceleration_covariance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> linear_acceleration_covariance: aValue [
	^ self at: #linear_acceleration_covariance put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> orientation [
	^ self getAt: #orientation. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> orientation: aValue [
	^ self at: #orientation put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> orientation_covariance [
	^ self getAt: #orientation_covariance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsImu >> orientation_covariance: aValue [
	^ self at: #orientation_covariance put: aValue. 

]
