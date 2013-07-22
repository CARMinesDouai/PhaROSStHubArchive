Extension { #name : #ClassDescription }

{ #category : #'*PhaROS' }
ClassDescription >> documentation [
"	^ self name,'<<<<<<<<<<<<<<',"
	^  self comment format
	", '>>>>>>>>>>>>>>>>>'."
]
