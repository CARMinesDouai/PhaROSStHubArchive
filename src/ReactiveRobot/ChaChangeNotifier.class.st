Class {
	#name : #ChaChangeNotifier,
	#superclass : #ChaDefaultOutputComponent,
	#traits : 'TChaDefaultInputComponent',
	#classTraits : 'TChaDefaultInputComponent classTrait',
	#category : #'ReactiveRobot-Experiments'
}

{ #category : #acting }
ChaChangeNotifier >> input: data [
	data = outputPort get ifTrue: [ ^self ].
	outputPort set: data
]
