Class {
	#name : #'Yocs_msgsDockingInteractorActionResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionResult >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionResult >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionResult >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self status: Actionlib_msgsGoalStatus new. 
	 self result: Yocs_msgsDockingInteractorResult new. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionResult >> result [
	^ self getAt: #result. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionResult >> result: aValue [
	^ self at: #result put: aValue. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionResult >> status [
	^ self getAt: #status. 

]

{ #category : #'as yet unclassified' }
Yocs_msgsDockingInteractorActionResult >> status: aValue [
	^ self at: #status put: aValue. 

]
