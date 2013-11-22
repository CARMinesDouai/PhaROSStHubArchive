Class {
	#name : #ROBWelcomePage,
	#superclass : #ROBPage,
	#instVars : [
		'selectedTab',
		'events',
		'map'
	],
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBWelcomePage >> renderContentOn: html [


	selectedTab := 0.
	
	
	map := ROBLabMap map526909358: ROBApp robotProxyClass new.
	html div class: 'container-fluid' ; with: [
		html break.
		
		html heading level1 with: [
			html div class:'row-fluid'; with:[
				html anchor target:'_new'; url: 'http://www2.mines-douai.fr/'; with:[
					html image
						class: 'img-rounded span1';
						url: ROBFileLibrary/ #ecolePng.
				].
				html anchor target:'_new'; url: 'http://car.mines-douai.fr/'; with:[
					html span class:'span7'; with:'The RoboShop Project (DAN)'.
				].
				html anchor target:'_new'; url: 'http://www.pharo.org/'; with:[
					html image
						class: 'img-rounded span1';
						url: ROBFileLibrary/ #pharoPng.
				].
				html span style:'width:10px';class:'span1'; with:''.
				html anchor target:'_new'; url: 'http://www.ros.org/'; with:[
					html image
							style: 'margin-top:15px';
						class: 'img-rounded span2';
						url: ROBFileLibrary/ #ROSPng.
				].
			]
		].
		html break.
		
		html div
			script: (html jQuery new tabs
			selected: selectedTab;
			onSelect: (html jQuery ajax callbackTabs: [ :event | selectedTab:= event at: #index ]));
			with: [
				html unorderedList: [
					html listItem: [ 	html anchor url: '#tabs-1'; with: 'Selection'. ].
					html listItem: [ 	html anchor url: '#tabs-2'; with: 'Map'. ].
					html listItem: [ html anchor  class:'', (map moving ifTrue:[''] ifFalse:['']); 
												 onClick: (html jQuery ajax 
														callback: [ : value |  map moving ifFalse: [map goHome ]] value: true value ;  
														script: [ : s | ]); 
														with: [ html image 
																	style:'height: 30px; width: 30px'; 
																	title:'go home' ; 
																	url: ROBFileLibrary /#homePng 
														]. 
								].
					html listItem: [ html anchor  class:'', (map moving ifTrue:[''] ifFalse:['']); 
												 onClick: (html jQuery ajax 
														callback: [ : value |  map moving ifFalse: [map setAsInHome ]] value: true value ;  
														script: [ : s | ]); 
														with: [ html image 
																	style:'height: 30px; width: 30px'; 
																	title:'Set as In home (front elevator facing the elevator''s door)' ; 
																	url: ROBFileLibrary /#pointMapPng 
														]. 
								].
				].
				html div id: 'tabs-1'; with: [
						html div  class: 'row-fuild'; with: [  
							
							
							html label for: (html nextId); with: ' '.
							html textInput  
										    id: html lastId; 
										    script: (html jQuery this autocomplete 
													search: [ :term| map matchesFor: term   ] 
													callback: [:term : ob |  map navigatesToBestMatcher: term. ]
											).
							
						].
						html div class: 'row-fluid' ; with: [
							(ROBElementRenderer for: html) renderMap: map .
							html div id: 'queue'; class:'span6 queueport' ; with: ''.
						].

				].
				html div id: 'tabs-2'; with: [
					html div class:'row-fluid'; style:'height: 250px;'; with: [
						html div class:'span14' ; style:( '
							height: 250px;
							width: 850px;
							position: absolute;
							background-image:url(''{1}'');
							background-repeat:no-repeat;
							background-attachment:scroll;
						' format: { ROBFileLibrary / #map2Png  })
					] .
				].
			
			].

		html document addLoadScript: (((html jQuery id: 'queue' ) load html:[ :r | 
			| renderer |

			renderer := ROBGoalRenderer new.
			renderer renderEventsFrom: map on: r.
			renderer renderGoalIfReached: map mantainment
			
			
			
		]) interval: 1000).
	
		
	]
	
	
]
