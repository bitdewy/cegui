// This file has been generated by Py++.

#include "boost/python.hpp"

#include "python_CEGUIOpenGLRenderer.h"

#include "output/CEGUIOpenGLRenderer/OpenGLRenderer.pypp.hpp"

namespace bp = boost::python;

BOOST_PYTHON_MODULE(CEGUIOpenGLRenderer){
    boost::python::scope().attr("CompileDate__") = __DATE__;

    boost::python::scope().attr("CompileTime__") = __TIME__;

    boost::python::scope().attr("PythonVersion__") = "2.6.5 (release26-maint, Aug 24 2010, 20:14:50) \
    [GCC 4.4.3]";

    boost::python::scope().attr("__doc__") = "CEGUIOpenGLRenderer - version 0.7.4";

    boost::python::scope().attr("Version__") = "0.7.4";

    register_OpenGLRenderer_class();
}

