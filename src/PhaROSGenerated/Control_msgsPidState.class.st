Class {
	#name : #'Control_msgsPidState',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Control_msgsPidState >> d_error [
	^ self getAt: #d_error. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> d_error: aValue [
	^ self at: #d_error put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> d_term [
	^ self getAt: #d_term. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> d_term: aValue [
	^ self at: #d_term put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> error [
	^ self getAt: #error. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> error: aValue [
	^ self at: #error put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> error_dot [
	^ self getAt: #error_dot. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> error_dot: aValue [
	^ self at: #error_dot put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> i_error [
	^ self getAt: #i_error. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> i_error: aValue [
	^ self at: #i_error put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> i_max [
	^ self getAt: #i_max. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> i_max: aValue [
	^ self at: #i_max put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> i_min [
	^ self getAt: #i_min. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> i_min: aValue [
	^ self at: #i_min put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> i_term [
	^ self getAt: #i_term. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> i_term: aValue [
	^ self at: #i_term put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self timestep:  Duration seconds: 0. 
	 self error: 0.0. 
	 self error_dot: 0.0. 
	 self p_error: 0.0. 
	 self i_error: 0.0. 
	 self d_error: 0.0. 
	 self p_term: 0.0. 
	 self i_term: 0.0. 
	 self d_term: 0.0. 
	 self i_max: 0.0. 
	 self i_min: 0.0. 
	 self output: 0.0. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> output [
	^ self getAt: #output. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> output: aValue [
	^ self at: #output put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> p_error [
	^ self getAt: #p_error. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> p_error: aValue [
	^ self at: #p_error put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> p_term [
	^ self getAt: #p_term. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> p_term: aValue [
	^ self at: #p_term put: aValue. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> timestep [
	^ self getAt: #timestep. 

]

{ #category : #'as yet unclassified' }
Control_msgsPidState >> timestep: aValue [
	^ self at: #timestep put: aValue. 

]
