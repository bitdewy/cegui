// This file has been generated by Py++.

#include "boost/python.hpp"

#include "python_CEGUINullRenderer.h"

#include "NullRenderer.pypp.hpp"

namespace bp = boost::python;

BOOST_PYTHON_MODULE(PyCEGUINullRenderer){
    boost::python::scope().attr("CompileDate__") = __DATE__;

    boost::python::scope().attr("CompileTime__") = __TIME__;

    boost::python::scope().attr("__doc__") = "PyCEGUINullRenderer - version 0.8.9090";

    boost::python::scope().attr("Version__") = "0.8.9090";

    register_NullRenderer_class();
}

