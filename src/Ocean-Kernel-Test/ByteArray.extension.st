Extension { #name : #ByteArray }

{ #category : #'*Ocean-Alien' }
ByteArray >> asAlien [

	| alien |
	alien := Alien newC: (self size * Alien sizeofInt).
	(1 to: self size) do: [ :index | 
		alien unsignedIntAt: (1 + ((index-1)* Alien sizeofInt)) put: (self at: index)
	].
	^alien
]
