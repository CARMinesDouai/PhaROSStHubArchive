Class {
	#name : #SSMonoThreadStrategy,
	#superclass : #SSIOStrategy,
	#category : #'StarGazer-Stream'
}

{ #category : #'as yet unclassified' }
SSMonoThreadStrategy >> becomeMonothread [ 
	^ self.
]

{ #category : #'as yet unclassified' }
SSMonoThreadStrategy >> read [
	^ self readPort.
]
