Class {
	#name : #'Rocon_service_pair_msgsTestiesRequest',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesRequest >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesRequest >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_service_pair_msgsTestiesRequest >> initialize [
	super initialize.
	 self data: ''. 

]
