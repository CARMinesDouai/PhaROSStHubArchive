Class {
	#name : #'Pcl_msgsModelCoefficients',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Pcl_msgsModelCoefficients class >> rosMd5Sum [ 
^'ca27dea75e72cb894cd36f9e5005e93e'
]

{ #category : #'as yet unclassified' }
Pcl_msgsModelCoefficients class >> rosTypeDefinition [ 
^' std_msgs/Header header
 float32[] values
'
]

{ #category : #'as yet unclassified' }
Pcl_msgsModelCoefficients class >> rosTypeName [ 
^'pcl_msgs/ModelCoefficients'
]

{ #category : #'as yet unclassified' }
Pcl_msgsModelCoefficients >> header [
	^ self getAt: #header. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsModelCoefficients >> header: aValue [
	^ self at: #header put: aValue. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsModelCoefficients >> initialize [
	super initialize.
	 self header: Std_msgsHeader new. 
	 self values: OrderedCollection new . 

]

{ #category : #'as yet unclassified' }
Pcl_msgsModelCoefficients >> values [
	^ self getAt: #values. 

]

{ #category : #'as yet unclassified' }
Pcl_msgsModelCoefficients >> values: aValue [
	^ self at: #values put: aValue. 

]
