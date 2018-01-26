Class {
	#name : #'Sensor_msgsChannelFloat32',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Sensor_msgsChannelFloat32 class >> rosMd5Sum [ 
^'3d40139cdd33dfedcb71ffeeeb42ae7f'
]

{ #category : #'as yet unclassified' }
Sensor_msgsChannelFloat32 class >> rosTypeDefinition [ 
^' string name
 float32[] values
'
]

{ #category : #'as yet unclassified' }
Sensor_msgsChannelFloat32 class >> rosTypeName [ 
^'sensor_msgs/ChannelFloat32'
]

{ #category : #'as yet unclassified' }
Sensor_msgsChannelFloat32 class >> typeCreationOrder [ 
^260
]

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
