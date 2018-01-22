Class {
	#name : #'Stdr_msgsRfidTag',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTag >> initialize [
	super initialize.
	 self tag_id: ''. 
	 self message: ''. 
	 self pose: Geometry_msgsPose2D new. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTag >> message [
	^ self getAt: #message. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTag >> message: aValue [
	^ self at: #message put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTag >> pose [
	^ self getAt: #pose. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTag >> pose: aValue [
	^ self at: #pose put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTag >> tag_id [
	^ self getAt: #tag_id. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsRfidTag >> tag_id: aValue [
	^ self at: #tag_id put: aValue. 

]
