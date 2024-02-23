clc; clear
% Configura la tarjeta NI-myDAQ
dq = daq("ni");
Fs = 200e3;
dq.Rate = Fs;
addoutput(dq, "myDAQ1", "ao0", "Voltage")
% Se define la duración de generación 
tiempo_total = 15;
t = linspace(0, tiempo_total, tiempo_total*(Fs))';
% Señal de salida (Se puede modificar para efectos de la práctica)
frecuencia = 20;
amplitud = 5;
outputData = amplitud*sin(2*pi*frecuencia*t);

% Enviar los datos
write(dq, outputData)