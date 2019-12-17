%    MATLAB scripts to read data from NanoVNA vector network analyzer.
%    It allows to establish connection with NanoVNA, send commands,
%    obtain S11 and S21 parameters, save it to S2P file and show
%    Logmag and Smith chart with no needs to use external applications.
%
%    https://github.com/qrp73/NanoVNA-MATLAB
%
%    Copyright (C) 2019 alex_m
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <https://www.gnu.org/licenses/>.

function nanovna()
    clear; close all; clc;
   % isoctave = (exist('OCTAVE_VERSION')~=0);
   % if isoctave
      pkg load instrument-control;
   % end;
    hCom = nanoOpen("COM3:");
% For ports above COM9 you have to use a different syntax
%   hCom = nanoOpen("\\\\.\\COM14")
    cleaner = onCleanup(@() nanoClose(hCom));

 #   nanoCommand(hCom, 'suspend');
 #   nanoCommand(hCom, 'resume');
  
    nanoCommand(hCom, 'sweep start 50000');
    nanoCommand(hCom, 'sweep stop 900000000');
    netwk = nanoGetData(hCom);
    rfwrite(netwk.Parameters, netwk.Frequencies,"text.s2p");
    
    % save network data
    %rfwrite(netwk.Parameters, netwk.Frequencies, 'data.s2p');
    %netwk = sparameters('data.s2p');

    % plot S11 LOGMAG
    fig = figure('Name','LOGMAG', 'NumberTitle','off');
    plot(netwk.Frequencies ./ 1000000,20*log10(abs(netwk.Parameters(1,1,1:101))))
    hold on
    plot(netwk.Frequencies ./ 1000000,20*log10(abs(netwk.Parameters(2,1,1:101))))
    ylabel('dBm');
    xlabel('MHz');
    ylim([-90 +10]);
    xlim([0  900]);
    grid on;
    grid minor;
   
end
