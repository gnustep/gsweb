/** GSWComponentContent.m - <title>GSWeb: Class GSWComponentContent</title>

   Copyright (C) 1999-2004 Free Software Foundation, Inc.
   
   Written by:	Manuel Guesdon <mguesdon@orange-concept.com>
   Date: 		Jan 1999
   
   $Revision$
   $Date$
   
   <abstract></abstract>

   This file is part of the GNUstep Web Library.
   
   <license>
   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.
   
   You should have received a copy of the GNU Library General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
   </license>
**/

#include "config.h"

#include "GSWeb.h"

static Class GSWHTMLBareStringClass = Nil;

//====================================================================
@implementation GSWComponentContent

+ (void) initialize
{
  if (self == [GSWComponentContent class])
  {
    GSWHTMLBareStringClass = [GSWHTMLBareString class];
  }
}

//--------------------------------------------------------------------
-(void)appendToResponse:(GSWResponse*)response
              inContext:(GSWContext*)aContext
{
  //OK
  GSWComponent* component=nil;
  GSWComponent* parent=nil;
  GSWElement* childTemplate=nil;

  GSWDeclareDebugElementIDsCount(aContext);

  GSWStartElement(aContext);
  GSWSaveAppendToResponseElementID(aContext);//Debug Only

  component=GSWContext_component(aContext);

  childTemplate=[component _childTemplate];
  parent=[component parent];
  [aContext _setCurrentComponent:parent];
  [childTemplate appendToResponse:response
                 inContext:aContext];
  [aContext _setCurrentComponent:component];

  GSWStopElement(aContext);
  GSWAssertDebugElementIDsCount(aContext);

};

//--------------------------------------------------------------------
-(GSWElement*)invokeActionForRequest:(GSWRequest*)request
                           inContext:(GSWContext*)aContext
{
  id <GSWActionResults, NSObject> element=nil;
  GSWComponent* component=nil;
  GSWComponent* parent=nil;
  GSWElement* childTemplate=nil;
  GSWDeclareDebugElementIDsCount(aContext);
  
  GSWStartElement(aContext);
  
  component=GSWContext_component(aContext);
  childTemplate=[component _childTemplate];
  if ([childTemplate class] != GSWHTMLBareStringClass) {
    parent=[component parent];
    [aContext _setCurrentComponent:parent];
    element = (id <GSWActionResults, NSObject>)[childTemplate invokeActionForRequest:request
                                        inContext:aContext];
    NSAssert3(!element || [element isKindOfClass:[GSWElement class]],
              @"childTemplate=%@ Element is a %@ not a GSWElement: %@",
              childTemplate,
              [element class],
              element);
    [aContext _setCurrentComponent:component];
  }
  GSWStopElement(aContext);
  GSWAssertDebugElementIDsCount(aContext);
  
  return element;
}

//--------------------------------------------------------------------
-(void)takeValuesFromRequest:(GSWRequest*)request
                   inContext:(GSWContext*)aContext
{
  //OK
  GSWComponent* component=nil;
  GSWComponent* parent=nil;
  GSWElement* childTemplate=nil;
  GSWDeclareDebugElementIDsCount(aContext);

  GSWStartElement(aContext);
  GSWAssertCorrectElementID(aContext);// Debug Only

  component=GSWContext_component(aContext);
  childTemplate=[component _childTemplate];
  parent=[component parent];
  [aContext _setCurrentComponent:parent];
  [childTemplate takeValuesFromRequest:request
                 inContext:aContext];
  [aContext _setCurrentComponent:component];

  GSWStopElement(aContext);
  GSWAssertDebugElementIDsCount(aContext);

};

@end


