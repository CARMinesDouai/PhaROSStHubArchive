Class {
	#name : #'Yocs_msgsDockingInteractorResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorResult class >> rosMd5Sum [ 
^'937c9679a518e3a18d831e57125ea522'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorResult class >> rosTypeDefinition [ 
^' bool success
 string message
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorResult class >> rosTypeName [ 
^'yocs_msgs/DockingInteractorResult'
]

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
