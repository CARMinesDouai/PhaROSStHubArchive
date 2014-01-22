Extension { #name : #BasicCodeLoader }

{ #category : #'*PhaROS' }
BasicCodeLoader classSide >> commandLineHandlerAction: aCommandLine [
	"Load the file specified on the command line"
	| loader |
	loader := self new.
	
	loader loadSourceFiles: (Array with: ((self parameterFrom: aCommandLine) convertFromSystemString)).
	loader installSourceFiles.
]

{ #category : #'*PhaROS' }
BasicCodeLoader classSide >> commandLineHandlerCondition: aCommandLine [
	| bool | 
	"Ensure that:
		- there is a parameter
		- it is a valid file name"
		
	aCommandLine hasParameters ifFalse: [ ^ false ].
	bool := (FileSystem disk resolve: (self parameterFrom: aCommandLine )) asFileReference exists.
	bool ifFalse: [ self halt: 'the script pointed sent is not a valid file'].
	^ bool.

]

{ #category : #'*PhaROS' }
BasicCodeLoader classSide >> parameterFrom: aCommandLine [

	^ ((aCommandLine parameterAt: 1) copyReplaceAll: Character cr asString with: '') copyReplaceAll: Character lf asString with: ''. 
]
