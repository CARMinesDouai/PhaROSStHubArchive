Class {
	#name : #'Rocon_std_msgsStringsResponse',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsResponse >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsResponse >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Rocon_std_msgsStringsResponse >> initialize [
	super initialize.
	 self data: ''. 

]
