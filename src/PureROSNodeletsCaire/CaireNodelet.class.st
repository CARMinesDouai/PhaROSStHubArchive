Class {
	#name : #CaireNodelet,
	#superclass : #PhaROSStaticNodelet,
	#category : #PureROSNodeletsCaire
}

{ #category : #'as yet unclassified' }
CaireNodelet >> defaultOutput [ 
	^ self controller node topicPublisher: '/zmapmerger/map' typedAs:  'nav_msgs/OccupancyGrid'.
]

{ #category : #'as yet unclassified' }
CaireNodelet >> mapFuser [
	^ CaireMapFuser new.
]
