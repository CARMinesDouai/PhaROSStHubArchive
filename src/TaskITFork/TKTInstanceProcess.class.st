"
A TKTInstanceProcess execute a block in a different image / vm. 
"
Class {
	#name : #TKTInstanceProcess,
	#superclass : #TKTProcess,
	#instVars : [
		'imagePath',
		'vmPath',
		'process'
	],
	#category : #TaskITFork
}

{ #category : #'as yet unclassified' }
TKTInstanceProcess class >> simpleInstance [
	^ self new image: Smalltalk imagePath; vm: Smalltalk vm  fileName; yourself.
]

{ #category : #controlling }
TKTInstanceProcess >> execute [ 
	| blockFile executorFile stream |
	
	" Encode the block to execute with fuel (it will care about the contextual references -- Take in care inconsistences)"
	blockFile := imagePath asFileReference parent / ('{1}.fl' format: { self hash }).
	FLSerializer serialize: executable toFileNamed: blockFile pathString.

	" Generate a file that loads the encoded block, execute it, erase the files and quit"
	executorFile :=  imagePath asFileReference parent / ('{1}.st' format: { self hash }).
	stream := executorFile writeStream.
	stream nextPutAll: ('
	(FLMaterializer materializeFromFileNamed:''{1}'') ensure: [
		''{1}'' asFileReference delete.
		''{2}'' asFileReference delete.	
		Smalltalk exit: 0.
	]' format:{ blockFile pathString . executorFile pathString }).
	stream close.

	" Executes the given block in the given vm/image bundle "
	process := ExternalUnixOSProcess
		forkAndExec: vmPath 
		arguments: { '--nodisplay' . imagePath . 'st' .  executorFile pathString }
		environment: (UnixProcess env)
		descriptors: { FileStream stdin . FileStream stdout . FileStream stderr }.
				

]

{ #category : #accessing }
TKTInstanceProcess >> image: anImagePath [
	imagePath := anImagePath
]

{ #category : #controlling }
TKTInstanceProcess >> isTerminated [
	^ process isComplete.
]

{ #category : #controlling }
TKTInstanceProcess >> pid [
	^ process  pid.
]

{ #category : #controlling }
TKTInstanceProcess >> resume [
	self shouldBeImplemented 
]

{ #category : #accessing }
TKTInstanceProcess >> terminate [ 
	process terminate
]

{ #category : #accessing }
TKTInstanceProcess >> vm: aVMPath [
	vmPath := aVMPath 
]