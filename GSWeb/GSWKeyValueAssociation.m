/** GSWKeyValueAssociation.m - <title>GSWeb: Class GSWKeyValueAssociation</title>

   Copyright (C) 1999-2004 Free Software Foundation, Inc.
   
   Written by:	Manuel Guesdon <mguesdon@orange-concept.com>
   Date: 	Jan 1999
   
   $Revision$
   $Date$

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
#include <GNUstepBase/NSObject+GNUstepBase.h>

//====================================================================
@implementation GSWKeyValueAssociation

//--------------------------------------------------------------------
-(id)initWithKeyPath:(NSString*)aKeyPath
{
  if ((self=[super init])) {
    ASSIGNCOPY(_keyPath,aKeyPath);
    _isValueSettable = ((_keyPath != nil) && ([_keyPath length] > 0));
    
  }
  return self;
}

//--------------------------------------------------------------------
-(void)dealloc
{
  DESTROY(_keyPath);
  [super dealloc];
};

//--------------------------------------------------------------------
-(id)copyWithZone:(NSZone*)zone
{
  GSWKeyValueAssociation* clone = [super copyWithZone:zone];
  ASSIGN(clone->_keyPath,_keyPath);
  return clone;
};

//--------------------------------------------------------------------
// dw
-(id)valueInComponent:(GSWComponent*)component
{
  id retValue=nil;

// thats what WO does:
//  retValue = [component valueForKeyPath: _keyPath];

// but we need:  
  retValue=[GSWAssociation valueInComponent: component
                                 forKeyPath:_keyPath];
  if (_debugEnabled)
    {
      [self _logPullValue:retValue
	    inComponent:component];
    }
  return retValue;
};

//--------------------------------------------------------------------
-(void)setValue:(id)aValue
    inComponent:(GSWComponent*)component
{
  NSException *ex = nil;
  
  if ([_keyPath length]==0)
    {
      [NSException raise:NSInvalidArgumentException 
		   format:@"No key path when setting value %@ in object of class %@ for association %@",
		   aValue,NSStringFromClass([component class]),self];
    }
  
  NS_DURING
    {
      [component validateTakeValue:aValue
		 forKeyPath:_keyPath];
    }
  NS_HANDLER
    {
      ex = localException;    
    } 
  NS_ENDHANDLER;
  
  if (_debugEnabled)
    {
      [self _logPushValue:aValue
	    inComponent:component];
    }
  if (ex != nil)
    { 
      [component validationFailedWithException:ex
		 value:aValue
		 keyPath:_keyPath];
    }
}

- (void) _setValueNoValidation:(id) aValue
		   inComponent:(GSWComponent*) component
{    
  if (_isValueSettable)
    {
      [component setValue:aValue
		 forKeyPath:_keyPath];
    }
}    

//--------------------------------------------------------------------
-(BOOL)isValueConstant
{
  return NO;
};

//--------------------------------------------------------------------
-(BOOL)isValueSettable
{
  return _isValueSettable;
}

//--------------------------------------------------------------------
-(NSString*)description
{
  return [NSString stringWithFormat:@"<%s %p - keyPath=%@>",
		   object_getClassName(self),
		   (void*)self,
		   _keyPath];
};

//--------------------------------------------------------------------
-(NSString*)keyPath
{
  return _keyPath;
};

@end




