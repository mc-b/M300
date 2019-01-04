#!/bin/bash

# IoTKit Sources
sudo -u vagrant mkdir ws
cd ws
sudo -u vagrant git clone https://github.com/mc-b/IoTKit.git

sudo cp -r /vagrant/gpio . && sudo chown -R vagrant gpio
cd gpio/DigitalOut && pio run

