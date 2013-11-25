Class {
	#name : #PhaROSCatkinPackage,
	#superclass : #Object,
	#instVars : [
		'location',
		'package',
		'rosDependancies',
		'cmake',
		'xml'
	],
	#classInstVars : [
		'locations'
	],
	#category : #'PhaROSInfrastructure-CatkinPackage'
}

{ #category : #'constructor-PhaROSEsug' }
PhaROSCatkinPackage class >> cmakePhaROSEsug [
		^ 'cmake_minimum_required(VERSION 2.8.3)
project(esug)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

## System dependencies are found with CMake"s conventions
# find_package(Boost REQUIRED COMPONENTS system)


## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/api/catkin/html/user_guide/setup_dot_py.html
# catkin_python_setup()

#######################################
## Declare ROS messages and services ##
#######################################

## Generate messages in the "msg" folder
# add_message_files(
#   FILES
#   Message1.msg
#   Message2.msg
# )

## Generate services in the "srv" folder
# add_service_files(
#   FILES
#   Service1.srv
#   Service2.srv
# )

## Generate added messages and services with any dependencies listed here
# generate_messages(
#   DEPENDENCIES
#   std_msgs  # Or other packages containing msgs
# )

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES esug
#  CATKIN_DEPENDS other_catkin_pkg
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include)

## Declare a cpp library
# add_library(esug
#   src/${PROJECT_NAME}/esug.cpp
# )

## Declare a cpp executable
# add_executable(esug_node src/esug_node.cpp)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(esug_node esug_generate_messages_cpp)

## Specify libraries to link a library or executable target against
# target_link_libraries(esug_node
#   ${catkin_LIBRARIES}
# )

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
# install(TARGETS esug esug_node
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_esug.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
                '
	
]

{ #category : #'constructor-PureROSKompai' }
PhaROSCatkinPackage class >> cmakePureROSKompai [
		^ 'cmake_minimum_required(VERSION 2.8.3)
project(kompai)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

## System dependencies are found with CMake"s conventions
# find_package(Boost REQUIRED COMPONENTS system)


## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/groovy/api/catkin/html/user_guide/setup_dot_py.html
# catkin_python_setup()

#######################################
## Declare ROS messages and services ##
#######################################

## Generate messages in the "msg" folder
# add_message_files(
#   FILES
#   Message1.msg
#   Message2.msg
# )

## Generate services in the "srv" folder
# add_service_files(
#   FILES
#   Service1.srv
#   Service2.srv
# )

## Generate added messages and services with any dependencies listed here
# generate_messages(
#   DEPENDENCIES
#   std_msgs  # Or other packages containing msgs
# )

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES kompai
#  CATKIN_DEPENDS other_catkin_pkg
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include ${catkin_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})

## Declare a cpp library
# add_library(kompai
#   src/${PROJECT_NAME}/kompai.cpp
# )

## Declare a cpp executable
# add_executable(kompai_node src/kompai_node.cpp)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(kompai_node kompai_generate_messages_cpp)

## Specify libraries to link a library or executable target against
# target_link_libraries(kompai_node
#   ${catkin_LIBRARIES}
# )

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/groovy/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
# install(TARGETS kompai kompai_node
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_kompai.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
 '
	
]

{ #category : #'constructor-PureROSRobulab' }
PhaROSCatkinPackage class >> cmakePureROSRobulab [
		^ 'cmake_minimum_required(VERSION 2.8.3)
project(robulab)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

## System dependencies are found with CMake"s conventions
# find_package(Boost REQUIRED COMPONENTS system)


## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/groovy/api/catkin/html/user_guide/setup_dot_py.html
# catkin_python_setup()

#######################################
## Declare ROS messages and services ##
#######################################

## Generate messages in the "msg" folder
# add_message_files(
#   FILES
#   Message1.msg
#   Message2.msg
# )

## Generate services in the "srv" folder
# add_service_files(
#   FILES
#   Service1.srv
#   Service2.srv
# )

## Generate added messages and services with any dependencies listed here
# generate_messages(
#   DEPENDENCIES
#   std_msgs  # Or other packages containing msgs
# )

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES robulab
#  CATKIN_DEPENDS other_catkin_pkg
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include ${catkin_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})

## Declare a cpp library
# add_library(robulab
#   src/${PROJECT_NAME}/robulab.cpp
# )

## Declare a cpp executable
# add_executable(robulab_node src/robulab_node.cpp)

## Add cmake target dependencies of the executable/library
## as an example, message headers may need to be generated before nodes
# add_dependencies(robulab_node robulab_generate_messages_cpp)

## Specify libraries to link a library or executable target against
# target_link_libraries(robulab_node
#   ${catkin_LIBRARIES}
# )

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/groovy/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
# install(TARGETS robulab robulab_node
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_robulab.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
   '
	
]

