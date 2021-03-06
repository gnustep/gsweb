/* GSWConfig.h - GSWeb: GSWeb Configuration Management
   Copyright (C) 1999, 2000, 2001, 2003 Free Software Foundation, Inc.
   
   Written by:	Manuel Guesdon <mguesdon@sbuilders.com>
   Date: 	July 1999
   
   This file is part of the GNUstep Web Library.
   
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
*/

// $Id$

#ifndef _GSWConfig_h__
#define _GSWConfig_h__

#include <proplist.h>
#include <time.h>
#include "GSWList.h"
#include "GSWDict.h"
#include "GSWLock.h"
#include "GSWString.h"
#include "GSWApp.h"

#define GSWNAMES_INDEX	0
#define WONAMES_INDEX	1


extern GSWLock  g_lockAppList;

extern const char *g_szGSWeb_AdaptorVersion;

extern const char *g_szGSWeb_Prefix;
extern const char *g_szGSWeb_Handler;
extern const char *g_szGSWeb_StatusResponseAppName;


extern const char *g_szGSWeb_AppExtention[2];

extern const char *g_szGSWeb_MimeType;
//extern const char *g_szGSWeb_Conf_DocRoot;
extern const char *g_szGSWeb_Conf_ConfigFilePath;

extern const char *g_szGSWeb_Conf_Alias;

extern const char *g_szGSWeb_InstanceCookie[2];

extern const char *g_szGSWeb_Server;
extern const char *g_szGSWeb_ServerAndAdaptorVersion;


extern const char *const g_szGNUstep;
extern const char *const g_szOKGSWeb[2];
extern const char *const g_szOKStatus[2];



typedef enum
{
  EGSWConfigResult__Error = -1,
  EGSWConfigResult__Ok = 0,
  EGSWConfigResult__NotChanged = 1
} EGSWConfigResult;

typedef enum
{
  EGSWConfigResult__Clear = 0,
  EGSWConfigResult__Add = 1
} EGSWConfigCallType;

typedef struct _GSWConfig
{
  char *pszConfigFilePath;
  char *pszGSWExtensionsFrameworkWebServerResources;
  BOOL fCanDumpStatus;
  BOOL fAddTimeHeaders;
  BOOL fDebug;
  char *pszAdaptorTemplatesPath;
} GSWConfig;


BOOL
GSWConfig_LoadConfiguration(void *p_pLogServerData);

EGSWConfigResult GSWConfig_ReadIFND(CONST char *p_pszConfigPath,
				    time_t     *p_pLastReadTime,
				    proplist_t *p_ppPropList,//Please, PLRelease it after used !
				    void       *p_pLogServerData);

proplist_t GSWConfig_GetApplicationsFromConfig(proplist_t p_propListConfig,
					       void      *p_pLogServerData);
proplist_t GSWConfig_ApplicationKeyFromApplicationsKey(proplist_t p_propListApplicationsKeys,
						       int   p_iIndex,
						       void *p_pLogServerData);
proplist_t GSWConfig_InstancesFromApplication(proplist_t p_propListApplication,
					      void      *p_pLogServerData);
proplist_t GSWConfig_ApplicationFromApplications(proplist_t p_propListApplications,
						 proplist_t p_propListApplicationKey,
						 void *p_pLogServerData);
proplist_t GSWConfig_ApplicationsKeysFromApplications(proplist_t p_propListApplications,
						      void *p_pLogServerData);
proplist_t GSWConfig_ApplicationsKeysFromConfig(proplist_t p_propListConfig,
						void      *p_pLogServerData);

GSWConfig *GSWConfig_GetConfig(void);
BOOL GSWConfig_CanDumpStatus(void);
BOOL GSWConfig_AddTimeHeaders(void);
BOOL GSWConfig_IsDebug(void);
BOOL GSWConfig_IsReaden(void);
CONST char *GSWConfig_GetConfigFilePath(void);
void GSWConfig_SetConfigFilePath(CONST char *p_pszConfigFilePath);
GSWString *GSWConfig_DumpGSWApps(const char *p_pszReqApp,
				 const char *p_pszPrefix,
				 BOOL        p_fForceDump,
				 BOOL        p_fHTML,
				 void        *p_pLogServerData);
void GSWConfig_Init(GSWDict *p_pDict,
		    void    *p_pLogServerData);
GSWApp *GSWConfig_GetApp(CONST char *p_pszAppName);
CONST char *GSWConfig_AdaptorBuilt(void);
CONST char *GSWConfig_ServerStringInfo(void);
CONST char *g_szGSWeb_AdaptorStringInfo(void);
CONST char *GSWConfig_ServerURL(void);
CONST char *g_szGSWeb_AdaptorURL(void);

#endif // _GSWConfig_h__

