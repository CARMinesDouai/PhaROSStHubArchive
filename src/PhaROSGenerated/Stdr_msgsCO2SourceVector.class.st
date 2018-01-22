Class {
	#name : #'Stdr_msgsCO2SourceVector',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SourceVector class >> rosTypeDefinition [ 
^' stdr_msgs/CO2Source[] co2_sources
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SourceVector class >> rosTypeName [ 
^'stdr_msgs/CO2SourceVector'
]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SourceVector >> co2_sources [
	^ self getAt: #co2_sources. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SourceVector >> co2_sources: aValue [
	^ self at: #co2_sources put: aValue. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsCO2SourceVector >> initialize [
	super initialize.
	 self co2_sources: OrderedCollection new . 

]
