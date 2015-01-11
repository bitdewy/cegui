/***********************************************************************
    created:    20/5/2008
    author:     Cegui Team
*************************************************************************/
/***************************************************************************
 *   Copyright (C) 2004 - 2008 Paul D Turner & The CEGUI Development Team
 *
 *   Permission is hereby granted, free of charge, to any person obtaining
 *   a copy of this software and associated documentation files (the
 *   "Software"), to deal in the Software without restriction, including
 *   without limitation the rights to use, copy, modify, merge, publish,
 *   distribute, sublicense, and/or sell copies of the Software, and to
 *   permit persons to whom the Software is furnished to do so, subject to
 *   the following conditions:
 *
 *   The above copyright notice and this permission notice shall be
 *   included in all copies or substantial portions of the Software.
 *
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 *   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 *   IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 *   OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 *   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 *   OTHER DEALINGS IN THE SOFTWARE.
 ***************************************************************************/
#include "Sample_DragDropDemo.h"
#include "CEGUI/CEGUI.h"

//----------------------------------------------------------------------------//
bool DragDropDemo::initialise(CEGUI::GUIContext* guiContext)
{
    using namespace CEGUI;
    // execute the DragDropDemo script which controls the rest of this demo
    System::getSingleton().executeScriptFile("DragDropDemo.lua");

    System::getSingleton().getScriptingModule()->executeScriptedEventHandler("DragDropDemo.initialize", CEGUI::GUIContextEventArgs(guiContext));
    // success!
    return true;
}

//----------------------------------------------------------------------------//
void DragDropDemo::deinitialise()
{
    // nothing doing in here!
}

/*************************************************************************
    Define the module function that returns an instance of the sample
*************************************************************************/
extern "C" SAMPLE_EXPORT Sample& getSampleInstance()
{
    static DragDropDemo sample;
    return sample;
}
