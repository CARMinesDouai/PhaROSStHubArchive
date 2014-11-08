"
PhaROSModel initInstance.

PhaROSDashboard open.
PhaROSView open.

PhaROSModel instance.
PhaROSDeamonBoard start.
PhaROSDeamonBoard stop.

"
Class {
	#name : #PhaROSView,
	#superclass : #Object,
	#category : #PhaROSDashBoard
}

{ #category : #'as yet unclassified' }
PhaROSView class >> open [
	|b|
	PhaROSDeamonBoard start.
	b := PhaROSView new.
	
	b open
]

{ #category : #'as yet unclassified' }
PhaROSView >> open [
	| elipse nodes topics edges aView topicInteraction nodeInteraction square viewEdges addEdges |	

	aView := RTView new.
	aView canvas addMenu: 'speed up' callback: [ 
		PhaROSDeamonBoard instance changeRefreshTime: PhaROSDeamonBoard instance refreshTime / 2.
	].
	aView canvas addMenu: 'speed down' callback: [ 
		PhaROSDeamonBoard instance changeRefreshTime: PhaROSDeamonBoard instance refreshTime * 2.
	].
	aView canvas addMenu: 'clean view' callback: [ 
		RTCellLayout new
				lineItemsCount: nodes size + 1; on: aView elements.
	].
	aView canvas addMenu: 'clean view 2' callback: [ 
		RTClusterLayout new verticalGap: 100; horizontalGap: 100;on: aView elements.
	].
	elipse := (RTEllipse new borderColor: Color blue; height: 40; width: 120)+ (RTLabel new).
	square := (RTBox new borderColor: Color gray;  height: 40; width: 120) + (RTLabel new).
	
	nodeInteraction := RTInteractionBuilder new.
	nodeInteraction popupText; highlightColored: #colorIsPingable; 
				action: #inspect;
				item: 'kill node' action: [:string | PhaROSSystemInfo instance killNode: string].
				
	topicInteraction := RTInteractionBuilder new.
	topicInteraction popupText; 
				action: #inspect.	
					
	RTActiveAnimation new 
		inView: aView;
		blockToExecute: [
			nodes := PhaROSModel instance nodes. 
			topics := PhaROSModel instance topics.
			edges := PhaROSModel instance nodeToTopicLink.
		
			aView elements do:[:e |
				((nodes union: topics) includes: e model) ifFalse:[
				 	aView removeElement: e
				].
			].
					
			nodes do: [ :object | 
				|objEl|
				(aView elements anySatisfy:[:e | e model = object]) ifFalse:[
					objEl:= (RTElement on: object).
					objEl + square.
					aView add: objEl.
					objEl @ RTDraggable.
					nodeInteraction setUpElement: objEl.
				]	
			].
			topics do: [ :obj |
				|el|
				(aView elements anySatisfy: [ :e | e model = obj]) ifFalse:[
					aView elements inspectOnce.
					el := (RTElement on: obj).
					el + elipse.
					aView add: el.
					el @ RTDraggable. 
					topicInteraction setUpElement: el.
				]	
			].
		
			aView edges do:[:e |
				(edges anySatisfy: [ :ed | e model key = ed key and:[e model value = ed value]]) ifFalse:[
				 	aView removeEdge: e
				].
			].
		
			viewEdges := aView edges collect:[:e | e model].
			addEdges := edges reject:[:ed | viewEdges anySatisfy:[:e | ed key = e key and:[ed value = e value] ] ].
			
			RTEdge 
				buildEdgesFromObjects: addEdges
				from: #key
				to:  #value 
				using: ((RTArrowedLine new attachPoint: RTShorterDistanceAttachPoint new; color: Color veryDarkGray)) inView: aView.
	].

	aView @ RTDraggableView.
	aView open.
]
