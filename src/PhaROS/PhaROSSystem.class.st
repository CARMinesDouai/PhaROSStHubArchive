"
Globals or contants for the whole PhaROS system represented by this Pharo image
"
Class {
	#name : #PhaROSSystem,
	#superclass : #Object,
	#category : #'PhaROS-Kernel'
}

{ #category : #cleaning }
PhaROSSystem class >> cleanAll [

	PhaROSMaster allInstances do: #finalize.
	XMLRPCService stopAll.
	PhaROSNode allSubInstances do: #finalize. 
	PhaROSTcpServer stopAll.
	PhaROSTransport allInstances do: #finalize.
	Socket allInstances do: #closeAndDestroy.
	3 timesRepeat: [ Smalltalk garbageCollectMost ].
	OSProcess accessor restartChildWatcherProcess.
]

{ #category : #options }
PhaROSSystem class >> debugMode [
	^ false
]

{ #category : #cleaning }
PhaROSSystem class >> terminateAllProcesses [

	|pb |
	pb := ProcessBrowser new.
	
	"Terminate non-critic processes"	
	pb processList do: [ :p |
			(pb nameAndRulesFor: p) second  
				ifFalse: [ "self inform: 'Nope, won''t kill ' , p name.        ... do nothing"  ] 
				ifTrue: [ pb class terminateProcess: p ].
		 ].
	pb updateProcessList.
	self inform: 'PhaROS processes were terminated.'
]
