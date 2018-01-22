Class {
	#name : #'Kobuki_msgsAutoDockingResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingResult >> initialize [
	super initialize.
	 self text: ''. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingResult >> text [
	^ self getAt: #text. 

]

{ #category : #'as yet unclassified' }
Kobuki_msgsAutoDockingResult >> text: aValue [
	^ self at: #text put: aValue. 

]
