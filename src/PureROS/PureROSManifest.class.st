"
This class is here just to initialize project-level things, like the generation of PhaROS Types 
"
Class {
	#name : #PureROSManifest,
	#superclass : #Object,
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PureROSManifest class >> initialize [
	"Force type generation. There are some generated types used from the experiments and they have they dependencies. "
	PhaROSTypeBrowser instance browseAll.
]
