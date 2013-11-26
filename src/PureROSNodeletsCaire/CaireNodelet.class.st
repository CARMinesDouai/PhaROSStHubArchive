Class {
	#name : #CaireNodelet,
	#superclass : #PhaROSStaticNodelet,
	#category : #PureROSNodeletsCaire
}

{ #category : #'as yet unclassified' }
CaireNodelet class >> chunkTypeDefinition [
	^ PhaROSCompositeType named: 'caire/Chunk' definedBy: {
		#to -> (PhaROSUInt16Type new).
		#value -> (PhaROSUInt8Type new)
	}  withConstants: {}.
	



]

{ #category : #'as yet unclassified' }
CaireNodelet class >> chunksMapTypeDefinition [
	^ PhaROSCompositeType named: 'caire/ChunksMapTransport' definedBy: {
		 #header -> Std_msgsHeader new. 
	 	 #info -> Nav_msgsMapMetaData new. 
		 #chunks -> (PhaROSUInt16Type new).
	}  withConstants: {}.
	



]

{ #category : #'as yet unclassified' }
CaireNodelet class >> types [
	^ { #Chunk -> self chunkTypeDefinition  . #ChunksMapTransport -> self chunksMapTypeDefinition }.
	



]

{ #category : #'as yet unclassified' }
CaireNodelet >> defaultOutput [ 
	^ self controller node topicPublisher: '/zmapmerger/map' typedAs:  'nav_msgs/OccupancyGrid'.
]

{ #category : #'as yet unclassified' }
CaireNodelet >> mapFuser [
	^ CaireMapFuser new.
]
