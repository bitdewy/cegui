// This file has been generated by Py++.

#include "boost/python.hpp"
#include "python_CEGUI.h"
#include "UVector2.pypp.hpp"

namespace bp = boost::python;

void register_UVector2_class(){

    { //::CEGUI::Vector2< CEGUI::UDim >
        typedef bp::class_< CEGUI::Vector2< CEGUI::UDim > > UVector2_exposer_t;
        UVector2_exposer_t UVector2_exposer = UVector2_exposer_t( "UVector2", bp::init< >() );
        bp::scope UVector2_scope( UVector2_exposer );
        UVector2_exposer.def( bp::init< CEGUI::UDim, CEGUI::UDim >(( bp::arg("x"), bp::arg("y") )) );
        UVector2_exposer.def( bp::init< CEGUI::Vector2< CEGUI::UDim > const & >(( bp::arg("v") )) );
        { //::CEGUI::Vector2< CEGUI::UDim >::one
        
            typedef CEGUI::Vector2< CEGUI::UDim > exported_class_t;
            typedef ::CEGUI::Vector2< CEGUI::UDim > ( *one_function_type )(  );
            
            UVector2_exposer.def( 
                "one"
                , one_function_type( &::CEGUI::Vector2< CEGUI::UDim >::one )
                , "!  finger saving alias for Vector2(1, 1)\n" );
        
        }
        { //::CEGUI::Vector2< CEGUI::UDim >::one_x
        
            typedef CEGUI::Vector2< CEGUI::UDim > exported_class_t;
            typedef ::CEGUI::Vector2< CEGUI::UDim > ( *one_x_function_type )(  );
            
            UVector2_exposer.def( 
                "one_x"
                , one_x_function_type( &::CEGUI::Vector2< CEGUI::UDim >::one_x )
                , "!  finger saving alias for Vector2(1, 0)\n" );
        
        }
        { //::CEGUI::Vector2< CEGUI::UDim >::one_y
        
            typedef CEGUI::Vector2< CEGUI::UDim > exported_class_t;
            typedef ::CEGUI::Vector2< CEGUI::UDim > ( *one_y_function_type )(  );
            
            UVector2_exposer.def( 
                "one_y"
                , one_y_function_type( &::CEGUI::Vector2< CEGUI::UDim >::one_y )
                , "!  finger saving alias for Vector2(0, 1)\n" );
        
        }
        UVector2_exposer.def( bp::self != bp::self );
        UVector2_exposer.def( bp::self * bp::self );
        UVector2_exposer.def( bp::self * bp::other< CEGUI::UDim >() );
        UVector2_exposer.def( bp::self *= bp::self );
        UVector2_exposer.def( bp::self *= bp::other< CEGUI::UDim >() );
        UVector2_exposer.def( bp::self + bp::self );
        UVector2_exposer.def( bp::self += bp::self );
        UVector2_exposer.def( bp::self - bp::self );
        UVector2_exposer.def( bp::self -= bp::self );
        UVector2_exposer.def( bp::self / bp::self );
        UVector2_exposer.def( bp::self / bp::other< CEGUI::UDim >() );
        UVector2_exposer.def( bp::self /= bp::self );
        UVector2_exposer.def( bp::self == bp::self );
        { //::CEGUI::Vector2< CEGUI::UDim >::zero
        
            typedef CEGUI::Vector2< CEGUI::UDim > exported_class_t;
            typedef ::CEGUI::Vector2< CEGUI::UDim > ( *zero_function_type )(  );
            
            UVector2_exposer.def( 
                "zero"
                , zero_function_type( &::CEGUI::Vector2< CEGUI::UDim >::zero )
                , "!  finger saving alias for Vector2(0, 0)\n" );
        
        }
        UVector2_exposer.def_readwrite( "d_x", &CEGUI::Vector2< CEGUI::UDim >::d_x );
        UVector2_exposer.def_readwrite( "d_y", &CEGUI::Vector2< CEGUI::UDim >::d_y );
        UVector2_exposer.staticmethod( "one" );
        UVector2_exposer.staticmethod( "one_x" );
        UVector2_exposer.staticmethod( "one_y" );
        UVector2_exposer.staticmethod( "zero" );
    }

}
