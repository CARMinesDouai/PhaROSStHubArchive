Class {
	#name : #VMTFTests,
	#superclass : #VMTests,
	#category : #'VectorMaps-Tests'
}

{ #category : #'as yet unclassified' }
VMTFTests >> testIdentity [
	| mat error epsilon expectedValues |
	
	mat := VMTFMatrix identity.
	epsilon := 0.000001.
	expectedValues := {
		{ 1.0.  0.0.  0.0 }.
		{ 0.0.  1.0.  0.0 }.
		{ 0.0.  0.0.  1.0 }.
	}.
	
	expectedValues doWithIndex: [ :row :rIndex |
		row doWithIndex: [ :value :cIndex |
			error := (value - (mat at: rIndex at: cIndex)) abs.
			self assert: ( error < epsilon ).
		].
	].


]

{ #category : #'as yet unclassified' }
VMTFTests >> testRotation [
	| mat error epsilon angles expectedValues |
	
	mat := VMTFMatrix identity.
	epsilon := 0.000001.
	angles := { Float halfPi.  Float halfPi negated. Float pi. }.
	expectedValues := {
		{
			{ 0.0.  -1.0.  0.0 }.
			{ 1.0.  0.0.  0.0 }.
			{ 0.0.  0.0.  1.0 }.
		}.
		{
			{ 0.0.  1.0.  0.0 }.
			{ -1.0.  0.0.  0.0 }.
			{ 0.0.  0.0.  1.0 }.
		}.
		{
			{ -1.0.  0.0.  0.0 }.
			{ 0.0.  -1.0.  0.0 }.
			{ 0.0.  0.0.  1.0 }.
		}.
	}.
	
	angles doWithIndex: [ :angle :index |
		mat angle: angle.
		
		(expectedValues at: index) doWithIndex: [ :row :rIndex |
			row doWithIndex: [ :value :cIndex |
				error := (value - (mat at: rIndex at: cIndex) ) abs.
				self assert: (error < epsilon).
			].
		].
	].



]
