/*
 * Main.m
 *
 * You may freely copy, distribute and reuse the code in this example.
 * Apple disclaims any warranty of any kind, expressed or implied, as to
 * its fitness for any particular use.
 *
 * Written by WebObjects Development Team
 *
 * This is the implementation file for the object that controls the Main
 * page.
 */

#import "Main.h"
#import "Hello.h"
#import "HelloPage.h"

@implementation Main

- (void)dealloc 
{
  DESTROY(nameString);
  [super dealloc];
}

- (GSWComponent *)sayHello 
{
  HelloPage *nextPage= (HelloPage*)[self pageWithName:@"HelloPage"];
  // Here we are using the EOKeyValueCodingProtocol to set 'nameString' in the Hello page
  // The alternative would be to implement the accessor method 'setNameString:'
  // [nextPage takeValue:nameString forKey:@"nameString"]; 
  [nextPage setNameString:nameString];
  return nextPage;
}

@end

@interface Session:GSWSession
{
}

@end

@interface Application:GSWApplication
{
}

@end

@implementation Session
@end

@implementation Application
@end