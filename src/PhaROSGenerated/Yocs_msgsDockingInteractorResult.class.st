Class {
	#name : #'Yocs_msgsDockingInteractorResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorResult >> initialize [
	super initialize.
	 self success: false. 
	 self message: ''. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorResult >> message [
	^ self getAt: #message. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorResult >> message: aValue [
	^ self at: #message put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorResult >> success [
	^ self getAt: #success. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorResult >> success: aValue [
	^ self at: #success put: aValue. 

]
