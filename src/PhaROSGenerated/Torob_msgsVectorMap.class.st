Class {
	#name : #'Torob_msgsVectorMap',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> edges [
	^ self getAt: #edges. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> edges: aValue [
	^ self at: #edges put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self resolution: 0.0. 
	 self nodes: OrderedCollection new . 
	 self edges: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> nodes [
	^ self getAt: #nodes. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> nodes: aValue [
	^ self at: #nodes put: aValue. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> resolution [
	^ self getAt: #resolution. 

]

{ #category : #'as yet unclassified' }
Torob_msgsVectorMap >> resolution: aValue [
	^ self at: #resolution put: aValue. 

]
