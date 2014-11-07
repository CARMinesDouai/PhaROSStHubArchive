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
	|sb|
	sb := super createShapeBuilder. 
	sb ellipse size: 100; color: Color gray.
	^ sb
]

{ #category : #'as yet unclassified' }
PhaROSDashboard >> renderIn: aView [

	| shape elipse deamon nodes topics refreshTime|	
		
	deamon := PhaROSDeamonBoard instance.

	aView canvas addMenu: 'speed up' callback: [ 
		deamon changeRefreshTime: deamon refreshTime / 2.
	].
	aView canvas addMenu: 'speed down' callback: [ 
		deamon changeRefreshTime: deamon refreshTime * 2.
	].
	
	self interaction popupText; highlightColored: #colorIsPingable; 
		action: #inspect;
		item: 'kill node' action: [:evt | PhaROSSystemInfo instance killNode: evt.].

	elipse := RTEllipse new color: Color blue; size: 20; yourself.
	shape := RTMultiCompositeShape new
				add: elipse;
				add: (RTLabel new);
				horizontal;
				yourself.
				
	RTActiveAnimation new 
		inView: aView;
		blockToExecute: [
			nodes := PhaROSDeamonBoard instance nodes. 
			topics := PhaROSDeamonBoard instance topics.
			refreshTime := PhaROSDeamonBoard instance refreshTime.
	
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
