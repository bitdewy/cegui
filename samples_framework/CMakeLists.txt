# We check if the required dependencies are available for the sample framework

if(NOT CEGUI_BUILD_LUA_MODULE)
    message(SEND_ERROR "The Samples enbabled - LuaScript Module is required. Please add the dependencies and run 'Configure' in CMake again.")
endif()

if(CEGUI_BUILD_RENDERER_OGRE AND NOT CEGUI_OGRE_SAMPLES_AVAILABLE)
    message(SEND_ERROR "The Samples and the OgreRenderer are enabled, but Ogre dependencies are missing (boost). Please add the dependencies and run 'Configure' in CMake again.")
endif()
if(CEGUI_BUILD_RENDERER_OPENGL OR CEGUI_BUILD_RENDERER_OPENGL3)
    if(NOT GLFW_FOUND)
        message(SEND_ERROR "The Samples and the OpenGL or OpenGL3+ Renderer are enabled - GLFW is required for this configuration but was not found. Please add GFLW to your dependencies and run 'Configure' in CMake again.")
    endif()
endif()


set( CEGUI_TARGET_NAME ${CEGUI_SAMPLEFRAMEWORK_EXENAME} )

set( CORE_SOURCE_FILES
    ./src/SamplesFrameworkBase.cpp
    ./src/SamplesFramework.cpp
    ./src/CEGuiBaseApplication.cpp
    ./src/CEGuiRendererSelector.cpp
    ./src/Samples_xmlHandler.cpp
    ./src/SampleData.cpp
    ./src/MetaDataWindowManager.cpp
    ./src/SamplesBrowserManager.cpp
)

set( CORE_HEADER_FILES
    ../samples/common/include/Sample.h
    ./include/SamplesFrameworkBase.h
    ./include/SamplesFramework.h
    ./include/CEGuiBaseApplication.h
    ./include/CEGuiRendererSelector.h
    ./include/Samples_xmlHandler.h
    ./include/SampleData.h
    ./include/MetaDataWindowManager.h
    ./include/SamplesBrowserManager.h
)


include_directories(${CMAKE_SOURCE_DIR}/samples_framework/include
                    ${CMAKE_BINARY_DIR}/samples/common/include
                    ${CMAKE_SOURCE_DIR}/samples/common/include
                    ${CMAKE_SOURCE_DIR}/cegui/include)

if (WIN32)
    list (APPEND CORE_SOURCE_FILES
        ./src/Win32AppHelper.cpp
        ./src/Win32CEGuiRendererSelector.cpp
    )
elseif (APPLE)
    list (APPEND CORE_SOURCE_FILES
        ./src/MacCEGuiRendererSelector.mm
    )
elseif (CEGUI_SAMPLES_USE_GTK2)
    list (APPEND CORE_SOURCE_FILES
        ./src/GTK2CEGuiRendererSelector.cpp
    )
else()
    list (APPEND CORE_SOURCE_FILES
        ./src/CLICEGuiRendererSelector.cpp
    )
endif()


if (CEGUI_BUILD_RENDERER_OPENGL OR CEGUI_BUILD_RENDERER_OPENGL3)
    list (APPEND CORE_SOURCE_FILES
        ./src/CEGuiGLFWSharedBase.cpp
    )
endif()

if (CEGUI_BUILD_RENDERER_OPENGL)
    list (APPEND CORE_SOURCE_FILES
        ./src/CEGuiOpenGLBaseApplication.cpp
    )
endif()

if (CEGUI_BUILD_RENDERER_OPENGL3)
    list (APPEND CORE_SOURCE_FILES
        ./src/CEGuiOpenGL3BaseApplication.cpp
    )
endif()

if (CEGUI_OGRE_SAMPLES_AVAILABLE)
    # this prevents the boost auto-link dis-feature
    add_definitions(-DBOOST_ALL_NO_LIB)

    list (APPEND CORE_SOURCE_FILES
        ./src/CEGuiOgreBaseApplication.cpp
    )
endif()

if (CEGUI_BUILD_RENDERER_IRRLICHT)
    list (APPEND CORE_SOURCE_FILES
        ./src/CEGuiIrrlichtBaseApplication.cpp
    )
endif()

if (CEGUI_BUILD_RENDERER_DIRECT3D9)
    list (APPEND CORE_SOURCE_FILES
        ./src/CEGuiD3D9BaseApplication.cpp
        ./src/DeviceReset_Direct3D9.cpp
    )
endif()

if (CEGUI_BUILD_RENDERER_DIRECT3D10)
    list (APPEND CORE_SOURCE_FILES
        ./src/CEGuiD3D10BaseApplication.cpp
        ./src/DeviceReset_Direct3D10.cpp
    )
endif()

