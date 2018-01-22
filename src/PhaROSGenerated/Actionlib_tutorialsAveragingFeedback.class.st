Class {
	#name : #'Actionlib_tutorialsAveragingFeedback',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback class >> rosTypeDefinition [ 
^' int32 sample
 float32 data
 float32 mean
 float32 std_dev
'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback class >> rosTypeName [ 
^'actionlib_tutorials/AveragingFeedback'
]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback >> data [
	^ self getAt: #data. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback >> data: aValue [
	^ self at: #data put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback >> initialize [
	super initialize.
	 self sample: 0. 
	 self data: 0.0. 
	 self mean: 0.0. 
	 self std_dev: 0.0. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback >> mean [
	^ self getAt: #mean. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback >> mean: aValue [
	^ self at: #mean put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback >> sample [
	^ self getAt: #sample. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback >> sample: aValue [
	^ self at: #sample put: aValue. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback >> std_dev [
	^ self getAt: #std_dev. 

]

{ #category : #'as yet unclassified' }
Actionlib_tutorialsAveragingFeedback >> std_dev: aValue [
	^ self at: #std_dev put: aValue. 

]
