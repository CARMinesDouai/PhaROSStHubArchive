Class {
	#name : #'Stdr_msgsRfidTagVector',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTagVector class >> rosMd5Sum [ 
^'d1ccd79235f17c9d8c9665681cfa66f7'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTagVector class >> rosTypeDefinition [ 
^' stdr_msgs/RfidTag[] rfid_tags
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTagVector class >> rosTypeName [ 
^'stdr_msgs/RfidTagVector'
]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTagVector class >> typeCreationOrder [ 
^349
]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTagVector >> initialize [
	super initialize.
	 self rfid_tags: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTagVector >> rfid_tags [
	^ self getAt: #rfid_tags. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTagVector >> rfid_tags: aValue [
	^ self at: #rfid_tags put: aValue. 

]