if (CEGUI_BUILD_RENDERER_DIRECT3D11)
    list (APPEND CORE_SOURCE_FILES
        ./src/CEGuiD3D11BaseApplication.cpp
        ./src/DeviceReset_Direct3D11.cpp
    )
endif()

if (CEGUI_BUILD_RENDERER_DIRECTFB)
    list (APPEND CORE_SOURCE_FILES
        ./src/CEGuiDirectFBBaseApplication.cpp
    )
endif()

if (CEGUI_BUILD_RENDERER_DIRECT3D9 OR CEGUI_BUILD_RENDERER_DIRECT3D10 OR CEGUI_BUILD_RENDERER_DIRECT3D11)
    include_directories(${DIRECTXSDK_INCLUDE_DIR})
    link_directories(${DIRECTXSDK_LIBRARY_DIR})
endif()

###########################################################################
#                     Statically Linked Executable
###########################################################################
if (CEGUI_BUILD_STATIC_CONFIGURATION)
    add_executable(${CEGUI_TARGET_NAME}_Static ${CORE_SOURCE_FILES} ${CORE_HEADER_FILES})
    set_property(TARGET ${CEGUI_TARGET_NAME}_Static APPEND PROPERTY COMPILE_DEFINITIONS CEGUI_STATIC)

    # append the _d (or whatever) for debug builds as needed.
    if (CEGUI_HAS_BUILD_SUFFIX AND CEGUI_BUILD_SUFFIX)
        set_target_properties(${CEGUI_TARGET_NAME}_Static PROPERTIES
            OUTPUT_NAME_DEBUG "${CEGUI_TARGET_NAME}_Static${CEGUI_BUILD_SUFFIX}"
        )
    endif()

    # This works around an issue in the prebuilt deps and can be removed once those are fixed :)
    if (WIN32)
        set_target_properties(${CEGUI_TARGET_NAME}_Static PROPERTIES LINK_FLAGS_DEBUG /NODEFAULTLIB:freeglut.lib)
    endif()

    if (APPLE)
        cegui_apple_app_setup(${CEGUI_TARGET_NAME}_Static TRUE)
    endif()
endif()

###########################################################################
#                   Dynamically Linked Executable
###########################################################################
add_executable(${CEGUI_TARGET_NAME} ${CORE_SOURCE_FILES} ${CORE_HEADER_FILES})

# append the _d (or whatever) for debug builds as needed.
if (CEGUI_HAS_BUILD_SUFFIX AND CEGUI_BUILD_SUFFIX)
    set_target_properties(${CEGUI_TARGET_NAME} PROPERTIES
        OUTPUT_NAME_DEBUG "${CEGUI_TARGET_NAME}${CEGUI_BUILD_SUFFIX}"
    )
endif()

if (NOT APPLE AND CEGUI_INSTALL_WITH_RPATH)
    set_target_properties(${CEGUI_TARGET_NAME} PROPERTIES
        INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${CEGUI_LIB_INSTALL_DIR}"
    )
endif()

if (APPLE)
    # we add these to ensure the dynamically loaded modules we will be
    # using are built before the .app's post build step that copies
    # libs into the app bundle.
    add_dependencies(${CEGUI_TARGET_NAME} ${CEGUI_CORE_WR_LIBNAME}
                                          CEGUI${CEGUI_OPTION_DEFAULT_XMLPARSER}
                                          CEGUI${CEGUI_OPTION_DEFAULT_IMAGECODEC}
    )

    cegui_apple_app_setup(${CEGUI_TARGET_NAME} FALSE)
endif()

###########################################################################
#                    MSVC PROJ USER FILE TEMPLATES
###########################################################################
if (MSVC)
    configure_file(
        ${CMAKE_MODULE_PATH}/templates/VisualStudioUserFile.vcproj.user.in
        ${CMAKE_CURRENT_BINARY_DIR}/${CEGUI_TARGET_NAME}.vcproj.user
        @ONLY
    )
    configure_file(
        ${CMAKE_MODULE_PATH}/templates/VisualStudioUserFile.vcxproj.user.in
        ${CMAKE_CURRENT_BINARY_DIR}/${CEGUI_TARGET_NAME}.vcxproj.user
        @ONLY
    )
endif ()


###########################################################################
#                      LIBRARY LINK SETUP
###########################################################################
cegui_target_link_libraries(${CEGUI_TARGET_NAME} ${CEGUI_BASE_LIBNAME})

if (CEGUI_BUILD_STATIC_CONFIGURATION)
    target_link_libraries(${CEGUI_TARGET_NAME}_Static
        ${CEGUI_STATIC_XMLPARSER_MODULE}_Static
        ${CEGUI_STATIC_IMAGECODEC_MODULE}_Static
        ${CEGUI_CORE_WR_LIBNAME}_Static
    )
endif()

###########################################################################
#  BUILD DEPENDENCIES FOR THE SHARED LIBRARIES USED BY THE SAMPLEBROWSER
###########################################################################

