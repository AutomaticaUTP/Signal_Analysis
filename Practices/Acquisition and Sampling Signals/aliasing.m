Fs = 15;     % Frecuencia de muestreo
F = 5;       % Frecuencia de la señal real

duracion_adquisicion = 1;   % Duración de la adquisición
t = 0:1/Fs:duracion_adquisicion-1/Fs;

% Configuracón d la tarjeta MyDAQ
dq = daq('ni');
addinput(dq, 'myDAQ1', 0, 'Voltage');
dq.Rate = Fs;
datos = read(dq, seconds(duracion_adquisicion), "OutputFormat","Matrix");

% Se muestran los datos tomados (muestras)
subplot(2,1,1)
stem(t, datos, "red");
xlabel('Muestras');
ylabel('Voltage');
title('Si se cumple el teorema de Nyquist')

hold on

% Se genera una señal sintetica para envolver la señal principal
x = linspace(0,duracion_adquisicion, duracion_adquisicion*100000);
Phic = exp(-1j*2*pi*F*linspace(0,Fs-1,Fs)/Fs);
c = Phic*datos/Fs;
Phi = exp(1j*2*pi*[-F;F]*x); 
ck = [conj(c) c];
xr = ck*Phi;

% Se grafica la señal sintetica
subplot(2,1,1)
plot(x,xr,"blue")

%%
F2 = 20;    % Frecuencia de la señal real

% Se toman los datos
datos = read(dq, seconds(duracion_adquisicion), "OutputFormat","Matrix");

% Grafico de datos obtenidos (muestras)
subplot(2,1,2)
stem(t, datos, "red");
xlabel('Muestras');
ylabel('Voltage');
title('Si no se cumple el teorema de Nyquist')

hold on

% Señal sintetica para observar la naturaleza del aliasing
x = linspace(0,duracion_adquisicion, duracion_adquisicion*100000);
Phic = exp(-1j*2*pi*F*linspace(0,Fs-1,Fs)/Fs);
c = Phic*datos/Fs;
Phi = exp(1j*2*pi*[-F;F]*x); 
ck = [conj(c) c];
xr = ck*Phi;

% Señal sintetica para observar la señal real
Phic2 = exp(-1j*2*pi*F2*linspace(0,Fs-1,Fs)/Fs);
c2 = Phic2*datos/Fs;
Phi2 = exp(1j*2*pi*[-F2;F2]*x); 
ck2 = [conj(c2) c2];
xr2 = ck2*Phi2;

% Grafico de la señal sintetica del aliasing
subplot(2,1,2)
plot(x,xr,"blue")

hold on

% Grafico de la señal sintetica de la señal real
subplot(2,1,2)
plot(x,xr2,"green")