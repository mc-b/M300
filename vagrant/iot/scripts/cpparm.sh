#!/bin/bash

# platformIO (install also gnu-gcc-4-arm)
sudo apt-get -y install python-setuptools cmake ninja-build python-dev libffi-dev libssl-dev && sudo easy_install pip
sudo -H pip install -U platformio

wget https://dl.bintray.com/platformio/ide-bundles/platformio-atom-linux-x86_64.deb
sudo dpkg -i platformio-atom-linux-x86_64.deb
rm platformio-atom-linux-x86_64.deb

# C Umgebung fuer Linux und C++ static analysis tool
sudo apt-get install -y clang-3.5 cppcheck

