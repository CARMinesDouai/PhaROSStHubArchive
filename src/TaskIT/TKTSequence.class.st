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
	#name : #TKTSequence,
	#superclass : #TKTPlannedUnitImplication,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTSequence class >> of: aNextStep with: aFirstStep [
	" 
		Check comments for understanding
		aNextStep : B
		aFirstStep : A
	"
	
	^ self new antecedent: aNextStep; consequent: aFirstStep; yourself .
]

{ #category : #'as yet unclassified' }
TKTSequence >> accept: aPlanVisitor [
	aPlanVisitor acceptImplicationSequence: self.
]
