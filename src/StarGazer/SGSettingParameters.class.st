Class {
	#name : #SGSettingParameters,
	#superclass : #SGState,
	#category : #'StarGazer-Kernel'
}

{ #category : #delegates }
SGSettingParameters >> set: aParameterName with: aValue [
	^ self tryToGetResponseFor: [
		gate stream nextPutWrite: aParameterName for: aValue.
	].


]

{ #category : #delegates }
SGSettingParameters >> setEnd [
	^ self command: SGProtocol commandSetEnd.
]

{ #category : #'private state flow' }
SGSettingParameters >> switchCalculating [ 
	self setEnd.
	^ super switchCalculating.
]

{ #category : #'private state flow' }
SGSettingParameters >> switchIdle [ 
	self setEnd.
	^ super switchIdle.
]

{ #category : #'private state flow' }
SGSettingParameters >> switchReading [
	self setEnd.
	^ super switchReading.
]

{ #category : #'private state flow' }
SGSettingParameters >> switchWriting [
	^ self.
]
