Class {
	#name : #'Stdr_msgsThermalSourceVector',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSourceVector class >> rosTypeDefinition [ 
^' stdr_msgs/ThermalSource[] thermal_sources
'
]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSourceVector class >> rosTypeName [ 
^'stdr_msgs/ThermalSourceVector'
]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSourceVector >> initialize [
	super initialize.
	 self thermal_sources: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSourceVector >> thermal_sources [
	^ self getAt: #thermal_sources. 

]

{ #category : #'as yet unclassified' }
Stdr_msgsThermalSourceVector >> thermal_sources: aValue [
	^ self at: #thermal_sources put: aValue. 

]
