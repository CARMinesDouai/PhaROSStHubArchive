"
Shortcut for terminating non-critic processes, usually for terminate TaskIT processes created during experiments.

Command:
ProcessesCleaner clean
"
Class {
	#name : #ProcessesCleaner,
	#superclass : #Object,
	#category : #'PhaROS-Util'
}

{ #category : #'as yet unclassified' }
ProcessesCleaner class >> clean [

	|pb window|
	window := ProcessBrowser open.
	pb := window model.
	window close.
	
	"Terminate non-critic processes"	
	pb processList do: [ :p |
			(pb nameAndRulesFor: p) second  
				ifFalse: [ "self inform: 'Nope, won''t kill ' , p name.        ... do nothing"  ] 
				ifTrue: [ pb class terminateProcess: p ].
		 ].
	pb updateProcessList.
	self inform: 'PhaROS processes were terminated.'
]
