Class {
	#name : #'Rocon_std_msgsStringsRequest',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsRequest >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsRequest >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsRequest >> initialize [
	super initialize.
	 self data: ''. 

]
