Class {
	#name : #PhaROSTypeEntry,
	#superclass : #Object,
	#instVars : [
		'typeName',
		'master',
		'type'
	],
	#category : #'PhaROS-Kernel-TypesBrowsing'
}

{ #category : #construction }
PhaROSTypeEntry class >> for: aTypeName with: aRoStMaster [ 
	^ self new typeName: aTypeName ; master: aRoStMaster; assembleIt; yourself.
]

{ #category : #assembling }
PhaROSTypeEntry >> assembleIt [

	typeName = 'turtlesim/Pose' ifTrue: [
		type := PhaROSType composite: {	
				#x -> PhaROSFloat32Type new.
				#y -> PhaROSFloat32Type new .
				#theta -> PhaROSFloat32Type new .
				#linear_velocity -> PhaROSFloat32Type new .
				#angular_velocity -> PhaROSFloat32Type new .
			} named: self typeName.
		
	] ifFalse: [
		type := PhaROSType composite: {	
				#linear -> PhaROSFloat32Type new.
				#angular -> PhaROSFloat32Type new .
			} named: self typeName.
	]
]

{ #category : #accessing }
PhaROSTypeEntry >> master: aRoStMaster [ 
	master := aRoStMaster.
]

{ #category : #accessing }
PhaROSTypeEntry >> type [
	^ type
]

{ #category : #accessing }
PhaROSTypeEntry >> typeName [
	^ typeName
]

{ #category : #accessing }
PhaROSTypeEntry >> typeName: aTypeName [ 
	typeName := aTypeName.
]
