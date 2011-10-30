// This file has been generated by Py++.

#include "boost/python.hpp"
#include "python_CEGUI.h"
#include "Property.pypp.hpp"

namespace bp = boost::python;

struct Property_wrapper : CEGUI::Property, bp::wrapper< CEGUI::Property > {

    Property_wrapper(::CEGUI::String const & name, ::CEGUI::String const & help, ::CEGUI::String const & defaultValue="", bool writesXML=true, ::CEGUI::String const & dataType="Unknown", ::CEGUI::String const & origin="Unknown" )
    : CEGUI::Property( boost::ref(name), boost::ref(help), boost::ref(defaultValue), writesXML, boost::ref(dataType), boost::ref(origin) )
      , bp::wrapper< CEGUI::Property >(){
        // constructor
    
    }

    virtual ::CEGUI::String get( ::CEGUI::PropertyReceiver const * receiver ) const {
        bp::override func_get = this->get_override( "get" );
        return func_get( boost::python::ptr(receiver) );
    }

    virtual ::CEGUI::String getDefault( ::CEGUI::PropertyReceiver const * receiver ) const  {
        if( bp::override func_getDefault = this->get_override( "getDefault" ) )
            return func_getDefault( boost::python::ptr(receiver) );
        else{
            return this->CEGUI::Property::getDefault( boost::python::ptr(receiver) );
        }
    }
    
    ::CEGUI::String default_getDefault( ::CEGUI::PropertyReceiver const * receiver ) const  {
        return CEGUI::Property::getDefault( boost::python::ptr(receiver) );
    }

    virtual bool isDefault( ::CEGUI::PropertyReceiver const * receiver ) const  {
        if( bp::override func_isDefault = this->get_override( "isDefault" ) )
            return func_isDefault( boost::python::ptr(receiver) );
        else{
            return this->CEGUI::Property::isDefault( boost::python::ptr(receiver) );
        }
    }
    
    bool default_isDefault( ::CEGUI::PropertyReceiver const * receiver ) const  {
        return CEGUI::Property::isDefault( boost::python::ptr(receiver) );
    }

    virtual bool isReadable(  ) const  {
        if( bp::override func_isReadable = this->get_override( "isReadable" ) )
            return func_isReadable(  );
        else{
            return this->CEGUI::Property::isReadable(  );
        }
    }
    
    bool default_isReadable(  ) const  {
        return CEGUI::Property::isReadable( );
    }

    virtual bool isWritable(  ) const  {
        if( bp::override func_isWritable = this->get_override( "isWritable" ) )
            return func_isWritable(  );
        else{
            return this->CEGUI::Property::isWritable(  );
        }
    }
    
    bool default_isWritable(  ) const  {
        return CEGUI::Property::isWritable( );
    }

    virtual void set( ::CEGUI::PropertyReceiver * receiver, ::CEGUI::String const & value ){
        bp::override func_set = this->get_override( "set" );
        func_set( boost::python::ptr(receiver), boost::ref(value) );
    }

    virtual void writeXMLToStream( ::CEGUI::PropertyReceiver const * receiver, ::CEGUI::XMLSerializer & xml_stream ) const  {
        if( bp::override func_writeXMLToStream = this->get_override( "writeXMLToStream" ) )
            func_writeXMLToStream( boost::python::ptr(receiver), boost::ref(xml_stream) );
        else{
            this->CEGUI::Property::writeXMLToStream( boost::python::ptr(receiver), boost::ref(xml_stream) );
        }
    }
    
    void default_writeXMLToStream( ::CEGUI::PropertyReceiver const * receiver, ::CEGUI::XMLSerializer & xml_stream ) const  {
        CEGUI::Property::writeXMLToStream( boost::python::ptr(receiver), boost::ref(xml_stream) );
    }

};

