git submodule update --init src/coreclr
git submodule update --init src/corefx
git submodule update --init src/standard
git submodule update --init src/core-setup
git submodule update --init src/newtonsoft-json

build.cmd /p:RootRepo=core-setup
