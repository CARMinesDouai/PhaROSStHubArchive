Class {
	#name : #'Sensor_msgsLaserEcho',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsLaserEcho class >> rosTypeDefinition [ 
^' float32[] echoes
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserEcho class >> rosTypeName [ 
^'sensor_msgs/LaserEcho'
]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserEcho >> echoes [
	^ self getAt: #echoes. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserEcho >> echoes: aValue [
	^ self at: #echoes put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsLaserEcho >> initialize [
	super initialize.
	 self echoes: OrderedCollection new . 

]
