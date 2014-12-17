"
PhaROSDeamonBoard stop.
PhaROSModel initInstance.
PhaROSDeamonBoard start.

""PhaROSDashboard open.""
PhaROSDashboard open.

PhaROSModel instance.
"
Class {
	#name : #PhaROSDashboard,
	#superclass : #Object,
	#instVars : [
		'view',
		'model'
	],
	#category : #PhaROSDashBoard
}

{ #category : #'as yet unclassified' }
PhaROSDashboard class >> open [
	|b|
	PhaROSDeamonBoard stop.
	PhaROSModel initInstance.
	PhaROSDeamonBoard start.
	b := self new.
	
	b open
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> buildView [

	view := RTView new.
	view @ RTDraggableView.
	self mainMenuOn: view.
	RTHorizontalTreeLayout new horizontalGap: 40; verticalGap: 40; on: view elements.
	view open. 
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> linkShape [

	^ (RTArrowedLine new attachPoint: RTShorterDistanceAttachPoint new; color: Color veryDarkGray)
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> mainMenuOn: aView. [
	
	aView canvas addMenu: 'speed up' callback: [ 
		PhaROSDeamonBoard instance changeRefreshTime: PhaROSDeamonBoard instance refreshTime / 2.
	].
	aView canvas addMenu: 'speed down' callback: [ 
		PhaROSDeamonBoard instance changeRefreshTime: PhaROSDeamonBoard instance refreshTime * 2.
	].
	aView canvas addMenu: 'grid view' callback: [ 
		RTCellLayout new on: aView elements.
	].
	aView canvas addMenu: 'cluster view' callback: [ 
		RTClusterLayout new verticalGap: 100; horizontalGap: 100;on: aView elements.
	].

	aView canvas addMenu: 'tree view' callback: [ RTHorizontalTreeLayout new horizontalGap: 40; verticalGap: 40; on: aView elements ].
	
	aView canvas addMenu: 'circle view' callback: [ RTCircleLayout new initialRadius: 200; on: aView elements ].
	
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> nodeInteraction [
	|nodeInteraction|
	
	nodeInteraction:= RTInteractionBuilder new.
	nodeInteraction popupText; highlightColored: [:e | e pingable ifTrue:[Color green] ifFalse:[Color red]]; 
				action: #inspect;
				item: 'kill node' action: [:node | PhaROSSystemInfo instance killNode: node rosName].
				
	^ nodeInteraction
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> nodeShape [

	^ (RTEllipse new borderColor: Color blue; height: 50; width: 180)+ (RTLabel new text: [:p | p rosName ])
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> open [

	| dashboard |
	dashboard := PhaROSDashboard new.
	dashboard plugOn: PhaROSModel instance.
	dashboard buildView.
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> plugOn: aROSModel [

	model := aROSModel.
	model when: NewTopicEvent do: [ :evt | self processNewTopic: evt].
	model when: NewNodeEvent do: [ :evt | self processNewNode: evt].
	model when: NewLinkEvent do: [ :evt | self processNewLink: evt].
	model when: OldTopicEvent do: [ :evt | self processRemoveTopic: evt].
	model when: OldNodeEvent do: [ :evt | self processRemoveNode: evt].
	model when: OldLinkEvent do: [ :evt | self processRemoveLink: evt].
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> processNewLink: event [

	"view add: ((RTEdge new from: event link key to: event link value) addShape: self linkShape).
	"
	RTEdge buildEdgesFromAssociations: { event link key -> event link value } 
		using: self linkShape 
		inView: view.
	self refresh
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> processNewNode: event [
	|element|
	element := (self nodeShape elementOn: event node) @ RTDraggable.
	view add: element.
	self nodeInteraction setUpElement: element.
	self refresh
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> processNewTopic: event [

	|element|
	element := (self topicShape elementOn: event topic) @ RTDraggable.
	view add: element.
	self topicInteraction setUpElement: element.

	self refresh
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> processRemoveLink: event [

	| edgLnk |
	edgLnk := view edgeFromModel: event link.
	edgLnk ifNotNil: [ 
		view removeEdge: (view edgeFromModel: event link).
	].		
	self refresh
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> processRemoveNode: event [

	view removeElement: (view elements detect: [:e | e model = event node]).
	self refresh
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> processRemoveTopic: event [

	view removeElement: (view elements detect: [:e | e model = event topic]).
	self refresh
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> refresh [

	RTHorizontalTreeLayout new horizontalGap: 40; verticalGap: 40; on: view elements.
	view signalUpdate.
	
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> topicInteraction [
	|topicInteraction|
	
	topicInteraction := RTInteractionBuilder new.
	topicInteraction popupText; 
				action: #inspect.
				
	^ topicInteraction
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> topicShape [

	^ (RTBox new borderColor: Color gray;  height: 50; width: 150) + (RTLabel new text: [:p | p rosName ])
	
]
