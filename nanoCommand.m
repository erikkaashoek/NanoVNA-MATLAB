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
function result = nanoCommand(hCom, command)
#    fprintf(hCom, command);
    srl_flush(hCom,1); #flush input
    srl_write(hCom,command);
    srl_write(hCom,char(13));
    srl_flush(hCom,0); # flush output
    isValid = false;
    lines = {};
    line = '';
    data = [];
    srl_timeout (hCom, 10);
    while true
#        data = fread(hCom, 1);
 #       set(hCom,"timeout",10);
        if numel(data) == 0
          data = srl_read(hCom, 100);
          if numel(data) == 0
            break;
          end;
         end;
 #       char(data)
 #       numel(data)
        if numel(data) == 0
            c = 13;
        else
            c = data(1);
            data(1) = [];
        end;
        if c == 10
            continue;
        elseif c ~= 13
            line = [line, char(c)];
            if strcmp(strtrim(line), 'ch>') == 1
                break;
            end;
            continue;
        end;
        if isValid
            lines{end+1} = line;
        else
            isValid = (strcmp(strtrim(line), command) == 1);
        end;
        line = '';
#        if numel(data) ~= 1
#            break;
#        end;
    end;
    result = lines;
end
