"
PhaROSDashboard open.

PhaROSDeamonBoard start.
PhaROSDeamonBoard stop.

"
Class {
	#name : #PhaROSDashboard,
	#superclass : #RTBuilder,
	#category : #PhaROSDashBoard
}

{ #category : #'as yet unclassified' }
PhaROSDashboard class >> open [
	|b|
	PhaROSDeamonBoard start.
	b := PhaROSDashboard new.
	
	b open
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> createShapeBuilder [ 
	|sb myShape |
	sb := super createShapeBuilder. 
	"sb ellipse size: 100; color: Color gray."
	myShape := (RTBox new borderColor: Color gray;  height: 40; width: 120) + (RTLabel new).
	sb shape: myShape.
	^ sb
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> renderIn: aView [

	| shape elipse deamon nodes topics model edges|	
		
	deamon := PhaROSDeamonBoard instance.
	model := PhaROSModel instance.

	aView canvas addMenu: 'speed up' callback: [ 
		deamon changeRefreshTime: deamon refreshTime / 2.
	].
	aView canvas addMenu: 'speed down' callback: [ 
		deamon changeRefreshTime: deamon refreshTime * 2.
	].
	
	self interaction popupText; highlightColored: #colorIsPingable; 
		action: #inspect;
		item: 'kill node' action: [:string | PhaROSSystemInfo instance killNode: string].

	elipse := RTEllipse new borderColor: Color blue; height: 40; width: 120; yourself.
	shape := elipse + (RTLabel new).
		
	nodes := model nodes. 
	topics := model topics.
	edges := model nodeToTopicLink.
		
	RTActiveAnimation new 
		inView: aView;
		blockToExecute: [
			aView elements do:[:e |
				(nodes includes: e model) ifFalse:[
				 	aView removeElement: e
				].
				(topics includes: e model) ifFalse:[
				 	aView removeElement: e
				]
			].
					
			nodes do: [ :object | |objEl|
				(aView elements anySatisfy:[:e | e model = object]) ifFalse:[
					objEl:= (self elementOn: object).
					aView add: objEl.
					objEl @ RTDraggable.
				]	
			].
			topics do: [ :obj |
				|el|
				(aView elements anySatisfy: [ :e | e model = obj]) ifFalse:[
					el := (RTElement on: obj).
					el + shape.
					aView add: el.
					self setUpInteractionFor: el.
					el @ RTDraggable. 
				]	
			].
		
			aView edges do:[:e |
				"(edges anySatisfy: [ :ed | e model key = ed key and:[e model value = ed value]]) ifFalse:["
				 	aView removeEdge: e
				"]"
			].
			RTEdge 
				buildEdgesFromObjects: edges
				from: #key
				to:  #value 
				using: ((RTArrowedLine new attachPoint: RTShorterDistanceAttachPoint new; color: Color veryDarkGray)) inView: aView.

			"RTClusterLayout new verticalGap: 100; horizontalGap: 100;on: aView elements.
			"RTCellLayout new
				lineItemsCount: nodes size + 1; on: aView elements.
		].
	
	aView @ RTDraggableView
]
