"
I am the equivalent of tf_splitter.
I subscribe to the /tf topic and split it on /frame_id/tf to save bandwitdh
"
Class {
	#name : #'Tf_phlitterNodelets',
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'tfPublishers'
	],
	#category : #'PhaROSPackage_TFSplitter'
}

{ #category : #'as yet unclassified' }
Tf_phlitterNodelets >> configure [
	tfPublishers := Dictionary new.
	(self controller node buildConnectionFor: '/tf' ) 
								typedAs: 'tf/tfMessage'; 
								for: [ : message | self tfCallBack: message ];
								connect .
]

{ #category : #'as yet unclassified' }
Tf_phlitterNodelets >> tfCallBack: aMessage [
	| prefix publisher |
	prefix := aMessage transforms first header frame_id.
	tfPublishers
		at: prefix
		ifAbsent: [ 
			publisher := self controller node topicPublisher: '/', prefix , '/tf' typedAs: 'tf/tfMessage'.
			tfPublishers at: prefix put: publisher.
			self log: prefix , ' has been extracted from /tf.' ].
	(tfPublishers at: prefix)
		send: [ :msg | 
			msg transforms: aMessage transforms.
			msg ]
]
