#!python
import subprocess
import os

# If we are being called from a higher SConstruct, then import the PREFIX, if not then get from arguments
try :
    Import( 'PREFIX' )
except  :
    PREFIX = Dir(ARGUMENTS.get( "prefix", "/usr/local" )).abspath
print( "PREFIX: %s" % (PREFIX) )

LIB_NAME 		= "lib/RooBarb"

ROOTCFLAGS    	= subprocess.check_output( ['root-config',  '--cflags'] ).rstrip().decode("utf-8").split( " " )
ROOTLDFLAGS    	= subprocess.check_output( ["root-config",  "--ldflags"] ).rstrip().decode("utf-8").split( " " )
ROOTLIBS      	= subprocess.check_output( ["root-config",  "--libs"] ).decode( "utf-8" )
ROOTGLIBS     	= subprocess.check_output( ["root-config",  "--glibs"] ).decode( "utf-8" )
ROOTLIBPATH 	= subprocess.check_output( ["root-config", "--libdir" ] ).decode( "utf-8" )
ROOT_SYS 		= os.environ[ "ROOTSYS" ]


cppDefines 		= {}
cppFlags 		= ['-Wall' ]#, '-Werror']
cxxFlags 		= ['-std=c++11', '-fPIC', '-O3' ]
paths 			= [ '.', PREFIX + '/XmlConfig' ]


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
common_env.Append(LIBPATH 		= [ PREFIX + "/lib" ] )


common_env.Append(CXXFLAGS 		= "-DJDB_LOG_LEVEL=${LL}" )
ROOT6 = ARGUMENTS.get( "ROOT6", 1 )
if int(ROOT6) > 0 :
    common_env.Append(CXXFLAGS 		= "-DROOT6=1" )


target = common_env.StaticLibrary( target = 'RooPlotLib', source = [Glob( "*.cpp" )] )

# Install the Header files and lib file:
install = [
    common_env.Install( PREFIX + '/include/RooPlotLib/', [Glob("*.h")] ),
    common_env.Install( PREFIX + '/lib', [Glob("*.a")] ) 
]


# set as the default target
Default( target, install )