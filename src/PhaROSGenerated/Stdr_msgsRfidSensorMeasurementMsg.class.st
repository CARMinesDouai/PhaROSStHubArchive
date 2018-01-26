Class {
	#name : #'Stdr_msgsRfidSensorMeasurementMsg',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg class >> rosMd5Sum [ 
^'274b41808759cfa6e05b69149e9ea1ed'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg class >> rosTypeDefinition [ 
^' std_msgs/Header header
 string[] rfid_tags_ids
 string[] rfid_tags_msgs
 float32[] rfid_tags_dbs
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg class >> rosTypeName [ 
^'stdr_msgs/RfidSensorMeasurementMsg'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg class >> typeCreationOrder [ 
^347
]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self rfid_tags_ids: OrderedCollection new . 
	 self rfid_tags_msgs: OrderedCollection new . 
	 self rfid_tags_dbs: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg >> rfid_tags_dbs [
	^ self getAt: #rfid_tags_dbs. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg >> rfid_tags_dbs: aValue [
	^ self at: #rfid_tags_dbs put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg >> rfid_tags_ids [
	^ self getAt: #rfid_tags_ids. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg >> rfid_tags_ids: aValue [
	^ self at: #rfid_tags_ids put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg >> rfid_tags_msgs [
	^ self getAt: #rfid_tags_msgs. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidSensorMeasurementMsg >> rfid_tags_msgs: aValue [
	^ self at: #rfid_tags_msgs put: aValue. 

]
