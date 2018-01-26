Class {
	#name : #'Theora_image_transportPacket',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Theora_image_transportPacket class >> rosMd5Sum [ 
^'33ac4e14a7cff32e7e0d65f18bb410f3'
]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket class >> rosTypeDefinition [ 
^' std_msgs/Header header
 int8[] data
 int32 b_o_s
 int32 e_o_s
 int64 granulepos
 int64 packetno
'
]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket class >> rosTypeName [ 
^'theora_image_transport/Packet'
]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket class >> typeCreationOrder [ 
^376
]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> b_o_s [
	^ self getAt: #b_o_s. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> b_o_s: aValue [
	^ self at: #b_o_s put: aValue. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> e_o_s [
	^ self getAt: #e_o_s. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> e_o_s: aValue [
	^ self at: #e_o_s put: aValue. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> granulepos [
	^ self getAt: #granulepos. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> granulepos: aValue [
	^ self at: #granulepos put: aValue. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self data: OrderedCollection new . 
	 self b_o_s: 0. 
	 self e_o_s: 0. 
	 self granulepos: 0. 
	 self packetno: 0. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> packetno [
	^ self getAt: #packetno. 

]

{ #category : #'as yet unclassified' }
Theora_image_transportPacket >> packetno: aValue [
	^ self at: #packetno put: aValue. 

]
