Class {
	#name : #PhaROSTypeBrowser,
	#superclass : #Object,
	#instVars : [
		'browse'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'PhaROS-Kernel-TypesBrowsing'
}

{ #category : #'as yet unclassified' }
PhaROSTypeBrowser class >> instance [
	^ instance ifNil: [
		instance := super new.	
	].
]

{ #category : #'as yet unclassified' }
PhaROSTypeBrowser class >> new [
	self error: 'Use instance!'.
]

{ #category : #'as yet unclassified' }
PhaROSTypeBrowser class >> reset [
	instance := nil.
	PhaROSCompositeType reset.
]

{ #category : #accessing }
PhaROSTypeBrowser >> browser [
	^browse.
]

{ #category : #'as yet unclassified' }
PhaROSTypeBrowser >> definition: aTypeId [

	| firstLevel |

	
	^ (self browser at: aTypeId ifAbsentPut: [
	
			firstLevel := (Character lf split:( PhaROSSystemLauncher instance rosMsgShow: aTypeId ) ) select: [ :str | (str beginsWith: ' ') not & (str size > 3) ] .
						
			(PhaROSType composite: (  
				firstLevel collect: [
					:each |
					| type name association |
					 type := ($ split: each).
					name :=type at:2.
					type := type at: 1.
					((type indexOf: $[) = 0 ) ifTrue:[
						association := ( name asSymbol -> (self definition: type)  ).
					] ifFalse: [
						((type indexOf: $]) = ((type indexOf: $[ )+1) ) ifTrue: [
							association := (name asSymbol -> (PhaROSArrayType ofType: (self definition: (type copyReplaceAll: '[]' with: '') )  ) ).
						] ifFalse: [
							| size innerType |	
							size := type copyFrom: ((type indexOf: $[) +1) to: ((type indexOf: $]) -1) asInteger .
							innerType :=  self definition: (type copyFrom:1 to: ((type indexOf: $[) -1 ) ) .
						
						      association := ( name asSymbol ->  (PhaROSArrayFixedLenghtType of: size  ofType: innerType )  )
						].
					].
				 ]
			) asArray named: aTypeId) relatedClass; yourself.

	]) 












]

{ #category : #'as yet unclassified' }
PhaROSTypeBrowser >> initialize [ 

	browse := Dictionary new.
	
	browse at: 'bool' put: PhaROSBoolType new.
	browse at: 'float32' put: PhaROSFloat32Type new.
	browse at: 'float64' put: PhaROSFloat64Type new.
	
	browse at: 'int8' put: PhaROSInt8Type new.
	browse at: 'int16' put: PhaROSInt16Type new.
	browse at: 'int32' put: PhaROSInt32Type new.
	browse at: 'int64' put: PhaROSInt64Type new.
	
	browse at: 'uint8' put: PhaROSUInt8Type new.
	browse at: 'uint16' put: PhaROSUInt16Type new.
	browse at: 'uint32' put: PhaROSUInt32Type new.
	browse at: 'uint64' put: PhaROSUInt64Type new.
	
	browse at: 'time' put: PhaROSTimeType new.
	browse at: 'duration' put: PhaROSDurationType new.
	browse at: 'string' put: PhaROSStringType new.
	
	

	









]
