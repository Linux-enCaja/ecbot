/****************************************************************************
*
*   Copyright (c) 2006 Dave Hylands     <dhylands@gmail.com>
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU General Public License version 2 as
*   published by the Free Software Foundation.
*
*   Alternatively, this software may be distributed under the terms of BSD
*   license.
*
*   See README and COPYING for more details.
*
****************************************************************************/
/**
*
*   @file   Log.cpp
*
*   @brief  This file contains the implementation of the logging functions.
*
****************************************************************************/

// ---- Include Files -------------------------------------------------------

#include <stdio.h>

#include "Log.h"

// ---- Public Variables ----------------------------------------------------
// ---- Private Constants and Types -----------------------------------------

#if defined( AVR )

#undef  Log
#undef  LogError
#undef  vLog

#define Log         Log_P
#define LogError    LogError_P
#define vLog        vLog_P
#define LogBuf      LogBuf_P

#define char        prog_char

#else

#define PSTR(str)   str

int gVerbose = 0;
int gDebug = 0;
int gQuiet = 0;

#endif

#if CFG_LOG_TO_BUFFER

volatile    LOG_Buffer_t    LOG_gBuffer;

#endif

// ---- Private Variables ---------------------------------------------------

FILE   *gLogFs = NULL;

// ---- Private Function Prototypes -----------------------------------------

#if !defined( AVR )

void DefaultLogFunc( int logLevel, const char *fmt, va_list args )
{
    FILE    *fs;

    if ( gQuiet && ( logLevel == LOG_LEVEL_NORMAL ))
    {
        return;
    }

    if ( gLogFs == NULL )
    {
        fs = stderr;
    }
    else
    {
        fs = gLogFs;
    }

    if ( logLevel == LOG_LEVEL_ERROR )
    {
        fprintf( fs, "ERROR: " );
    }
    vfprintf( fs, fmt, args );
    fflush( fs );

} // DefaultLogFunc

static LogFunc_t    gLogFunc = DefaultLogFunc;

void SetLogFunc( LogFunc_t logFunc )
{
    gLogFunc = logFunc;

} // SetLogFunc

#endif

// ---- Functions -----------------------------------------------------------

/**
 * @addtogroup Log
 * @{
 */

//***************************************************************************
/**
*   Sets the logging stream
*/

void LogInit( FILE *logFs )
{
    gLogFs = logFs;

} // LogInit

//***************************************************************************
/**
*   Logs a string using printf like semantics
*/

void Log
(
    const char *fmt,    ///< printf style format specifier
    ...                 ///< variable list of arguments
)
{
    va_list args;

    va_start( args, fmt );
    vLog( fmt, args );
    va_end( args );
}

//***************************************************************************
/**
*   Logs a string using printf like semantics
*/

void vLog
(
    const char *fmt,    ///< printf style format specified
    va_list     args    ///< variable list of arguments
)
{
    // For now we call printf directly. A better way would be to install
    // a callback which does the real work

    if ( gLogFs != NULL )
    {
#if defined( AVR )
        vfprintf_P( gLogFs, fmt, args );
#else
        if ( gLogFunc != NULL )
        {
            gLogFunc( LOG_LEVEL_NORMAL, fmt, args );
        }
#endif
    }
}

#if !defined( AVR )

//***************************************************************************
/**
*   Logs an error.
*/

void vLogError
(
    const char *fmt,    ///< printf style format specified
    va_list     args    ///< variable list of arguments
)
{
    if ( gLogFs != NULL )
    {
        if ( gLogFunc != NULL )
        {
            gLogFunc( LOG_LEVEL_ERROR, fmt, args );
        }
    }
}

#endif

/***************************************************************************/
/**
*   Logs an error
*/

void LogError
(
    const char *fmt,    ///< printf style format specifier
    ...                 ///< variable list of arguments
)
{
    va_list args;

#if defined( AVR )
    Log_P( PSTR( "ERROR: " ));

    va_start( args, fmt );
    vLog( fmt, args );
    va_end( args );
#else
    va_start( args, fmt );
    vLogError( fmt, args );
    va_end( args );
#endif

} // LogError

/***************************************************************************/
/**
*   Logs an entry to the log buffer
*/

#if CFG_LOG_TO_BUFFER

void LogBuf( const char *fmt, uint8_t arg1, uint8_t arg2 LOG_EXTRA_PARAMS_DECL )
{
#if defined( AVR )
    uint8_t sreg = SREG;
    cli();
#endif

    if ( CBUF_IsFull( LOG_gBuffer ))
    {
        volatile LOG_Entry_t *entry = CBUF_GetLastEntryPtr( LOG_gBuffer );

        entry->fmt = PSTR( "*** Lost Messages ***\n" );
    }
    else
    {
        volatile LOG_Entry_t *entry = CBUF_GetPushEntryPtr( LOG_gBuffer );

        entry->fmt    = fmt;
        entry->param1 = arg1;
        entry->param2 = arg2;

#if CFG_LOG_EXTRA_PARAMS
        entry->param3 = arg3;
        entry->param4 = arg4;
#endif

        CBUF_AdvancePushIdx( LOG_gBuffer );
    }

#if defined( AVR )
    SREG = sreg;
#endif

} // LogBuf

#endif  // CFG_LOG_TO_BUFFER

/***************************************************************************/
/**
*   Dumps any unlogged entries from the log buffer
*/

#if CFG_LOG_TO_BUFFER

void LogBufDump( void )
{
    while ( !CBUF_IsEmpty( LOG_gBuffer ))
    {
        volatile LOG_Entry_t *entry = CBUF_GetPopEntryPtr( LOG_gBuffer );

#if CFG_LOG_EXTRA_PARAMS
        Log( entry->fmt, entry->param1, entry->param2, entry->param3, entry->param4 );
#else
        Log( entry->fmt, entry->param1, entry->param2 );
#endif

        CBUF_AdvancePopIdx( LOG_gBuffer );
    }

} // LogBufDump

#endif  // CFG_LOG_TO_BUFFER

/** @} */

