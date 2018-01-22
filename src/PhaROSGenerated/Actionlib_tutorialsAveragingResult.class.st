Class {
	#name : #'Actionlib_tutorialsAveragingResult',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingResult class >> rosTypeDefinition [ 
^' float32 mean
 float32 std_dev
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingResult class >> rosTypeName [ 
^'actionlib_tutorials/AveragingResult'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingResult >> initialize [
	super initialize.
	 self mean: 0.0. 
	 self std_dev: 0.0. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingResult >> mean [
	^ self getAt: #mean. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingResult >> mean: aValue [
	^ self at: #mean put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingResult >> std_dev [
	^ self getAt: #std_dev. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingResult >> std_dev: aValue [
	^ self at: #std_dev put: aValue. 

]
