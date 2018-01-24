Class {
	#name : #'Gazebo_msgsODEPhysics',
	#superclass : #PhaROSValue,
	#category : #PhaROSGenerated
}

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics class >> rosMd5Sum [ 
^'667d56ddbd547918c32d1934503dc335'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics class >> rosTypeDefinition [ 
^' bool auto_disable_bodies
 int32 sor_pgs_precon_iters
 int32 sor_pgs_iters
 float64 sor_pgs_w
 float64 sor_pgs_rms_error_tol
 float64 contact_surface_layer
 float64 contact_max_correcting_vel
 float64 cfm
 float64 erp
 int32 max_contacts
'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics class >> rosTypeName [ 
^'gazebo_msgs/ODEPhysics'
]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> auto_disable_bodies [
	^ self getAt: #auto_disable_bodies. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> auto_disable_bodies: aValue [
	^ self at: #auto_disable_bodies put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> cfm [
	^ self getAt: #cfm. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> cfm: aValue [
	^ self at: #cfm put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> contact_max_correcting_vel [
	^ self getAt: #contact_max_correcting_vel. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> contact_max_correcting_vel: aValue [
	^ self at: #contact_max_correcting_vel put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> contact_surface_layer [
	^ self getAt: #contact_surface_layer. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> contact_surface_layer: aValue [
	^ self at: #contact_surface_layer put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> erp [
	^ self getAt: #erp. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> erp: aValue [
	^ self at: #erp put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> initialize [
	super initialize.
	 self auto_disable_bodies: false. 
	 self sor_pgs_precon_iters: 0. 
	 self sor_pgs_iters: 0. 
	 self sor_pgs_w: 0.0. 
	 self sor_pgs_rms_error_tol: 0.0. 
	 self contact_surface_layer: 0.0. 
	 self contact_max_correcting_vel: 0.0. 
	 self cfm: 0.0. 
	 self erp: 0.0. 
	 self max_contacts: 0. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> max_contacts [
	^ self getAt: #max_contacts. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> max_contacts: aValue [
	^ self at: #max_contacts put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> sor_pgs_iters [
	^ self getAt: #sor_pgs_iters. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> sor_pgs_iters: aValue [
	^ self at: #sor_pgs_iters put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> sor_pgs_precon_iters [
	^ self getAt: #sor_pgs_precon_iters. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> sor_pgs_precon_iters: aValue [
	^ self at: #sor_pgs_precon_iters put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> sor_pgs_rms_error_tol [
	^ self getAt: #sor_pgs_rms_error_tol. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> sor_pgs_rms_error_tol: aValue [
	^ self at: #sor_pgs_rms_error_tol put: aValue. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> sor_pgs_w [
	^ self getAt: #sor_pgs_w. 

]

{ #category : #'as yet unclassified' }
Gazebo_msgsODEPhysics >> sor_pgs_w: aValue [
	^ self at: #sor_pgs_w put: aValue. 

]
