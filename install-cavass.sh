#!/usr/bin/env bash

set -ex

wget http://www.mipg.upenn.edu/cavass/cavass-src-1_0_25.tgz
wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.0.5/wxWidgets-3.0.5.tar.bz2
wget https://github.com/InsightSoftwareConsortium/ITK/releases/download/v5.1.2/InsightToolkit-5.1.2.tar.gz

tar xjf wxWidgets-3.0.5.tar.bz2
cd wxWidgets-3.0.5
mkdir buildgtk
cd buildgtk
../configure --with-gtk
make -j8
make install
/sbin/ldconfig
cd ../..

tar xzf InsightToolkit-5.1.2.tar.gz
mkdir itk
cd itk
cmake -DBUILD_TESTING=ON ../InsightToolkit-5.1.2
make
make install
/sbin/ldconfig
cd ..

tar xzf cavass-src-1_0_25.tgz
mkdir cavass-build
cd cavass-build
cmake -DCMAKE_BUILD_TYPE=Release ../cavass
make -j8
cd ..

mv cavass-build /opt
echo "VIEWNIX_ENV=/opt/cavass-build" >> /etc/profile.local
echo "PATH=$PATH:/opt/cavass-build" >> /etc/profile.local
echo "export PATH VIEWNIX_ENV" >> /etc/profile.local

