"
BGSWall represent a static obstacle
"
Class {
	#name : #BGSWall,
	#superclass : #BGSCellContent,
	#category : #'BOSS-Kernel'
}

{ #category : #polimorphic }
BGSWall >> bot [
	^ nil
]

{ #category : #printing }
BGSWall >> printOn: aStream [
	aStream nextPutAll: #wall
]
