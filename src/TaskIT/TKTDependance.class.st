"
The sequence is explained in terms of steps to do something,  

 A => B => C 

( A then B then C )

This means, C( B ( A ) ). 

This means that 
C dependsOn B and B dependsOn A.

Then 

as logic implication

C implies B, B implies A. 


So, in terms of implication, 

The sequence 
A => B

means
B implies A


B = antecedent
A = consequent

 A                 B
[ 1 ] => [ :value| 1+value ]









"
Class {
	#name : #TKTDependance,
	#superclass : #TKTPlannedUnitRelation,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTDependance class >> of: aNextStep [ 
	" 
		Check comments for understanding
		aNextStep : B
		aFirstStep : A
	"
	
	^ self new object: aNextStep; yourself .
]

{ #category : #'as yet unclassified' }
TKTDependance >> accept: aPlanVisitor [
	aPlanVisitor acceptImplicationSequence: self.
]

{ #category : #'as yet unclassified' }
TKTDependance >> isSequenceable [
	^true.
]

{ #category : #'as yet unclassified' }
TKTDependance >> printOn: aStream [
	'=>' printOn: aStream.
	object printOn: aStream.
]
