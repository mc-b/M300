#!/bin/bash

# FreeCAD
sudo add-apt-repository ppa:freecad-maintainers/freecad-stable
sudo apt-get update
sudo apt-get install -y freecad

# Gerbv: Gerber File Viewer
sudo apt-get install -y gerbv

# CAMotics: G-Code Viewer
cd /tmp
sudo wget http://camotics.org/releases/public/release/camotics/ubuntu-precise-64bit/v1.0/camotics_1.0.6_amd64.deb
sudo dpkg -i camotics_1.0.6_amd64.deb
sudo rm camotics_1.0.6_amd64.deb

# CADSoft EAGLE
cd /tmp
sudo wget http://web.cadsoft.de/ftp/eagle/program/7.5/eagle-lin64-7.5.0.run
sudo bash eagle-lin64-7.5.0.run /opt
sudo chown -R vagrant:vagrant /opt/eagle*

# DXF2GCode
cd /opt
sudo git clone http://git.code.sf.net/p/dxf2gcode/sourcecode dxf2gcode
sudo chown -R vagrant:vagrant dxf2gcode/
cd dxf2gcode/source
mkdir clean
for var in $( ls dxf2gcode*.py );
do  cat $var | tr -d "\r" > clean/$var;
done
mv clean/* ./
rmdir clean/
chmod +x dxf2gcode.py
