Extension { #name : #PhaROS3DVector }

{ #category : #'*VectorMaps_PhaROS' }
PhaROS3DVector classSide >> fromDhbVector: aDhbVector [
	^ self x: (aDhbVector at: 1 at: 1) y: (aDhbVector at: 1 at: 2)  z: (aDhbVector at: 1 at: 3).

]