add_dependencies(${CEGUI_TARGET_NAME} ${CEGUI_CORE_WR_LIBNAME}
                                      CEGUI${CEGUI_OPTION_DEFAULT_XMLPARSER}
                                      CEGUI${CEGUI_OPTION_DEFAULT_IMAGECODEC})
                                      
if (CEGUI_SAMPLES_ENABLE_COMMON_DIALOGUES_DEMO)
    add_dependencies(${CEGUI_TARGET_NAME} ${CEGUI_COMMON_DIALOGS_LIBNAME})
endif()

###########################################################################
#                           INSTALLATION
###########################################################################
install(TARGETS ${CEGUI_TARGET_NAME}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION ${CEGUI_LIB_INSTALL_DIR}
    ARCHIVE DESTINATION ${CEGUI_LIB_INSTALL_DIR}
    BUNDLE DESTINATION ${CEGUI_LIB_INSTALL_DIR}
)

if (CEGUI_BUILD_STATIC_CONFIGURATION)
    install(TARGETS ${CEGUI_TARGET_NAME}_Static
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION ${CEGUI_LIB_INSTALL_DIR}
        ARCHIVE DESTINATION ${CEGUI_LIB_INSTALL_DIR}
        BUNDLE DESTINATION ${CEGUI_LIB_INSTALL_DIR}
)
endif()

if (CEGUI_BUILD_RENDERER_OPENGL OR CEGUI_BUILD_RENDERER_OPENGL3)
    cegui_add_dependency(${CEGUI_TARGET_NAME} OPENGL)
    cegui_add_dependency(${CEGUI_TARGET_NAME} GLFW)
    cegui_target_link_libraries(${CEGUI_TARGET_NAME} ${CEGUI_OPENGL_RENDERER_LIBNAME})
endif()

if (CEGUI_BUILD_RENDERER_OGRE)
    cegui_add_dependency(${CEGUI_TARGET_NAME} OGRE)
    cegui_add_dependency(${CEGUI_TARGET_NAME} OIS)
    cegui_target_link_libraries(${CEGUI_TARGET_NAME} ${CEGUI_OGRE_RENDERER_LIBNAME} ${CEGUI_OGRE_SAMPLES_EXTRALIBS})
endif()

if (CEGUI_BUILD_RENDERER_IRRLICHT)
    cegui_add_dependency(${CEGUI_TARGET_NAME} IRRLICHT)
    cegui_target_link_libraries(${CEGUI_TARGET_NAME} ${CEGUI_IRRLICHT_RENDERER_LIBNAME})
endif()

if (CEGUI_BUILD_RENDERER_DIRECT3D9 OR CEGUI_BUILD_RENDERER_DIRECT3D10 OR CEGUI_BUILD_RENDERER_DIRECT3D11)
    cegui_target_link_libraries(${CEGUI_TARGET_NAME} dxerr)

    if (CEGUI_BUILD_RENDERER_DIRECT3D9)
        cegui_target_link_libraries(${CEGUI_TARGET_NAME} ${CEGUI_DIRECT3D9_RENDERER_LIBNAME} d3d9)
    endif()

    if (CEGUI_BUILD_RENDERER_DIRECT3D10)
        cegui_target_link_libraries(${CEGUI_TARGET_NAME} ${CEGUI_DIRECT3D10_RENDERER_LIBNAME} d3d10)
    endif()

    if (CEGUI_BUILD_RENDERER_DIRECT3D11)
        cegui_target_link_libraries(${CEGUI_TARGET_NAME} ${CEGUI_DIRECT3D11_RENDERER_LIBNAME} d3d11)
    endif()

endif()

if (CEGUI_BUILD_RENDERER_DIRECTFB)
    cegui_add_dependency(${CEGUI_TARGET_NAME} DIRECTFB)
    cegui_target_link_libraries(${CEGUI_TARGET_NAME} ${CEGUI_DIRECTFB_RENDERER_LIBNAME})
endif()

if (CEGUI_SAMPLES_USE_GTK2)
    cegui_add_dependency(${CEGUI_TARGET_NAME} GTK2)
endif()

if (APPLE)
    set (CEGUI_EXTRA_FRAMEWORKS "-framework Cocoa")

    if (CEGUI_BUILD_RENDERER_OGRE)
        set (CEGUI_EXTRA_FRAMEWORKS "${CEGUI_EXTRA_FRAMEWORKS} -framework IOKit -framework Carbon")
    endif()

    set_target_properties(${CEGUI_TARGET_NAME} PROPERTIES
        LINK_FLAGS ${CEGUI_EXTRA_FRAMEWORKS}
    )
endif()

cegui_target_link_libraries(${CEGUI_TARGET_NAME} ${CEGUI_BASE_LIBNAME} ${CEGUI_LUA_SCRIPTMODULE_LIBNAME})
