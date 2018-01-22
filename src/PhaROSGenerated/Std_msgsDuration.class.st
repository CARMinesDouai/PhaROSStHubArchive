Class {
	#name : #'Std_msgsDuration',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsDuration >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsDuration >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsDuration >> initialize [
	super initialize.
	 self data:  Duration seconds: 0. 

]
