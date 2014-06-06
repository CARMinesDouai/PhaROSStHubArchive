"
A TKTInstanceProcess execute a block in a different image / vm. 
"
Class {
	#name : #FKTInstanceProcess,
	#superclass : #TKTProcess,
	#instVars : [
		'imagePath',
		'vmPath',
		'process'
	],
	#category : #ForkIT
}

{ #category : #'as yet unclassified' }
FKTInstanceProcess class >> simpleInstance [
	^ self new image: Smalltalk imagePath; vm: Smalltalk vm  fileName; yourself.
]

{ #category : #controlling }
FKTInstanceProcess >> execute [ 
	| blockFile executorFile stream |
	
	" Encode the block to execute with fuel (it will care about the contextual references -- Take in care inconsistences)"
	blockFile := self fuelFile.
	FLSerializer serialize: executable toFileNamed: blockFile pathString.

	" Generate a file that loads the encoded block, execute it, erase the files and quit"
	executorFile := self executorFile.
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

{ #category : #controlling }
FKTInstanceProcess >> executorFile [
	^ imagePath asFileReference parent / ('{1}.st' format: { self hash }).
]

{ #category : #controlling }
FKTInstanceProcess >> fuelFile [
	^ imagePath asFileReference parent / ('{1}.fl' format: { self hash }).
]

{ #category : #accessing }
FKTInstanceProcess >> image: anImagePath [
	imagePath := anImagePath
]

{ #category : #controlling }
FKTInstanceProcess >> isTerminated [
	^ process isComplete.
]

{ #category : #controlling }
FKTInstanceProcess >> pid [
	^ process  pid.
]

{ #category : #controlling }
FKTInstanceProcess >> resume [
	self shouldBeImplemented 
]

{ #category : #accessing }
FKTInstanceProcess >> terminate [ 
	process terminate.
	self fuelFile deleteIfAbsent:[].
	self executorFile deleteIfAbsent:[].
]

{ #category : #accessing }
FKTInstanceProcess >> vm: aVMPath [
	vmPath := aVMPath 
]
