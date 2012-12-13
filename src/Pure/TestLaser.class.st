Class {
	#name : #TestLaser,
	#superclass : #TestRobulab,
	#category : #'Pure-Test-HardwareInTheLoop'
}

{ #category : #'as yet unclassified' }
TestLaser >> testGetOneValue [
	|laser|
	"#[180 0 4 0]"
	laser := (robulab directoryService instancesRelatedWith: LaserService) first. 
	laser getData
]
