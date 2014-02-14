Class {
	#name : #PhaROSStdIONodelet,
	#superclass : #PhaROSStaticNodelet,
	#category : #'PhaROS-Nodelets'
}

{ #category : #stdio }
PhaROSStdIONodelet >> askUserFor: aLegend [
	self log: aLegend.
	^self stdin upTo: Character lf
]

{ #category : #stdio }
PhaROSStdIONodelet >> stdin [
	^  FileStream stdin.
]

{ #category : #stdio }
PhaROSStdIONodelet >> stdout [ 
	^  FileStream stdout.
]
