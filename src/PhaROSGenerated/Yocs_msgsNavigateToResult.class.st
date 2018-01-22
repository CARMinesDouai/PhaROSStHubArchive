Class {
	#name : #'Yocs_msgsNavigateToResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToResult class >> rosTypeDefinition [ 
^' bool success
 float32 distance
 string message
'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToResult class >> rosTypeName [ 
^'yocs_msgs/NavigateToResult'
]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToResult >> distance [
	^ self getAt: #distance. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToResult >> distance: aValue [
	^ self at: #distance put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToResult >> initialize [
	super initialize.
	 self success: false. 
	 self distance: 0.0. 
	 self message: ''. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToResult >> message [
	^ self getAt: #message. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToResult >> message: aValue [
	^ self at: #message put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToResult >> success [
	^ self getAt: #success. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsNavigateToResult >> success: aValue [
	^ self at: #success put: aValue. 

]
