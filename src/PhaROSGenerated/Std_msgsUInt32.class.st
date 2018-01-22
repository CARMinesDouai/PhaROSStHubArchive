Class {
	#name : #'Std_msgsUInt32',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsUInt32 >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt32 >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsUInt32 >> initialize [
	super initialize.
	 self data: 0. 

]
