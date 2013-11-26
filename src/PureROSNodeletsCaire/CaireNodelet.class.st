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
		 #header -> (PhaROSTypeBrowser instance definition:  'std_msgs/Header' ). 
	 	 #info ->( PhaROSTypeBrowser instance definition: 'nav_msgs/MapMetaData') . 
		 #chunks -> (PhaROSArrayType ofType: (PhaROSTypeBrowser instance definition: 'caire/Chunk'))
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
