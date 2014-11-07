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
	myShape := RTMultiCompositeShape new
				add: (RTEllipse new color: Color gray; size: 40);
				add: (RTLabel new);
				horizontal;
				yourself.
	sb shape: myShape.
	^ sb
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> renderIn: aView [

	| shape elipse deamon nodes topics model |	
		
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

	elipse := RTEllipse new color: Color blue; size: 20; yourself.
	shape := RTMultiCompositeShape new
				add: elipse;
				add: (RTLabel new);
				horizontal;
				yourself.
				
	RTActiveAnimation new 
		inView: aView;
		blockToExecute: [
			nodes := model nodes. 
			topics := model topics.
	
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
				"	objEl @ RTDraggable; 
						+ shape;
						@ (RTPopup new text: [ :cls | PhaROSSystemInfo instance infoOfNode: cls ]).
						objEl when: TRMouseRightClick do: [:evt | PhaROSSystemInfo instance killNode: object ]."
					aView add: objEl.
					self setUpInteractionFor: objEl 
				]	
			].
			topics do: [ :obj |
				|el|
				(aView elements anySatisfy: [ :e | e model = obj]) ifFalse:[
					el := (RTElement on: obj).
					el + shape.
					aView add: el.
					self setUpInteractionFor: el 
				]	
			].
	
			RTCellLayout new
				lineItemsCount: nodes size + 1; on: aView elements.	
		].
	
	aView @ RTDraggableView
]
