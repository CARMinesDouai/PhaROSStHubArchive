Class {
	#name : #TKTRunnableVisitor,
	#superclass : #TKTPlanVisitor,
	#instVars : [
		'units',
		'cursor'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTRunnableVisitor >> asPlanned [ 	
	^ TKTPlannedRunnableVisitor of: self 
]

{ #category : #'as yet unclassified' }
TKTRunnableVisitor >> run [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TKTRunnableVisitor >> run: anArray [
	self subclassResponsibility 
]
