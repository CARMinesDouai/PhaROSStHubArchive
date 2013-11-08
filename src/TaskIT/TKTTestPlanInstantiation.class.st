Class {
	#name : #TKTTestPlanInstantiation,
	#superclass : #TestCase,
	#instVars : [
		'logHasBeenCalled'
	],
	#category : #'TaskIT-Tasks-Plan-Test'
}

{ #category : #tests }
TKTTestPlanInstantiation >> log: anLog [
	logHasBeenCalled := logHasBeenCalled + 1. 
]

{ #category : #tests }
TKTTestPlanInstantiation >> logHasBeenCalled [
	^ logHasBeenCalled
]

{ #category : #accessing }
TKTTestPlanInstantiation >> logHasBeingCalled [
	^ logHasBeenCalled 
]

{ #category : #private }
TKTTestPlanInstantiation >> plan [
	^ TKTPlan new.
]

{ #category : #tests }
TKTTestPlanInstantiation >> setUp [ 	
	super setUp.
	logHasBeenCalled := 0.
]

{ #category : #tests }
TKTTestPlanInstantiation >> testProcessChainedReentrantProcess3Levels [
" chained processing =>> . It works like dependency. but the result of the last related process will go to the first one as parameter, semi-syncronic. 
	f =>> g =>> h =
	h(g(f(h(g(f(h(g(f(....))))))))).

	Where each block has its own process and is the 
 "
	(self plan =>  [ : inputs  |  Transcript show: inputs next.  self produceOneJob ] 
					=> [ : values |  self consume: values next . ] 
					=>> [ : results | self processedResults: results next ]) .
]

{ #category : #tests }
TKTTestPlanInstantiation >> testProcessCombinations [
" & task append  "
	self plan => { [ 1 ] }
]

{ #category : #tests }
TKTTestPlanInstantiation >> testProcessCombinationsAppendDependency [
" & task append
 => dependency  "
	self plan => {
				    [ 1 ] 
				& [  true  ] 
				& [ 'Hello world' ] .
	 } 
	   => 	[ :int :boolean :string | int asString, boolean asString, string ] => 
	{ 	
		    [ :string | Transcript show: string. ] 
		& [ :string | self log:string ].	
	 }.
	 
]

{ #category : #tests }
TKTTestPlanInstantiation >> testProcessCombinationsDependencyAppend [
" & task append
 => dependency  "
	self plan => {
				[ 1 ] 
				=> [ :value | value + 1 ] 
				=> [ : value | Transcript show: value.  ] .
	 } & { 
			[ 1 ] 
			=> [ :value | value + 1 ] 
			=> [ : value | Transcript show: value.  ] .
	
	 }.
	

]

{ #category : #tests }
TKTTestPlanInstantiation >> testProcessCooperation [
" <=> cooperation, or mutual dependency   "
	self plan =>  [ : results  |  Transcript show: results next.  self produceOneJob ] <=> [ : values |  self consume: values next . ].
]

{ #category : #tests }
TKTTestPlanInstantiation >> testProcessSequence [
" => dependency "
	| plan sequence |
	plan := self plan. 
	
	plan => [ 1 ] 
				=> [ :value | value + 1 ] 
				=> [ : value | self log: value. self.  ].
				
	self assert: plan size = 3.
	sequence := plan sequence. 
	
	self assert: sequence next arguments size = 0.
	self assert: sequence next arguments size = 1.
	self assert: sequence next arguments size = 1.
	
	self should: [ sequence next  ] raise: Error.
	 
	sequence reset. 
	self assert: sequence next isSimple. 
	
	self assert: sequence run  = self. 
	self assert: self logHasBeingCalled = 1.
	
	sequence reset.
	self assert: sequence run = self.
	self assert: self logHasBeingCalled = 2.
	
	
	
]

{ #category : #tests }
TKTTestPlanInstantiation >> testProcessSet [
" & task append  "
	self plan => [ 1 + 2 ] & [ 3 * 3 ] & [ Transcript show: 'sarasa' ].

]
