Class {
	#name : #'Urg_nodeStatus',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Urg_nodeStatus class >> normal [
	^0

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus class >> setting [
	^1

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> angle [
	^ self getAt: #angle. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> angle: aValue [
	^ self at: #angle put: aValue. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> area_number [
	^ self getAt: #area_number. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> area_number: aValue [
	^ self at: #area_number put: aValue. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> distance [
	^ self getAt: #distance. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> distance: aValue [
	^ self at: #distance put: aValue. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> error_code [
	^ self getAt: #error_code. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> error_code: aValue [
	^ self at: #error_code put: aValue. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> error_status [
	^ self getAt: #error_status. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> error_status: aValue [
	^ self at: #error_status put: aValue. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> initialize [
	super initialize.
	 self operating_mode: 0. 
	 self area_number: 0. 
	 self error_status: false. 
	 self error_code: 0. 
	 self lockout_status: false. 
	 self distance: 0. 
	 self angle: 0.0. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> lockout_status [
	^ self getAt: #lockout_status. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> lockout_status: aValue [
	^ self at: #lockout_status put: aValue. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> operating_mode [
	^ self getAt: #operating_mode. 

]

{ #category : #'as yet unclassified' }
Urg_nodeStatus >> operating_mode: aValue [
	^ self at: #operating_mode put: aValue. 

]
