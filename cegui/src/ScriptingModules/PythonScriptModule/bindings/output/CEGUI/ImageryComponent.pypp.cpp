// This file has been generated by Py++.

#include "boost/python.hpp"
#include "python_CEGUI.h"
#include "ImageryComponent.pypp.hpp"

namespace bp = boost::python;

void register_ImageryComponent_class(){

    { //::CEGUI::ImageryComponent
        typedef bp::class_< CEGUI::ImageryComponent, bp::bases< CEGUI::FalagardComponentBase > > ImageryComponent_exposer_t;
        ImageryComponent_exposer_t ImageryComponent_exposer = ImageryComponent_exposer_t( "ImageryComponent", "*!\n\
        \n\
            Class that encapsulates information for a single image component.\n\
        *\n", bp::init< >("*!\n\
        \n\
            Constructor\n\
        *\n") );
        bp::scope ImageryComponent_scope( ImageryComponent_exposer );
        { //::CEGUI::ImageryComponent::getHorizontalFormatting
        
            typedef ::CEGUI::HorizontalFormatting ( ::CEGUI::ImageryComponent::*getHorizontalFormatting_function_type )(  ) const;
            
            ImageryComponent_exposer.def( 
                "getHorizontalFormatting"
                , getHorizontalFormatting_function_type( &::CEGUI::ImageryComponent::getHorizontalFormatting )
                , "*!\n\
                    \n\
                        Return the current horizontal formatting setting for this ImageryComponent.\n\
            \n\
                    @return\n\
                        One of the HorizontalFormatting enumerated values.\n\
                    *\n" );
        
        }
        { //::CEGUI::ImageryComponent::getImage
        
            typedef ::CEGUI::Image const * ( ::CEGUI::ImageryComponent::*getImage_function_type )(  ) const;
            
            ImageryComponent_exposer.def( 
                "getImage"
                , getImage_function_type( &::CEGUI::ImageryComponent::getImage )
                , bp::return_value_policy< bp::reference_existing_object >()
                , "*!\n\
                    \n\
                        Return the Image object that will be drawn by this ImageryComponent.\n\
            \n\
                    @return\n\
                        Image object.\n\
                    *\n" );
        
        }
        { //::CEGUI::ImageryComponent::getImagePropertySource
        
            typedef ::CEGUI::String const & ( ::CEGUI::ImageryComponent::*getImagePropertySource_function_type )(  ) const;
            
            ImageryComponent_exposer.def( 
                "getImagePropertySource"
                , getImagePropertySource_function_type( &::CEGUI::ImageryComponent::getImagePropertySource )
                , bp::return_value_policy< bp::copy_const_reference >()
                , "*!\n\
                    \n\
                        Return the name of the property that will be used to determine the image for this\
                        ImageryComponent.\n\
            \n\
                    @return\n\
                        String object holding the name of a Propery.\n\
                    *\n" );
        
        }
        { //::CEGUI::ImageryComponent::getVerticalFormatting
        
            typedef ::CEGUI::VerticalFormatting ( ::CEGUI::ImageryComponent::*getVerticalFormatting_function_type )(  ) const;
            
            ImageryComponent_exposer.def( 
                "getVerticalFormatting"
                , getVerticalFormatting_function_type( &::CEGUI::ImageryComponent::getVerticalFormatting )
                , "*!\n\
                    \n\
                        Return the current vertical formatting setting for this ImageryComponent.\n\
            \n\
                    @return\n\
                        One of the VerticalFormatting enumerated values.\n\
                    *\n" );
        
        }
        { //::CEGUI::ImageryComponent::isImageFetchedFromProperty
        
            typedef bool ( ::CEGUI::ImageryComponent::*isImageFetchedFromProperty_function_type )(  ) const;
            
            ImageryComponent_exposer.def( 
                "isImageFetchedFromProperty"
                , isImageFetchedFromProperty_function_type( &::CEGUI::ImageryComponent::isImageFetchedFromProperty )
                , "*!\n\
                    \n\
                        Return whether this ImageryComponent fetches it's image via a property on the target\
                        window.\n\
            \n\
                    @return\n\
                        - true if the image comes via a Propery.\n\
                        - false if the image is defined explicitly.\n\
                    *\n" );
        
        }
        { //::CEGUI::ImageryComponent::setHorizontalFormatting
        
            typedef void ( ::CEGUI::ImageryComponent::*setHorizontalFormatting_function_type )( ::CEGUI::HorizontalFormatting ) ;
            
            ImageryComponent_exposer.def( 
                "setHorizontalFormatting"
                , setHorizontalFormatting_function_type( &::CEGUI::ImageryComponent::setHorizontalFormatting )
                , ( bp::arg("fmt") )
                , "*!\n\
                    \n\
                        Set the horizontal formatting setting for this ImageryComponent.\n\
            \n\
                    @param fmt\n\
                        One of the HorizontalFormatting enumerated values.\n\
            \n\
                    @return\n\
                        Nothing.\n\
                    *\n" );
        
        }
        { //::CEGUI::ImageryComponent::setImage
        
            typedef void ( ::CEGUI::ImageryComponent::*setImage_function_type )( ::CEGUI::Image const * ) ;
            
            ImageryComponent_exposer.def( 
                "setImage"
                , setImage_function_type( &::CEGUI::ImageryComponent::setImage )
                , ( bp::arg("image") )
                , "*!\n\
                    \n\
                        Set the Image that will be drawn by this ImageryComponent.\n\
            \n\
                    @param\n\
                        Pointer to the Image object to be drawn by this ImageryComponent.\n\
            \n\
                    @return\n\
                        Nothing.\n\
                    *\n" );
        
        }
        { //::CEGUI::ImageryComponent::setImage
        
            typedef void ( ::CEGUI::ImageryComponent::*setImage_function_type )( ::CEGUI::String const &,::CEGUI::String const & ) ;
            
            ImageryComponent_exposer.def( 
                "setImage"
                , setImage_function_type( &::CEGUI::ImageryComponent::setImage )
                , ( bp::arg("imageset"), bp::arg("image") )
                , "*!\n\
                    \n\
                        Set the Image that will be drawn by this ImageryComponent.\n\
            \n\
                    @param imageset\n\
                        String holding the name of the Imagset that contains the Image to be rendered.\n\
            \n\
                    @param image\n\
                        String holding the name of the Image to be rendered.\n\
            \n\
                    @return\n\
                        Nothing.\n\
                    *\n" );
        
        }
        { //::CEGUI::ImageryComponent::setImagePropertySource
        
            typedef void ( ::CEGUI::ImageryComponent::*setImagePropertySource_function_type )( ::CEGUI::String const & ) ;
            
            ImageryComponent_exposer.def( 
                "setImagePropertySource"
                , setImagePropertySource_function_type( &::CEGUI::ImageryComponent::setImagePropertySource )
                , ( bp::arg("property") )
                , "*!\n\
                    \n\
                        Set the name of the property that will be used to determine the image for this\
                        ImageryComponent.\n\
            \n\
                    @param property\n\
                        String object holding the name of a Propery.  The property should access a imageset &\
                        image specification.\n\
            \n\
                    @return\n\
                        Nothing.\n\
                    *\n" );
        
        }
        { //::CEGUI::ImageryComponent::setVerticalFormatting
        
            typedef void ( ::CEGUI::ImageryComponent::*setVerticalFormatting_function_type )( ::CEGUI::VerticalFormatting ) ;
            
            ImageryComponent_exposer.def( 
                "setVerticalFormatting"
                , setVerticalFormatting_function_type( &::CEGUI::ImageryComponent::setVerticalFormatting )
                , ( bp::arg("fmt") )
                , "*!\n\
                    \n\
                        Set the vertical formatting setting for this ImageryComponent.\n\
            \n\
                    @param fmt\n\
                        One of the VerticalFormatting enumerated values.\n\
            \n\
                    @return\n\
                        Nothing.\n\
                    *\n" );
        
        }
        { //::CEGUI::ImageryComponent::writeXMLToStream
        
            typedef void ( ::CEGUI::ImageryComponent::*writeXMLToStream_function_type )( ::CEGUI::XMLSerializer & ) const;
            
            ImageryComponent_exposer.def( 
                "writeXMLToStream"
                , writeXMLToStream_function_type( &::CEGUI::ImageryComponent::writeXMLToStream )
                , ( bp::arg("xml_stream") )
                , "*!\n\
                    \n\
                        Writes an xml representation of this ImageryComponent to  out_stream.\n\
            \n\
                    @param xml_stream\n\
                        Stream where xml data should be output.\n\
            \n\
            \n\
                    @return\n\
                        Nothing.\n\
                    *\n" );
        
        }
    }

}
