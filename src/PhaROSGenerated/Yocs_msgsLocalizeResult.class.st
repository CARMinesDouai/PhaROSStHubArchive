Class {
	#name : #'Yocs_msgsLocalizeResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeResult >> initialize [
	super initialize.
	 self success: false. 
	 self message: ''. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeResult >> message [
	^ self getAt: #message. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeResult >> message: aValue [
	^ self at: #message put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeResult >> success [
	^ self getAt: #success. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeResult >> success: aValue [
	^ self at: #success put: aValue. 

]
