"
The Idea of the Plan side of TaskIT is to be able to define a relation in between computations that we want to be able to change how do they behave in terms of concurrence, and let a Visitor to define the way they will execute. 

Other powerful idea related with this explicit relation is the fact that there is more information for managing errors, events and for giving chances to run  each thread each time. In case that one process die, why can know how it impacts the rest of the processes. 

In order to define the relations in between this maybe-process we use the following simbols

=> dependance, A=>B this means that B needs the result of A to execute. 
Usually we write 
[  A ] => [ :a | B(a) ].


& and, A & B, both should be executed, they are dont need the results of any of both. 

[ A ] & [ B ] = { a . b }.

The result of the execution is an array of results. The n elements related with & ( A&B&C&D.. ) may run paralelly, (depending the implementation of the sequencer). In any case the output of this is an array of results with the same order as the proceesses. 


<=> Cooperation. A <=> B, means A cooperate with B. They are mutually dependant. Usually we can understand this as a producer/consumer architecture. This  is the first looping control structure. 

[ : bs | A  ] <=> [ :as | B ].


For each A generated, there should be a B execution, and so on, for each B execution should be an A. The default first b value is nothing (empty channel). This may run as two or one looping thread


[ : bs | A  ] <<=> [ :as | B ].

 A cooperates with B, A may execute as fast as it can. This is a clasical producer / consumer, where producer (A) takes information from a socket. A should be ready to read the next packet as fast as it can, in order to have good performance. B may have more processing weight. 
This may execute in two or more treads.


[ : bs | A ] =>> [ : as | B  ].  This is a reentrant dependency. This means use the results of B for the beginning of the execution (in this case A)

To have a better example, let add an other process
 
[ : cs | A  ] => [ : a | B ] =>> [ :b | C ].

In this case, all the output from a will go to be executed by B, that by C and the results from C will go to A as an input.






















"
Class {
	#name : #TKTPlan,
	#superclass : #Object,
	#instVars : [
		'startingTask'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #operators }
TKTPlan >> => aPlannable [ 

	^ startingTask ifNil:[
		startingTask := aPlannable asPlanned.
		startingTask parent: self. 
		startingTask
	] ifNotNil: [ 
		startingTask => aPlannable.
	 ].
	
]

{ #category : #operators }
TKTPlan >> addParalellizable: aPlanned [
	startingTask addParalellizable: aPlanned
]

{ #category : #'as yet unclassified' }
TKTPlan >> replace: aPlanned by: otherPlanned [
	startingTask = aPlanned ifTrue:[
		startingTask := otherPlanned.	
	] ifFalse:[ self error: 'there is not related task!' ].
]

{ #category : #accessing }
TKTPlan >> run [
	^ TKTPlanRunner sequence: startingTask
]

{ #category : #operators }
TKTPlan >> size [
	| counter |
	
	counter := TKTPlanUnitCounter new.
	startingTask accept: counter.
	^ counter units.
]

{ #category : #accessing }
TKTPlan >> startingTask [
	^ startingTask
]
