![Language](https://img.shields.io/badge/language-MATLAB-red.svg)
[![License](https://img.shields.io/badge/license-GNU%20GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl.html)

# NanoVNA-MATLAB
Octave scripts for NanoVNA vector network analyzer. Connect, save S2P file and display Logmag

## Overview

With these Octave scripts you can connect to your NanoVNA, execute commands, get S11 and S21 data, save it to S2P file and plot LOGMAG, . All can be done from Octave environment and it don't requires any external application.

## Instructions

1) Make sure NanoVNA COM port drivers are installed (see NanoVNA drivers section)
2) Connect your NanoVNA before Octave start
3) Start Octave and open nanovna.m script
4) Enter correct COM port name (e.g. "COM3")
5) Run the script

Please note, you're needs to connect NanoVNA before opening Octave.

## NanoVNA drivers
If you don't have STM32 Virtual COM port driver, you can download it from st.com (registration required): 
https://my.st.com/content/ccc/resource/technical/software/driver/70/30/29/18/96/3e/4f/3b/stsw-stm32102.zip/files/stsw-stm32102.zip/jcr:content/translations/en.stsw-stm32102.zip
