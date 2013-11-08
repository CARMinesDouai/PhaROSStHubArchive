Class {
	#name : #ROBPage,
	#superclass : #WAComponent,
	#instVars : [
		'robotProxy'
	],
	#category : #RoboShop
}

{ #category : #rendering }
ROBPage class >> renderContentOn: html [
	html heading: 'Hello Robot'
]

{ #category : #updating }
ROBPage >> renderStop: html [

html anchor
				class: 'btn btn-large btn-primary';
				callback: [ self stopRobot. . self answer ];
				script: (html jQuery this button);
				with: 'Thanks for the demo!'
]

{ #category : #'robot communication' }
ROBPage >> robotProxy [
	^ self session robotProxy
]

{ #category : #updating }
ROBPage >> shouldStop [
	^ stop.
]

{ #category : #updating }
ROBPage >> stopRobot [
	self robotProxy stop.
]

{ #category : #styling }
ROBPage >> style [
	^ '
	
body {
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	font-weight: 200;
	font-size: 21px;
}

.container { 
	width: 1280px;
	margin: 0 auto;
	padding-top: 20px;	
}

.left { 
	float: left;
	width: 350px;
}

.right { 
	float: left;
	width: 350px;
}

.middle { 
	float: left;
	padding: 4em 1em 0 1em;
	text-align: center;
	max-width: 4em;
}

.help { margin-top: 60px; text-align: center;}

.middlebig { 
	width: 500px;
	margin: 0 auto;
	text-align: center;
}

.products, .shoppingcart { 
	padding: 1em;
	border: 3px dashed #ccc;
	min-height: 300px;
}

.product {
	display: block;
	margin-bottom: 10px;
	border-width: 0;
	padding: 5px
}

.numberOfProducts { margin-right: 10px; }

.centering {
	margin: 0 auto;
	text-align: center;
}

.fetchButton { 
	display: block;
	margin: 0 auto;
	width: 90%;
}


.hero-unit h1, h1 { text-align: center; 
margin-bottom: 1em;
}

.product > a { 
	margin-right: 10px;
}

.product > * { 
	display: inline-block;
	vertical-align: middle;
}

.product img { 
	width: 120px;
	height: 120px;
	Border-radius: 10px;
}

.productImageBig {  
	width: 200px !important;
	height: 200px !important;
	Border-radius: 10px;
}

.productLabel { 
	margin-left:40px;
}
.productPrice {
	font-weight: bold;
	float: right;
	margin-top: 52px;
} 

.shoppingcartSum  {  
	margin-top: 10px;
	font-weight: bold;
	float: right;
}
	
.quantityModifiers > a { 
	display: block;
	height: 18px;
	width: 18px;
	margin-bottom: 1px;
}

.quantityModifiers { 
	margin-right: 0.5em;
}


.btn-large { 
	font-size: 20px;
	margin-top: 50px;
}

#fetchButton { 
	width: 80%;
	display: block;
	margin: auto;
	margin-top: 50px;
}

.numberOfProductsQuantity { 
	font-weight: bold;
}

.red { border: 5px solid red; }


.robo-item { 
	background: #F3F2ED;
	border: 4px double white;
	padding: 0 10px;
	margin: 10px 0 10px 0;
	border-radius:10px;
	-webkit-border-radius:10px;
	-webkit-box-shadow:3px 3px 6px #A9A9A9;
	height:70px;
}
.robo-item.span { 
	font-size: 14px;
	vertical-align: middle;
 }
'
]

{ #category : #updating }
ROBPage >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	JQBaseTheme default updateRoot: anHtmlRoot.
	anHtmlRoot title: ROBApp applicationName 
]
