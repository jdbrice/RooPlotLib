DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Headers
mkdir -p /usr/local/lib
ln -sf ${DIR}/libRooPlotLib.a /usr/local/lib/libRooPlotLib.a

mkdir -p /usr/local/include/RooPlotLib
cp *.h /usr/local/include/RooPlotLib/