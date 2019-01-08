__Links to the parts contain Banggood's affilate metadata.__

# DOCS TODO:
* add photos of the printed parts
* add specs of the screws
* add wiring diagrams
* add ESPEasy config example

# Intro
I needed a PM2.5/PM10 sensor during this winter season. I wanted to monitor more than one room and did not want to buy multiple expensive devices.

This is an eclosure designed to fit 3 devices:
1. an acurate dust sensor
2. an Wemos ESP8266-based board with an OLED display
3. a digital humidity and temperature sensor

# Parts
* Wemos NodeMCU with an OLED display
The brain of this project. Provides processing, connectivity and instant data feed on the display.
[Buy Wemos with a display](https://www.banggood.com/Wemos-Nodemcu-Wifi-For-Arduino-And-NodeMCU-ESP8266-0_96-Inch-OLED-Board-p-1154759.html?cur_warehouse=CN&p=X314102609367201509L&custlinkid=113882)

* Nova SDS011 
The main sensor used to measure PM2.5 and PM10
[Buy SDS011](https://www.banggood.com/Nova-PM-Sensor-SDS011-High-Precision-Laser-PM2_5-Air-Quality-Detection-Sensor-Module-p-1144246.html?p=X314102609367201509L&custlinkid=113881)


* DHT22 (AM2302) 
Additional sensor to measure humidity and temperature
[Buy DHT22](https://www.banggood.com/AM2302-DHT22-Temperature-And-Humidity-Sensor-Module-For-Arduino-SCM-p-937403.html?p=X314102609367201509L&custlinkid=113883)

* Screws:
4x longer M3x12 screws to hold the main case plates together
4x shorter M3x4 screws to mount the Wemos board

# Assembly
1. Print the parts
2. Connect SDS011 to Wemos board
3. Connect DHT22 to Wemos board
4. Use 4x shorter screws to mount the Wemos board to the front plate
5. Use the longer boards to keep front and back plate together
6. Flash Wemos board with [ESPEasy](https://github.com/letscontrolit/ESPEasy)
7. Configure devices in ESPeasy

# Summary
When fully assembled, it should be compete with the retail products as:

* [Xiaomi PM2.5 detector](https://www.banggood.com/Original-Xiaomi-Mijia-PM2_5-Detector-Air-Quality-Tester-Monitor-OLED-Smart-Sensor-Air-Purifier-p-1330361.html?p=X314102609367201509L&custlinkid=113893)

* [SNDWAY SW-825 Digital Air Quality Monitor](https://www.banggood.com/SNDWAY-SW-825-Digital-Air-Quality-Monitor-Laser-PM2_5-Detector-Gas-Temperature-Humidity-Monitor-p-1244753.html?p=X314102609367201509L&custlinkid=113888)

# Please feel free to propose improvements
https://github.com/wojked/dust-sensor