{ #category : #'constructor-PhaROSEsug' }
PhaROSCatkinPackage class >> createPhaROSEsug [ 
		^ PhaROSCatkinPackage new pharosPackage: PhaROSEsug; cmake: PhaROSCatkinPackage cmakePhaROSEsug; xml: PhaROSCatkinPackage xmlPhaROSEsug; rosDependencies: #(); yourself. 
	
]

{ #category : #'constructor-PureROSKompai' }
PhaROSCatkinPackage class >> createPureROSKompai [ 
		^ PhaROSCatkinPackage new pharosPackage: PureROSKompai; cmake: PhaROSCatkinPackage cmakePureROSKompai; xml: PhaROSCatkinPackage xmlPureROSKompai; rosDependencies: #(); yourself. 
	
]

{ #category : #'constructor-PureROSRobulab' }
PhaROSCatkinPackage class >> createPureROSRobulab [ 
		^ PhaROSCatkinPackage new pharosPackage: PureROSRobulab; cmake: PhaROSCatkinPackage cmakePureROSRobulab; xml: PhaROSCatkinPackage xmlPureROSRobulab; rosDependencies: #(); yourself. 
	
]

{ #category : #'as yet unclassified' }
PhaROSCatkinPackage class >> generatesMessagesDependancies [
	^{ #roscpp . #rospy . #std_msgs . #geometry_msgs . #message_generation . #message_runtime }
]

{ #category : #'as yet unclassified' }
PhaROSCatkinPackage class >> initialize [
	locations := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSCatkinPackage class >> install: aPackage in: aLocation [
	^ self install: aPackage in: aLocation dependingOn: {}.
]

{ #category : #'as yet unclassified' }
PhaROSCatkinPackage class >> install: aPackage in: aLocation dependingOn: aCollectionOfROSDependancies [
	| instance |

	(self respondsTo: ('create{1}' format: { aPackage name }) asSymbol )ifTrue: [ 
		instance := self perform: ('create{1}' format: { aPackage name }) asSymbol.
	 ] ifFalse: [ 
		instance := self new pharosPackage: aPackage; rosDependencies: aCollectionOfROSDependancies; yourself.
	 ].

	^instance location: aLocation;  install; yourself.
]

{ #category : #'constructor-PhaROSEsug' }
PhaROSCatkinPackage class >> xmlPhaROSEsug [
		^ '<?xml version="1.0"?>
<package>
  <name>esug</name>
  <version>0.1.0</version>
  <description> ESUG example package</description>

  <!-- One maintainer tag required, multiple allowed, one person per tag --> 
  <!-- Example:  -->
  <!-- <maintainer email="jane.doe@example.com">Jane Doe</maintainer> -->
  <maintainer email="SantiagoBragagnolo@todo.todo">SantiagoBragagnolo</maintainer>


  <!-- One license tag required, multiple allowed, one license per tag -->
  <!-- Commonly used license strings: -->
  <!--   BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3 -->
  <license>TODO</license>


  <!-- Url tags are optional, but mutiple are allowed, one per tag -->
  <!-- Optional attribute type can be: website, bugtracker, or repository -->
  <!-- Example: -->
  <!-- <url type="website">http://ros.org/wiki/esug</url> -->


  <!-- Author tags are optional, mutiple are allowed, one per tag -->
  <!-- Authors do not have to be maintianers, but could be -->
  <!-- Example: -->
  <!-- <author email="jane.doe@example.com">Jane Doe</author> -->
  <author >SantiagoBragagnolo</author>


  <!-- The *_depend tags are used to specify dependencies -->
  <!-- Dependencies can be catkin packages or system dependencies -->
  <!-- Examples: -->
  <!-- Use build_depend for packages you need at compile time: -->
  <!--   <build_depend>message_generation</build_depend> -->
  <!-- Use buildtool_depend for build tool packages: -->
  <!--   <buildtool_depend>catkin</buildtool_depend> -->
  <!-- Use run_depend for packages you need at runtime: -->
  <!--   <run_depend>message_runtime</run_depend> -->
  <!-- Use test_depend for packages you need only for testing: -->
  <!--   <test_depend>gtest</test_depend> -->
  <buildtool_depend>catkin</buildtool_depend>


  <!-- The export tag contains other, unspecified, tags -->
  <export>
    <!-- You can specify that this package is a metapackage here: -->
    <!-- <metapackage/> -->

    <!-- Other tools can request additional information be placed here -->

  </export>
</package>'
	
]

{ #category : #'constructor-PureROSKompai' }
PhaROSCatkinPackage class >> xmlPureROSKompai [
		^ '<?xml version="1.0"?>
<package>
  <name>kompai</name>
  <version>0.1.0</version>
  <description>Kompai package. PureNG wrapper for ROS</description>

  <!-- One maintainer tag required, multiple allowed, one person per tag --> 
  <!-- Example:  -->
  <!-- <maintainer email="jane.doe@example.com">Jane Doe</maintainer> -->
  <maintainer email="SantiagoBragagnolo@todo.todo">SantiagoBragagnolo</maintainer>


  <!-- One license tag required, multiple allowed, one license per tag -->
  <!-- Commonly used license strings: -->
  <!--   BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3 -->
  <license>TODO</license>


  <!-- Url tags are optional, but mutiple are allowed, one per tag -->
  <!-- Optional attribute type can be: website, bugtracker, or repository -->
  <!-- Example: -->
  <!-- <url type="website">http://ros.org/wiki/kompai</url> -->


  <!-- Author tags are optional, mutiple are allowed, one per tag -->
  <!-- Authors do not have to be maintianers, but could be -->
  <!-- Example: -->
  <!-- <author email="jane.doe@example.com">Jane Doe</author> -->
  <author >SantiagoBragagnolo</author>


  <!-- The *_depend tags are used to specify dependencies -->
  <!-- Dependencies can be catkin packages or system dependencies -->
  <!-- Examples: -->
  <!-- Use build_depend for packages you need at compile time: -->
  <!--   <build_depend>message_generation</build_depend> -->
  <!-- Use buildtool_depend for build tool packages: -->
  <!--   <buildtool_depend>catkin</buildtool_depend> -->
  <!-- Use run_depend for packages you need at runtime: -->
  <!--   <run_depend>message_runtime</run_depend> -->
  <!-- Use test_depend for packages you need only for testing: -->
  <!--   <test_depend>gtest</test_depend> -->
  <buildtool_depend>catkin</buildtool_depend>


  <!-- The export tag contains other, unspecified, tags -->
  <export>
    <!-- You can specify that this package is a metapackage here: -->
    <!-- <metapackage/> -->

    <!-- Other tools can request additional information be placed here -->

  </export>
</package>'
	
]

{ #category : #'constructor-PureROSRobulab' }
PhaROSCatkinPackage class >> xmlPureROSRobulab [
		^ '<?xml version="1.0"?>
<package>
  <name>robulab</name>
  <version>0.1.0</version>
  <description> pharos package</description>

  <!-- One maintainer tag required, multiple allowed, one person per tag --> 
  <!-- Example:  -->
  <!-- <maintainer email="jane.doe@example.com">Jane Doe</maintainer> -->
  <maintainer email="SantiagoBragagnolo@todo.todo">SantiagoBragagnolo</maintainer>


  <!-- One license tag required, multiple allowed, one license per tag -->
  <!-- Commonly used license strings: -->
  <!--   BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3 -->
  <license>TODO</license>


  <!-- Url tags are optional, but mutiple are allowed, one per tag -->
  <!-- Optional attribute type can be: website, bugtracker, or repository -->
  <!-- Example: -->
  <!-- <url type="website">http://ros.org/wiki/robulab</url> -->


  <!-- Author tags are optional, mutiple are allowed, one per tag -->
  <!-- Authors do not have to be maintianers, but could be -->
  <!-- Example: -->
  <!-- <author email="jane.doe@example.com">Jane Doe</author> -->
  <author >SantiagoBragagnolo</author>


  <!-- The *_depend tags are used to specify dependencies -->
  <!-- Dependencies can be catkin packages or system dependencies -->
  <!-- Examples: -->
  <!-- Use build_depend for packages you need at compile time: -->
  <!--   <build_depend>message_generation</build_depend> -->
  <!-- Use buildtool_depend for build tool packages: -->
  <!--   <buildtool_depend>catkin</buildtool_depend> -->
  <!-- Use run_depend for packages you need at runtime: -->
  <!--   <run_depend>message_runtime</run_depend> -->
  <!-- Use test_depend for packages you need only for testing: -->
  <!--   <test_depend>gtest</test_depend> -->
  <buildtool_depend>catkin</buildtool_depend>


  <!-- The export tag contains other, unspecified, tags -->
  <export>
    <!-- You can specify that this package is a metapackage here: -->
    <!-- <metapackage/> -->

    <!-- Other tools can request additional information be placed here -->

  </export>
</package>'
	
]

{ #category : #accessing }
PhaROSCatkinPackage >> = otherPackage [
	^ package = otherPackage pharosPackage and: [ location = otherPackage location ]
]

{ #category : #accessing }
PhaROSCatkinPackage >> author [
	^ package author
]

{ #category : #path }
PhaROSCatkinPackage >> bin [
	^ self path ,'/bin'
]

{ #category : #path }
PhaROSCatkinPackage >> build [
	^ self path ,'/build'
]

{ #category : #path }
PhaROSCatkinPackage >> cMakeList [

	^ self path, '/CMakeLists.txt' 
]

{ #category : #path }
PhaROSCatkinPackage >> changes [
	^ self path ,'/image/Pharo.changes'
]

{ #category : #abstract }
PhaROSCatkinPackage >> cmake [
	^ cmake
]

{ #category : #abstract }
PhaROSCatkinPackage >> cmake: aCMakeDefinition [
	cmake := aCMakeDefinition.
]

{ #category : #abstract }
PhaROSCatkinPackage >> deploy [
	"Source code deployment"
	PhaROSPackageDeployer new deploy: package on: self image startedWith: self vm.
	
	

]

{ #category : #abstract }
PhaROSCatkinPackage >> deployType: aType definedAs: aTypeDefinition [
	^ PhaROSSystemLauncher instance deployType: aType definedAs: aTypeDefinition at: self.
]

{ #category : #accessing }
PhaROSCatkinPackage >> description [
	^ package description.
]

{ #category : #abstract }
PhaROSCatkinPackage >> encodeCMAKE [
	| file |
	file := StandardFileStream readOnlyFileNamed: self cMakeList.
	
	self class class compile: ('cmake{1}
		^ ''{2} ''
	' format: { package name . (file upToEnd copyReplaceAll: '''' with: '"')} ) classified:  ('constructor-{1}'format: { package name }).
	
	file close.
	^ 'cmake{1}' format: { package name }.
	
	
]

{ #category : #abstract }
PhaROSCatkinPackage >> encodeFiles [
	self encodeXML.
	self encodeCMAKE.
]

{ #category : #abstract }
PhaROSCatkinPackage >> encodeXML [
	| file |

	file := StandardFileStream readOnlyFileNamed: self packageXML.
	
	self class class compile: (' xml{1}
		^ ''{2}''
	' format: {package name . (file upToEnd copyReplaceAll: '''' with: '"')})  classified: ('constructor-{1}'format: { package name }).
	
	file close.
	^ 'xml{1}' format: { package name }.
	
	
]

{ #category : #abstract }
PhaROSCatkinPackage >> generateConstructor [
	self class class compile: ('create{1} 
		^ PhaROSCatkinPackage new pharosPackage: { 1 }; cmake: PhaROSCatkinPackage { 2}; xml: PhaROSCatkinPackage { 3 }; rosDependencies: { 4 }; yourself. 
	' format: { package name . self encodeCMAKE . self encodeXML . rosDependancies asString }
	
	 ) classified: ('constructor-{1}'format: { package name })
]

{ #category : #abstract }
PhaROSCatkinPackage >> generateRosPackageInflationScript [
	^ '
	
		StandardFileStream stdout nextPutAll: ''(1/1)- Catkin remote installation.. inflating package '', String crlf.
		PhaROSPackageManager new inflatePackage: (
			PhaROSCatkinPackage new location: ''{1}'';
										pharosPackage: {2}; 
										rosDependencies: {3}; 
										encodeFiles;
										yourself			
		).
		StandardFileStream stdout nextPutAll: '' Done :)  '', String crlf.
		Smalltalk snapshot: true andQuit: true.
	' format: {
		location .
		package name. 
		rosDependancies asString
	}.
	
]

{ #category : #accessing }
PhaROSCatkinPackage >> hash [
	^ (package hash asString, location) hash.
]

{ #category : #path }
PhaROSCatkinPackage >> image [
	^ self path ,'/image/Pharo.image'
]

{ #category : #path }
PhaROSCatkinPackage >> imageFolder [
	^ self path ,'/image'
]

{ #category : #abstract }
PhaROSCatkinPackage >> install [

	self cmake ifNil: [ 
		PhaROSPackageManager new create: self  
	] ifNotNil: [
		PhaROSPackageManager new install: self  
	] .


	self generateConstructor.
]

{ #category : #abstract }
PhaROSCatkinPackage >> installPackageInDeploy [
	
	"Catking ending installation"
	
	PhaROSPackageDeployer new execute: self image  with: self vm  and: self generateRosPackageInflationScript.  
	

]

{ #category : #path }
PhaROSCatkinPackage >> installScript: aScriptSelector [
	PhaROSPackageManager new installScript: aScriptSelector of: self.
]

{ #category : #abstract }
PhaROSCatkinPackage >> location [
	^ location ifNil:[ self error: 'location is not setted' ].
]

{ #category : #abstract }
PhaROSCatkinPackage >> location: aLocation [
	
	location := aLocation.
]

{ #category : #path }
PhaROSCatkinPackage >> mainBinary [
	^ self bin, '/pharos'.
]

{ #category : #path }
PhaROSCatkinPackage >> mainEdit [
	^ self bin, '/edit'.
]

{ #category : #path }
PhaROSCatkinPackage >> mainHeadless [
	^ self bin, '/headless'.
]

{ #category : #abstract }
PhaROSCatkinPackage >> make [
		PhaROSPackageManager new make: self.
	
]

{ #category : #path }
PhaROSCatkinPackage >> msg [
	^ self path ,'/msg'
]

{ #category : #path }
PhaROSCatkinPackage >> packageName [
	^ package packageName
]

{ #category : #path }
PhaROSCatkinPackage >> packageXML [ 

	^ self path, '/package.xml' 
]

{ #category : #path }
PhaROSCatkinPackage >> path [
	^ self location, '/', self packageName 
]

{ #category : #accessing }
PhaROSCatkinPackage >> pharosPackage [
	^package
]

{ #category : #accessing }
PhaROSCatkinPackage >> pharosPackage: aPackage [ 
	package := aPackage
]

{ #category : #accessing }
PhaROSCatkinPackage >> rosDependencies [ 
	^ rosDependancies 
]

{ #category : #accessing }
PhaROSCatkinPackage >> rosDependencies: aCollection [ 
	 rosDependancies := aCollection
]

{ #category : #accessing }
PhaROSCatkinPackage >> rosDependenciesString [
	^ self rosDependencies inject: '' into:  [: dep :acc | acc,' ', dep asString] .
]

{ #category : #'initialize-release' }
PhaROSCatkinPackage >> scriptMethods [


	^ package allMethods select: [ :m | (m selector asString beginsWith: 'script' ) and: [ m selector isUnary ] ] 
]

{ #category : #path }
PhaROSCatkinPackage >> scripts [
	^ self path ,'/image/scripts'
]

{ #category : #accessing }
PhaROSCatkinPackage >> version [
	^ package version
]

{ #category : #path }
PhaROSCatkinPackage >> vm [
	^ self path ,'/vm/pharo'
]

{ #category : #path }
PhaROSCatkinPackage >> vmFolder [
	^ self path ,'/vm'
]

{ #category : #abstract }
PhaROSCatkinPackage >> xml [
	^ xml
]

{ #category : #abstract }
PhaROSCatkinPackage >> xml: aPackageXMLDef [
	xml := aPackageXMLDef .
]
