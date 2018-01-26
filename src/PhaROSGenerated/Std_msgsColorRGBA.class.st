Class {
	#name : #'Std_msgsColorRGBA',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA class >> rosMd5Sum [ 
^'a29a96539573343b1310c73607334b00'
]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA class >> rosTypeDefinition [ 
^' float32 r
 float32 g
 float32 b
 float32 a
'
]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA class >> rosTypeName [ 
^'std_msgs/ColorRGBA'
]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA class >> typeCreationOrder [ 
^295
]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA >> a [
	^ self getAt: #a. 

]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA >> a: aValue [
	^ self at: #a put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA >> b [
	^ self getAt: #b. 

]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA >> b: aValue [
	^ self at: #b put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA >> g [
	^ self getAt: #g. 

]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA >> g: aValue [
	^ self at: #g put: aValue. 

]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA >> initialize [
	super initialize.
	 self r: 0.0. 
	 self g: 0.0. 
	 self b: 0.0. 
	 self a: 0.0. 

]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA >> r [
	^ self getAt: #r. 

]

{ #category : #'as yet unclassified' }
Std_msgsColorRGBA >> r: aValue [
	^ self at: #r put: aValue. 

]
