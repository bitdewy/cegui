/***********************************************************************
    filename:   CEGUIIrrlichtTextureTarget.cpp
    created:    Tue Mar 3 2009
    author:     Paul D Turner (parts based on original code by Thomas Suter)
*************************************************************************/
/***************************************************************************
 *   Copyright (C) 2004 - 2009 Paul D Turner & The CEGUI Development Team
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
#include "CEGUIIrrlichtTextureTarget.h"
#include "CEGUIIrrlichtTexture.h"

// Start of CEGUI namespace section
namespace CEGUI
{
//----------------------------------------------------------------------------//
const float IrrlichtTextureTarget::DEFAULT_SIZE = 128.0f;

//----------------------------------------------------------------------------//
IrrlichtTextureTarget::IrrlichtTextureTarget(IrrlichtRenderer& owner,
                                             irr::video::IVideoDriver& driver) :
    IrrlichtRenderTarget(owner, driver),
    d_texture(0),
    d_CEGUITexture(static_cast<IrrlichtTexture*>(&d_owner.createTexture()))
{
    // setup area and cause the initial texture to be generated.
    declareRenderSize(Size(DEFAULT_SIZE, DEFAULT_SIZE));
}

//----------------------------------------------------------------------------//
IrrlichtTextureTarget::~IrrlichtTextureTarget()
{
    cleanupTargetTexture();
    d_owner.destroyTexture(*d_CEGUITexture);
}

//----------------------------------------------------------------------------//
void IrrlichtTextureTarget::activate()
{
    d_driver.setRenderTarget(d_texture, false, false);
    IrrlichtRenderTarget::activate();
}

//----------------------------------------------------------------------------//
void IrrlichtTextureTarget::deactivate()
{
    IrrlichtRenderTarget::deactivate();
    d_driver.setRenderTarget(0);
}

//----------------------------------------------------------------------------//
bool IrrlichtTextureTarget::isImageryCache() const
{
    return true;
}

//----------------------------------------------------------------------------//
void IrrlichtTextureTarget::clear()
{
    d_driver.setRenderTarget(d_texture, true, false,
                             irr::video::SColor(0, 0, 0, 0));
    d_driver.setRenderTarget(0);
}

//----------------------------------------------------------------------------//
Texture& IrrlichtTextureTarget::getTexture() const
{
    return *d_CEGUITexture;
}

//----------------------------------------------------------------------------//
void IrrlichtTextureTarget::declareRenderSize(const Size& sz)
{
    // exit if current size is enough
    if ((d_area.getWidth() >= sz.d_width) && (d_area.getHeight() >=sz.d_height))
        return;

    cleanupTargetTexture();

    d_texture = d_driver.addRenderTargetTexture(
        irr::core::dimension2d<irr::s32>(sz.d_width, sz.d_height),
        IrrlichtTexture::getUniqueName().c_str());

    d_CEGUITexture->setIrrlichtTexture(d_texture);
    d_CEGUITexture->setOriginalDataSize(d_area.getSize());

    setArea(Rect(d_area.getPosition(), sz));
    clear();
}

//----------------------------------------------------------------------------//
bool IrrlichtTextureTarget::isRenderingInverted() const
{
    return false;
}

//----------------------------------------------------------------------------//
void IrrlichtTextureTarget::cleanupTargetTexture()
{
    if (d_texture)
    {
        d_CEGUITexture->setIrrlichtTexture(0);
        d_driver.removeTexture(d_texture);
        d_texture = 0;
    }
}

//----------------------------------------------------------------------------//

} // End of  CEGUI namespace section
