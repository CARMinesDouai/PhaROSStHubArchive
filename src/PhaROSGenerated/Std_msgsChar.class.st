Class {
	#name : #'Std_msgsChar',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsChar >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsChar >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsChar >> initialize [
	super initialize.
	 self data: 0. 

]
