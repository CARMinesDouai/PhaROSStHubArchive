Class {
	#name : #PureROSDirectory,
	#superclass : #Object,
	#category : #PureROSDirectory
}

{ #category : #util }
PureROSDirectory class >> deployUnitFor: aCriteria [
	^ self deployUnits detect: aCriteria ifNone: [ self error: 'There is not unit for the given criteria' ].
]

{ #category : #util }
PureROSDirectory class >> deployUnitForPackage: aPackageName [ 
		^ self deployUnitFor: [ : d | d isArchetype ifFalse: [d packageName = aPackageName] 
														ifTrue: [ d archetype = aPackageName ]  ]
]

{ #category : #util }
PureROSDirectory class >> deployUnits [
	^ self deployUnitsMetadata collect: [ :m | 
		(Smalltalk at:#MDPharoDeployUnit) forMetadata: m.
	].
]

{ #category : #util }
PureROSDirectory class >> deployUnitsMetadata [

	^ { 
	
		self kompaiMetacelloPackage .
		self robulabMetacelloPackage .	
	 }
]

{ #category : #util }
PureROSDirectory class >> includesPackage: aPackageName [ 
	^ self deployUnits anySatisfy:  [ : d | d isArchetype ifFalse: [d packageName = aPackageName] 
														ifTrue: [ d archetype = aPackageName ]  ]
]

{ #category : #packages }
PureROSDirectory class >> kompaiMetacelloPackage [
	^ { 
			#name -> 'kompai' .
			#description -> 'Kompai Package' . 
			#license ->  'MIT'  .
			#version -> '0.1.0' .
			#maintainer -> ({ 
				#name-> 'Santiago Bragagnolo' . 
				#email -> 'santiagobragagnolo@gmail.com' 
			}  asDictionary) .
			#author -> ({  
				#name-> 'Santiago Bragagnolo' . 
				#email -> 'santiagobragagnolo@mail.com'  
			} asDictionary) .
			#metacello -> ({ 
				#url -> 'http://car.mines-douai.fr/squeaksource/Pure' . 
				#configurationOf -> 'ConfigurationOfPureROS' . 
				#package -> 'PureROSPackageKompai' . 
				#needsCredentials -> true. 
			} asDictionary)
		 } asDictionary 
	
]

{ #category : #packages }
PureROSDirectory class >> robulabMetacelloPackage [
	^ { 
			#name -> 'roboshop' .
			#description -> 'RoboShop Package' . 
			#license ->  'MIT'  .
			#version -> '0.1.0' .
			#maintainer -> ({ 
				#name-> 'Santiago Bragagnolo' . 
				#email -> 'santiagobragagnolo@gmail.com' 
			}  asDictionary) .
			#author -> ({  
				#name-> 'Santiago Bragagnolo' . 
				#email -> 'santiagobragagnolo@mail.com'  
			} asDictionary) .
			#metacello -> ({ 
				#url -> 'http://car.mines-douai.fr/squeaksource/Pure' . 
				#configurationOf -> 'ConfigurationOfPureROS' . 
				#package -> 'PureROSPackageRobulab' .
				#needsCredentials -> true. 
			} asDictionary)
		 } asDictionary 
	
]
