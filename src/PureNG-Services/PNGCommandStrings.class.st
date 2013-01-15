Class {
	#name : #PNGCommandStrings,
	#superclass : #Object,
	#category : #'PureNG-Kernel'
}

{ #category : #requests }
PNGCommandStrings class >> directoryServiceGetEntries [
	^'01000000'
	"PNGRequest new
		get;
		directoryServcice;
		dataString
	"
]
