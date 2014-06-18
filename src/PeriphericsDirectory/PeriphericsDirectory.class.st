Class {
	#name : #PeriphericsDirectory,
	#superclass : #Object,
	#category : #PeriphericsDirectory
}

{ #category : #util }
PeriphericsDirectory class >> deployUnitFor: aCriteria [
	^ self deployUnits detect: aCriteria ifNone: [ self error: 'There is not unit for the given criteria' ].
]

{ #category : #util }
PeriphericsDirectory class >> deployUnitForPackage: aPackageName [ 
		^ self deployUnitFor: [ : d | d isArchetype ifFalse: [d packageName = aPackageName] 
														ifTrue: [ d archetype = aPackageName ]  ]
]

{ #category : #util }
PeriphericsDirectory class >> deployUnits [
	^ self deployUnitsMetadata collect: [ :m | 
		(Smalltalk at:#MDPharoDeployUnit) forMetadata: m.
	].
]

{ #category : #util }
PeriphericsDirectory class >> deployUnitsMetadata [

	^ { 
	
		self stargazerMetacelloPackage.
	
	 }
]

{ #category : #util }
PeriphericsDirectory class >> includesPackage: aPackageName [ 
	^ self deployUnits anySatisfy:  [ : d | d isArchetype ifFalse: [d packageName = aPackageName] 
														ifTrue: [ d archetype = aPackageName ]  ]
]

{ #category : #packages }
PeriphericsDirectory class >> stargazerMetacelloPackage [
	^ { 
			#name -> 'stargazer' .
			#description -> 'Stargazer Driver ROS Wrapper' . 
			#license ->  'MIT'  .
			#version -> '0.1.0' .
			#maintainer -> ({ 
				#name-> 'Santiago Bragagnolo' . 
				#email -> 'santiagobragagnolo@mail.com' 
			}  asDictionary) .
			#author -> ({  
				#name-> 'Santiago Bragagnolo' . 
				#email -> 'santiagobragagnolo@mail.com' 
			} asDictionary) .
			#metacello -> ({ 
				#url -> 'http://smalltalkhub.com/mc/CAR/PhaROSPeripherics/main' . 
				#configurationOf -> 'ConfigurationOfPeripherics' . 
				#package -> 'StarGazerROS'  
			} asDictionary)
		 } asDictionary 
	
]
