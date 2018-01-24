Class {
	#name : #'Sensor_msgsMultiDOFJointState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState class >> rosMd5Sum [ 
^'690f272f0640d2631c305eeb8301e59d'
]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string[] joint_names
 geometry_msgs/Transform[] transforms
 geometry_msgs/Twist[] twist
 geometry_msgs/Wrench[] wrench
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState class >> rosTypeName [ 
^'sensor_msgs/MultiDOFJointState'
]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self joint_names: OrderedCollection new . 
	 self transforms: OrderedCollection new . 
	 self twist: OrderedCollection new . 
	 self wrench: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> joint_names [
	^ self getAt: #joint_names. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> joint_names: aValue [
	^ self at: #joint_names put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> transforms [
	^ self getAt: #transforms. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> transforms: aValue [
	^ self at: #transforms put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> twist [
	^ self getAt: #twist. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> twist: aValue [
	^ self at: #twist put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> wrench [
	^ self getAt: #wrench. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsMultiDOFJointState >> wrench: aValue [
	^ self at: #wrench put: aValue. 

]
