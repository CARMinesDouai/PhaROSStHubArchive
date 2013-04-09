Class {
	#name : #SGReadingState,
	#superclass : #SGState,
	#category : #'StarGazer-States'
}

{ #category : #delegates }
SGReadingState >> get: aParameterName [
	^ self sendAndWaitForResponse: [
		gate stream nextPutReadFor: aParameterName
	] acking: aParameterName .

	
]

{ #category : #'private state flow' }
SGReadingState >> switchReading [
	^ self.
]