void register_Property_class(){

    { //::CEGUI::Property
        typedef bp::class_< Property_wrapper, boost::noncopyable > Property_exposer_t;
        Property_exposer_t Property_exposer = Property_exposer_t( "Property", bp::init< CEGUI::String const &, CEGUI::String const &, bp::optional< CEGUI::String const &, bool, CEGUI::String const &, CEGUI::String const & > >(( bp::arg("name"), bp::arg("help"), bp::arg("defaultValue")="", bp::arg("writesXML")=(bool)(true), bp::arg("dataType")="Unknown", bp::arg("origin")="Unknown" ), "*!\n\
           \n\
              Creates a new Property object.\n\
        \n\
           @param name\n\
              String containing the name of the new Property.\n\
        \n\
           @param help\n\
              String containing a description of the Property and it's usage.\n\
              \n\
           @param defaultValue\n\
              String holding the textual representation of the default value for this Property\n\
        \n\
            @param writesXML\n\
                Specifies whether the writeXMLToStream method should do anything for this Property.  This\n\
                enables selectivity in what properties within a PropertySet will get output as XML.\n\
        \n\
           @param dataType\n\
               String representation of the data type this property is held in (int, UVector2, ...)\n\
        \n\
           @param origin\n\
               String describing the origin class of this Property (Window, FrameWindow, ...)\n\
           *\n") );
        bp::scope Property_scope( Property_exposer );
        { //::CEGUI::Property::get
        
            typedef ::CEGUI::String ( ::CEGUI::Property::*get_function_type )( ::CEGUI::PropertyReceiver const * ) const;
            
            Property_exposer.def( 
                "get"
                , bp::pure_virtual( get_function_type(&::CEGUI::Property::get) )
                , ( bp::arg("receiver") )
                , "*!\n\
               \n\
                  Return the current value of the Property as a String\n\
            \n\
               @param receiver\n\
                  Pointer to the target object.\n\
            \n\
               @return\n\
                  String object containing a textual representation of the current value of the Property\n\
               *\n" );
        
        }
        { //::CEGUI::Property::getDataType
        
            typedef ::CEGUI::String const & ( ::CEGUI::Property::*getDataType_function_type )(  ) const;
            
            Property_exposer.def( 
                "getDataType"
                , getDataType_function_type( &::CEGUI::Property::getDataType )
                , bp::return_value_policy< bp::copy_const_reference >()
                , "*!\n\
               \n\
                  Return string data type of this Property\n\
            \n\
               @return\n\
                  String containing the data type of the Property\n\
               *\n" );
        
        }
        { //::CEGUI::Property::getDefault
        
            typedef ::CEGUI::String ( ::CEGUI::Property::*getDefault_function_type )( ::CEGUI::PropertyReceiver const * ) const;
            typedef ::CEGUI::String ( Property_wrapper::*default_getDefault_function_type )( ::CEGUI::PropertyReceiver const * ) const;
            
            Property_exposer.def( 
                "getDefault"
                , getDefault_function_type(&::CEGUI::Property::getDefault)
                , default_getDefault_function_type(&Property_wrapper::default_getDefault)
                , ( bp::arg("receiver") ) );
        
        }
        { //::CEGUI::Property::getHelp
        
            typedef ::CEGUI::String const & ( ::CEGUI::Property::*getHelp_function_type )(  ) const;
            
            Property_exposer.def( 
                "getHelp"
                , getHelp_function_type( &::CEGUI::Property::getHelp )
                , bp::return_value_policy< bp::copy_const_reference >()
                , "*!\n\
               \n\
                  Return a String that describes the purpose and usage of this Property.\n\
            \n\
               @return\n\
                  String that contains the help text\n\
               *\n" );
        
        }
        { //::CEGUI::Property::getName
        
            typedef ::CEGUI::String const & ( ::CEGUI::Property::*getName_function_type )(  ) const;
            
            Property_exposer.def( 
                "getName"
                , getName_function_type( &::CEGUI::Property::getName )
                , bp::return_value_policy< bp::copy_const_reference >()
                , "*!\n\
               \n\
                  Return a the name of this Property\n\
            \n\
               @return\n\
                  String containing the name of the Property\n\
               *\n" );
        
        }
        { //::CEGUI::Property::getOrigin
        
            typedef ::CEGUI::String const & ( ::CEGUI::Property::*getOrigin_function_type )(  ) const;
            
            Property_exposer.def( 
                "getOrigin"
                , getOrigin_function_type( &::CEGUI::Property::getOrigin )
                , bp::return_value_policy< bp::copy_const_reference >()
                , "*!\n\
                \n\
                    Return string origin of this Property\n\
            \n\
                @return\n\
                    String containing the origin of the Property\n\
                *\n" );
        
        }
        { //::CEGUI::Property::isDefault
        
            typedef bool ( ::CEGUI::Property::*isDefault_function_type )( ::CEGUI::PropertyReceiver const * ) const;
            typedef bool ( Property_wrapper::*default_isDefault_function_type )( ::CEGUI::PropertyReceiver const * ) const;
            
            Property_exposer.def( 
                "isDefault"
                , isDefault_function_type(&::CEGUI::Property::isDefault)
                , default_isDefault_function_type(&Property_wrapper::default_isDefault)
                , ( bp::arg("receiver") ) );
        
        }
        { //::CEGUI::Property::isReadable
        
            typedef bool ( ::CEGUI::Property::*isReadable_function_type )(  ) const;
            typedef bool ( Property_wrapper::*default_isReadable_function_type )(  ) const;
            
            Property_exposer.def( 
                "isReadable"
                , isReadable_function_type(&::CEGUI::Property::isReadable)
                , default_isReadable_function_type(&Property_wrapper::default_isReadable) );
        
        }
        { //::CEGUI::Property::isWritable
        
            typedef bool ( ::CEGUI::Property::*isWritable_function_type )(  ) const;
            typedef bool ( Property_wrapper::*default_isWritable_function_type )(  ) const;
            
            Property_exposer.def( 
                "isWritable"
                , isWritable_function_type(&::CEGUI::Property::isWritable)
                , default_isWritable_function_type(&Property_wrapper::default_isWritable) );
        
        }
        { //::CEGUI::Property::set
        
            typedef void ( ::CEGUI::Property::*set_function_type )( ::CEGUI::PropertyReceiver *,::CEGUI::String const & ) ;
            
            Property_exposer.def( 
                "set"
                , bp::pure_virtual( set_function_type(&::CEGUI::Property::set) )
                , ( bp::arg("receiver"), bp::arg("value") )
                , "*!\n\
               \n\
                  Sets the value of the property\n\
            \n\
               @param receiver\n\
                  Pointer to the target object.\n\
            \n\
               @param value\n\
                  A String object that contains a textual representation of the new value to assign to the\
                  Property.\n\
            \n\
               @return\n\
                  Nothing.\n\
            \n\
               @exception InvalidRequestException  Thrown when the Property was unable to interpret the content\
               of  value.\n\
               *\n" );
        
        }
        { //::CEGUI::Property::writeXMLToStream
        
            typedef void ( ::CEGUI::Property::*writeXMLToStream_function_type )( ::CEGUI::PropertyReceiver const *,::CEGUI::XMLSerializer & ) const;
            typedef void ( Property_wrapper::*default_writeXMLToStream_function_type )( ::CEGUI::PropertyReceiver const *,::CEGUI::XMLSerializer & ) const;
            
            Property_exposer.def( 
                "writeXMLToStream"
                , writeXMLToStream_function_type(&::CEGUI::Property::writeXMLToStream)
                , default_writeXMLToStream_function_type(&Property_wrapper::default_writeXMLToStream)
                , ( bp::arg("receiver"), bp::arg("xml_stream") ) );
        
        }
    }

}
