Class {
	#name : #VMBSPNodeRenderer,
	#superclass : #VMBaseRenderer,
	#instVars : [
		'renderSectorBorder'
	],
	#category : #'VectorMaps-GUI-Athens'
}

{ #category : #'as yet unclassified' }
VMBSPNodeRenderer >> initialize [
	super initialize.
	renderSectorBorder := true.
]

{ #category : #rendering }
VMBSPNodeRenderer >> renderOn: aCanvas viewer: aViewer [

	model leftChild
		ifNotNil: [
			(model leftChild asRenderableElement)
				renderSectorBorder: renderSectorBorder;
				renderOn: aCanvas viewer: aViewer ].
		
	model rightChild
		ifNotNil: [
			(model rightChild asRenderableElement)
				renderSectorBorder: renderSectorBorder;
				renderOn: aCanvas viewer: aViewer ].
	

]

{ #category : #'as yet unclassified' }
VMBSPNodeRenderer >> renderSectorBorder [
	^renderSectorBorder
]

{ #category : #'as yet unclassified' }
VMBSPNodeRenderer >> renderSectorBorder: aBoolean [
	renderSectorBorder := aBoolean
]
