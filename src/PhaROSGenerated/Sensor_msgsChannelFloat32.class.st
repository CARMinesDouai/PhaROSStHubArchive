Class {
	#name : #'Sensor_msgsChannelFloat32',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsChannelFloat32 >> initialize [
	super initialize.
	 self name: ''. 
	 self values: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Sensor_msgsChannelFloat32 >> name [
	^ self getAt: #name. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsChannelFloat32 >> name: aValue [
	^ self at: #name put: aValue. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsChannelFloat32 >> values [
	^ self getAt: #values. 

]

{ #category : #'as yet unclassified' }
Sensor_msgsChannelFloat32 >> values: aValue [
	^ self at: #values put: aValue. 

]
