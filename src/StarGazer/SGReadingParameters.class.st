Class {
	#name : #SGReadingParameters,
	#superclass : #SGState,
	#category : #'StarGazer-Kernel'
}

{ #category : #delegates }
SGReadingParameters >> get: aParameterName [
	^ self sendAndWaitForResponse: [
		gate stream nextPutReadFor: aParameterName
	].

	
]

{ #category : #'private state flow' }
SGReadingParameters >> switchReading [
	^ self.
]
