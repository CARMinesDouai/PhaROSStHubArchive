Class {
	#name : #PhaROSBaseElement,
	#superclass : #PhaROSAbstractElement,
	#instVars : [
		'childs'
	],
	#category : #'PhaROS-Launch'
}

{ #category : #'as yet unclassified' }
PhaROSBaseElement >> addChild: aChild [
	self childs add: aChild.
	^ aChild.
]

{ #category : #'as yet unclassified' }
PhaROSBaseElement >> childs [ 
	^ childs. 
]

{ #category : #'as yet unclassified' }
PhaROSBaseElement >> initialize [ 
	super initialize.
	childs := Set new.
	
]

{ #category : #'as yet unclassified' }
PhaROSBaseElement >> xmlBody [ 
	^ childs inject: '' into: [ : acc : child |  acc, String tab, child xml  ]
]
