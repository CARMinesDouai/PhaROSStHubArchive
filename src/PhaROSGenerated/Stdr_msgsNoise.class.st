Class {
	#name : #'Stdr_msgsNoise',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsNoise >> initialize [
	super initialize.
	 self noise: false. 
	 self noiseMean: 0.0. 
	 self noiseStd: 0.0. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsNoise >> noise [
	^ self getAt: #noise. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsNoise >> noise: aValue [
	^ self at: #noise put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsNoise >> noiseMean [
	^ self getAt: #noiseMean. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsNoise >> noiseMean: aValue [
	^ self at: #noiseMean put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsNoise >> noiseStd [
	^ self getAt: #noiseStd. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsNoise >> noiseStd: aValue [
	^ self at: #noiseStd put: aValue. 

]
