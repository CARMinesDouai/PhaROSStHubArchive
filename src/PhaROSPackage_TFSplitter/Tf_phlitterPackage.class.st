Class {
	#name : #'Tf_phlitterPackage',
	#superclass : #PhaROSPackage,
	#category : #'PhaROSPackage_TFSplitter'
}

{ #category : #'private - configuration' }
Tf_phlitterPackage >> addNodelet: aController [
	aController nodelets use: Tf_phlitterNodelets as:#example.
	^ aController
]

{ #category : #'private - configuration' }
Tf_phlitterPackage >> buildController [
	"This message is called by the accessor controller when the variable that stores the controller is pointing to nil.
	 If you want to make some specific configuration, as injecting nodelets, for package level, this is the place to do it. 
	Remember to not call #controller from this method, or inner this method, because #controller is the caller of this message.
	"
	^ self addNodelet: super buildController.

]

{ #category : #scripts }
Tf_phlitterPackage >> scriptTfPhlitter [
self controller.
		
]
