Extension { #name : #TaskITExamples }

{ #category : #'*PoolIT' }
TaskITExamples >> commonSchedduledTask [
	"
	self new commonSchedduledTask
	"
	
	^ [ 2 + 2 ] scheduleIt value = 4 
]

{ #category : #'*PoolIT' }
TaskITExamples >> referencedTask [
	^ [[ true ] whileTrue: [ Transcript show: 'running in a task'; cr. (Delay forMilliseconds: 500) wait] ] scheduleIt asStickyReference.
]
