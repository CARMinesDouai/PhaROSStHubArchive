Class {
	#name : #'Nav_msgsPath',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Nav_msgsPath >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Nav_msgsPath >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Nav_msgsPath >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self poses: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Nav_msgsPath >> poses [
	^ self getAt: #poses. 

]

{ #category : #'as yet unclassified' }
Nav_msgsPath >> poses: aValue [
	^ self at: #poses put: aValue. 

]
