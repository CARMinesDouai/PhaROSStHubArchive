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

{ #category : #building }
PhaROSDashboard >> buildView [

	view := RTView new.
	view @ RTDraggableView.
	self mainMenuOn: view.
	RTHorizontalTreeLayout new horizontalGap: self horizontalGap; verticalGap: self verticalGap; on: view elements.
	view open. 
]

{ #category : #building }
PhaROSDashboard >> horizontalGap [
	
	^ 150
]

{ #category : #shapes }
PhaROSDashboard >> linkShape [

	^ (RTArrowedLine new attachPoint: RTShorterDistanceAttachPoint new; color: Color veryDarkGray)
]

{ #category : #menu }
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

{ #category : #interaction }
PhaROSDashboard >> nodeInteraction [
	|nodeInteraction|
	
	nodeInteraction:= RTInteractionBuilder new.
	nodeInteraction popupText:[:e | 
					|str|
					str := 'Services: ', String cr, String cr.
					e services do:[:i | str := str, i rosName, String cr].
					str
				]; 
				highlightColored: [:e | e pingable ifTrue:[Color green] ifFalse:[Color red]]; 
				action: #inspect;
				item: 'kill node' action: [:node | PhaROSSystemInfo instance killNode: node rosName].
				
	^ nodeInteraction
]

{ #category : #shapes }
PhaROSDashboard >> nodeShape [

	^ (RTEllipse new borderColor: Color blue; height: 50; width: 180) + (RTLabel new text: [:p | p rosName ])
]

{ #category : #'instance creation' }
PhaROSDashboard >> open [

	| dashboard |
	dashboard := PhaROSDashboard new.
	dashboard plugOn: PhaROSModel instance.
	dashboard buildView.
]

{ #category : #initialization }
PhaROSDashboard >> plugOn: aROSModel [

	model := aROSModel.
	model when: NewTopicEvent do: [ :evt | self processNewTopic: evt].
	model when: NewNodeEvent do: [ :evt | self processNewNode: evt].
	model when: NewLinkEvent do: [ :evt | self processNewLink: evt].
	model when: OldTopicEvent do: [ :evt | self processRemoveTopic: evt].
	model when: OldNodeEvent do: [ :evt | self processRemoveNode: evt].
	model when: OldLinkEvent do: [ :evt | self processRemoveLink: evt].
]

{ #category : #process }
PhaROSDashboard >> processNewLink: event [

	"view add: ((RTEdge new from: event link key to: event link value) addShape: self linkShape).
	"
	| lnk |
	lnk := RTEdge buildEdgesFromObjects: { event link }
		from: #key
		to: #value 
		using: self linkShape
		inView: view.
	lnk do:[:l |
		l @ (RTLabelled new text: [l model rosMsgType])
	].
	self refresh.
]

{ #category : #process }
PhaROSDashboard >> processNewNode: event [
	|element|
	element := (self nodeShape elementOn: event node) @ RTDraggable.
	view add: element.
	self nodeInteraction setUpElement: element.
	self refresh
]

{ #category : #process }
PhaROSDashboard >> processNewTopic: event [

	|element|
	element := (self topicShape elementOn: event topic) @ RTDraggable.
	view add: element.
	self topicInteraction setUpElement: element.

	self refresh
]

{ #category : #process }
PhaROSDashboard >> processRemoveLink: event [

	| edgLnk |
	edgLnk := view edgeFromModel: event link.
	edgLnk ifNotNil: [ 
		view removeEdge: (view edgeFromModel: event link).
	].		
	self refresh
]

{ #category : #process }
PhaROSDashboard >> processRemoveNode: event [

	view removeElement: (view elements detect: [:e | e model = event node]).
	self refresh
]

{ #category : #process }
PhaROSDashboard >> processRemoveTopic: event [

	view removeElement: (view elements detect: [:e | e model = event topic]).
	self refresh
]

{ #category : #refreshing }
PhaROSDashboard >> refresh [

	RTHorizontalTreeLayout new horizontalGap: self horizontalGap; verticalGap: self verticalGap; on: view elements.
	view signalUpdate.
	
]

{ #category : #interaction }
PhaROSDashboard >> topicInteraction [
	|topicInteraction|
	
	topicInteraction := RTInteractionBuilder new.
	topicInteraction "popupText; "
				action: #inspect.
				
	^ topicInteraction
]

{ #category : #shapes }
PhaROSDashboard >> topicShape [

	^ (RTBox new borderColor: Color gray;  height: 50; width: 150) + (RTLabel new text: [:p | p rosName ])
	
]

{ #category : #building }
PhaROSDashboard >> verticalGap [
	
	^ 50
]
