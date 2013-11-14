"
A plan sequencer is an object that transform the visitor 'visits' into an executable sequence. Since we are in a sequenced-execution environment, we need to transform our Plan into a sequence of execution. This give us the power to define howto execute this sequence: as a schedduled task, as a fully paralellized task, in the same thread, and also when it should run: just now? when is needed? etc.

The design of the sequencer is based on the idea of decorator. We have to main flavors of sequencer, the one that executes an unit of execution when it is sequenced (TKTPlanUnitSequencer), and the TKTPlanSequencerLayer, which is the decorator version. 

Al the decorators are stackable and add different behaviors in the shape of the task, making nested tasks. (For performance we should check how to inline all the behavior instead of having several blocks) .

In the end, all the decorators rely on the TKTPlanUnitSequencer one, which is the only one that has proper capability of execution. 

Actually, if we change the TKTPlanUnitSequencer for a sequencer that instead of execution it has an executable, we could have an object that can execute without making a new analysis over the plan tree. (Of course it will be kind of static.).


"
Class {
	#name : #TKTPlanSequencer,
	#superclass : #Object,
	#instVars : [
		'justBeginning'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlanSequencer class >> for: aResult [
	^ self new result: aResult; yourself
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer class >> runner [
	^ TKTPlannedUnitParalellizer    new.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> begin [
	justBeginning := true.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> end [	
	^ self result.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> justBeginning [
	^ justBeginning
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> result [
	^ self resultObject result.
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> resultAsArguments [
	^ self resultObject arguments

]

{ #category : #abstract }
TKTPlanSequencer >> resultObject [
	self subclassResponsibility .
]

{ #category : #abstract }
TKTPlanSequencer >> sequence: aPlanned [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
TKTPlanSequencer >> thereIsResult [
	^ self resultObject isSetted
]
