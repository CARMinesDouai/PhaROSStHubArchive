Class {
	#name : #'Rocon_std_msgsStringsPairRequest',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPairRequest >> id [
	^ self getAt: #id. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPairRequest >> id: aValue [
	^ self at: #id put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPairRequest >> initialize [
	super initialize.
	 self id: Uuid_msgsUniqueID new. 
	 self request: Rocon_std_msgsStringsRequest new. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPairRequest >> request [
	^ self getAt: #request. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsPairRequest >> request: aValue [
	^ self at: #request put: aValue. 

]
