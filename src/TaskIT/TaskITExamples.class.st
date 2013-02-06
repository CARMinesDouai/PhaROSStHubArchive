Class {
	#name : #TaskITExamples,
	#superclass : #Object,
	#category : #'TaskIT-Examples'
}

{ #category : #'as yet unclassified' }
TaskITExamples >> commonSchedduledTask [
	"
	self new commonSchedduledTask
	"
	
	^ [ 2 + 2 ] taskIt value = 4 
]

{ #category : #'as yet unclassified' }
TaskITExamples >> commonTask [ 
	"
	self new commonTask
	"
	
	^ [ 2 + 2 ] doIt asResult 
]
