#!python
import subprocess
import os

LIB_NAME 		= "lib/RooBarb"

ROOTCFLAGS    	= subprocess.check_output( ['root-config',  '--cflags'] ).rstrip().decode("utf-8").split( " " )
ROOTLDFLAGS    	= subprocess.check_output( ["root-config",  "--ldflags"] ).rstrip().decode("utf-8").split( " " )
ROOTLIBS      	= subprocess.check_output( ["root-config",  "--libs"] ).decode( "utf-8" );
ROOTGLIBS     	= subprocess.check_output( ["root-config",  "--glibs"] ).decode( "utf-8" );
ROOTLIBPATH 	= subprocess.check_output( ["root-config", "--libdir" ] ).decode( "utf-8" );
ROOT_SYS 		= os.environ[ "ROOTSYS" ]
JDB_LIB			= os.environ[ "JDB_LIB" ]


cppDefines 		= {}
cppFlags 		= ['-Wall' ]#, '-Werror']
cxxFlags 		= ['-std=c++11', '-fPIC', '-O3' ]
paths 			= [ '.', '/usr/local/include/XmlConfig' ]


vars = Variables()
vars.Add('LL', 'LogLevel : ALL = 60, DEBUG = 50, TRACE = 40, INFO = 30, WARN = 20, ERROR = 10, NONE = 0', 10)
common_env = Environment( variables = vars )
common_env['ENV']['TERM'] = os.environ['TERM']
Help(vars.GenerateHelpText(common_env))

common_env.Append(CPPDEFINES 	= cppDefines)
cxxFlags.extend( ROOTCFLAGS )
common_env.Append(CPPFLAGS 		= cppFlags)
common_env.Append(CXXFLAGS 		= cxxFlags)
common_env.Append(LINKFLAGS 	= cxxFlags ) 
common_env.Append(LINKFLAGS		= ROOTLDFLAGS )
common_env.Append(CPPPATH		= paths)


common_env.Append(CXXFLAGS 		= "-DJDB_LOG_LEVEL=${LL}" )
# common_env.Append(CXXFLAGS 		= "-DROOT6=${ROOT6}" )


target = common_env.StaticLibrary( target = 'RooPlotLib', source = [Glob( "*.cpp" )] )