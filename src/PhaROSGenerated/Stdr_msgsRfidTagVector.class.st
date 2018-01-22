Class {
	#name : #'Stdr_msgsRfidTagVector',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

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
