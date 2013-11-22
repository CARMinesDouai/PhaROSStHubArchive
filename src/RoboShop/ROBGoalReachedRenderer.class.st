Class {
	#name : #ROBGoalReachedRenderer,
	#superclass : #ROBMapRenderer,
	#category : #RoboShop
}

{ #category : #'as yet unclassified' }
ROBGoalReachedRenderer >> renderEmployee: anEmployee [

		html div  with:[
	

			html div class:'row-fluid'; style:'vertical-align:middle;width: 400px;'; with: [ 
					html image
						class: 'img-rounded span4';
						style: 'margin-top:5px; width:70px';
						url: anEmployee image.
					html div 
						 class: 'span9'; style:'margin-top: 17px;'; 
						 with:[
							html span: anEmployee name.
							html break.
							html unorderedList style:'font-size:15px; margin-top:15px'; with: [ 
								html listItem: 'charge: ', anEmployee charge.
								html listItem: 'office: ', anEmployee office number asString.
								html listItem: [html anchor url:( 'mailto:', anEmployee email); with: anEmployee email.]
							].
						]
					
			].
			
			html div class:'row-fluid'; style:'vertical-align:middle; margin-top:10px'; with: [ 
				
					html span class: 'span12 offset2'; style:'font-size:12px'; with: anEmployee work.
					
			].

	].
]

{ #category : #'as yet unclassified' }
ROBGoalReachedRenderer >> renderOffice:  aRenderable [

		html div  with:[
	
	
		html div class:'row-fluid'; style:'vertical-align:middle;width: 368px'; with: [ 
				html image
					class: 'img-rounded span4';
					style: 'margin-top:5px; width:70px';
					url: aRenderable image.
				html span class: 'span8'; style:'margin-top: 31px;font-size: 17px;'; with: aRenderable name.
		].
	
	
	].
]

{ #category : #'as yet unclassified' }
ROBGoalReachedRenderer >> renderRendereable: aRenderable [

		html div  with:[
	
	
		html div class:'row-fluid'; style:'vertical-align:middle'; with: [ 
				html image
					class: 'img-rounded span4';
					style: 'margin-top:5px; width:70px';
					url: aRenderable image.
				html span class: ' span5'; style:'margin-top: 17px;'; with: aRenderable name.
		].
	
	
	].
]
