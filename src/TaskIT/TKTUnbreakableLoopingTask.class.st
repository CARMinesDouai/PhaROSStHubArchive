Class {
	#name : #TKTUnbreakableLoopingTask,
	#superclass : #TKTLoopingTask,
	#category : #'TaskIT-Worker'
}

{ #category : #'as yet unclassified' }
TKTUnbreakableLoopingTask >> block: aBlock [
	realBlock := aBlock.
	block := [: slf : future | 
		[  (future at: #keepRunning) ] whileTrue: [ 
			[
				realBlock cull: slf cull: future 
			] on: Error do: [ :e | 
				self log: e messageText.
			]
		]. 
	].
]
