Class {
	#name : #'Yocs_msgsLocalizeResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeResult class >> rosMd5Sum [ 
^'937c9679a518e3a18d831e57125ea522'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeResult class >> rosTypeDefinition [ 
^' bool success
 string message
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsLocalizeResult class >> rosTypeName [ 
^'yocs_msgs/LocalizeResult'
]

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
