Class {
	#name : #'Sensor_msgsJointState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsJointState class >> rosMd5Sum [ 
^'3066dcd76a6cfaef579bd0f34173e9fd'
]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string[] name
 float64[] position
 float64[] velocity
 float64[] effort
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState class >> rosTypeName [ 
^'sensor_msgs/JointState'
]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState class >> typeCreationOrder [ 
^266
]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> effort [
	^ self getAt: #effort. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> effort: aValue [
	^ self at: #effort put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self name: OrderedCollection new . 
	 self position: OrderedCollection new . 
	 self velocity: OrderedCollection new . 
	 self effort: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> position [
	^ self getAt: #position. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> position: aValue [
	^ self at: #position put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> velocity [
	^ self getAt: #velocity. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsJointState >> velocity: aValue [
	^ self at: #velocity put: aValue. 

]
