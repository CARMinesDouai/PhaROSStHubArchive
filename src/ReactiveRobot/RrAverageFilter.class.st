"
A RrAverageFilter is a filter that receives a collection of values as input and produces as output a collection of averages for each value.  
"
Class {
	#name : #RrAverageFilter,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'averages'
	],
	#category : #'ReactiveRobot-Generic'
}

{ #category : #acting }
RrAverageFilter >> newOutputFrom: values [
	averages ifNil: [^averages := values].
	^averages := averages with: values collect: [ :oldAverage  :newValue|
		(oldAverage * 9 + newValue)/10
	]
]
