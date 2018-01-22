Class {
	#name : #'Rocon_std_msgsStringsPairResponse',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPairResponse >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPairResponse >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPairResponse >> initialize [
	super initialize.
	 self id: Uuid_msgsUniqueID new. 
	 self response: Rocon_std_msgsStringsResponse new. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPairResponse >> response [
	^ self getAt: #response. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPairResponse >> response: aValue [
	^ self at: #response put: aValue. 

]
