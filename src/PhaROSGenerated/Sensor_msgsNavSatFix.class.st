Class {
	#name : #'Sensor_msgsNavSatFix',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> covariance_type_approximated [
	^1

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> covariance_type_diagonal_known [
	^2

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> covariance_type_known [
	^3

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix class >> covariance_type_unknown [
	^0

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> altitude [
	^ self getAt: #altitude. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> altitude: aValue [
	^ self at: #altitude put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Sensor_msgsNavSatStatus new. 
	 self latitude: 0.0. 
	 self longitude: 0.0. 
	 self altitude: 0.0. 
	 self position_covariance:  (OrderedCollection new: 9). 
	 self position_covariance_type: 0. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> latitude [
	^ self getAt: #latitude. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> latitude: aValue [
	^ self at: #latitude put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> longitude [
	^ self getAt: #longitude. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> longitude: aValue [
	^ self at: #longitude put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> position_covariance [
	^ self getAt: #position_covariance. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> position_covariance: aValue [
	^ self at: #position_covariance put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> position_covariance_type [
	^ self getAt: #position_covariance_type. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> position_covariance_type: aValue [
	^ self at: #position_covariance_type put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsNavSatFix >> status: aValue [
	^ self at: #status put: aValue. 

]
