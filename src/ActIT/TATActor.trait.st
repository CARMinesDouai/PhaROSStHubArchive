Trait {
	#name : #TATActor,
	#category : #'ActIT-Kernel'
}

{ #category : #compiler }
TATActor classSide >> compiler [
	"Answer a compiler appropriate for source methods of this class."

	| compiler |
	compiler := Object compilerClass new.
	compiler compilationContext semanticAnalyzerClass: ATSemanticAnalyzer.
	compiler environment: self environment.
	compiler class: self.
	^ compiler
]
