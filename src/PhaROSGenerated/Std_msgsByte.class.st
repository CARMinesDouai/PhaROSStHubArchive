Class {
	#name : #'Std_msgsByte',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsByte >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Std_msgsByte >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsByte >> initialize [
	super initialize.
	 self data: 0. 

]
