Extension { #name : #String }

{ #category : #'*StarGazer' }
String >> asNumberSG [
	^ (self at:1 ) = $+ ifTrue:[
		(self copyFrom: 2 to: self size) asNumber.	
	] ifFalse: [ 
		self asNumber.
	].
]
