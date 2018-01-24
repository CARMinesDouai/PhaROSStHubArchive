Class {
	#name : #'Stdr_msgsSoundSourceVector',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSourceVector class >> rosMd5Sum [ 
^'b0990ed9e7eeb58876a06c8b484951b4'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSourceVector class >> rosTypeDefinition [ 
^' stdr_msgs/SoundSource[] sound_sources
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSourceVector class >> rosTypeName [ 
^'stdr_msgs/SoundSourceVector'
]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSourceVector >> initialize [
	super initialize.
	 self sound_sources: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSourceVector >> sound_sources [
	^ self getAt: #sound_sources. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsSoundSourceVector >> sound_sources: aValue [
	^ self at: #sound_sources put: aValue. 

]
