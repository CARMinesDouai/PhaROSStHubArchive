Class {
	#name : #'Dynamic_reconfigureSensorLevels',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Dynamic_reconfigureSensorLevels class >> reconfigure_close [
	^3

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureSensorLevels class >> reconfigure_running [
	^0

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureSensorLevels class >> reconfigure_stop [
	^1

]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureSensorLevels class >> rosTypeDefinition [ 
^' int8 RECONFIGURE_CLOSE=3
 int8 RECONFIGURE_STOP=1
 int8 RECONFIGURE_RUNNING=0
'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureSensorLevels class >> rosTypeName [ 
^'dynamic_reconfigure/SensorLevels'
]

{ #category : #'as yet unclassified' }
Dynamic_reconfigureSensorLevels >> initialize [
	super initialize.

]
