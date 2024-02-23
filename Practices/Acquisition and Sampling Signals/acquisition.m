% Reemplaza 'frecuencia_deseada' con la frecuencia de muestreo deseada en Hz
frecuencia_deseada = 2000; % Ejemplo: 1000 Hz

% Configura la tarjeta NI-myDAQ
dq = daq('ni');
addinput(dq, 'myDAQ1', 0, 'Voltage');
dq.Rate = frecuencia_deseada; % Configura la frecuencia de muestreo

% Definir la duración de la adquisición en segundos (puedes ajustar este valor según tus necesidades)
duracion_adquisicion = 1;

% Adquirir datos
datos = read(dq, seconds(duracion_adquisicion), "OutputFormat", "Matrix");


% Mostrar los datos adquiridos
plot(linspace(0, duracion_adquisicion, numel(datos)), datos, "blue");
xlabel('Tiempo (s)');
ylabel('Voltaje (V)');
title('Datos adquiridos');





