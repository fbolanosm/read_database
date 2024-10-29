clear; close all; clc; 

% Este archivo debe estar ubicado en el directorio raiz, donde
% estan ubicadas las carpetas de los diferentes individuos


% Ubicar el archivo (sujeto) sobre el que se va a trabajar 
% y extraer la matriz con la informacion:
prompt = 'Write the subject index (1-15):         ';
name = 'File (subject) selection';
numlines = 1;
default = {'1'};
answer=inputdlg(prompt,name,numlines,default);
if isempty(answer)
    clear;
    return;
end
index = eval(answer{1});
filepath = sprintf('./S%02d/',index);
filename = sprintf('S%02d_EEG.mat',index);
data=open(strcat(filepath,filename));
matrix_EEG = data.EEG;
clearvars prompt name numlines default answer filename filepath data; 

imaginada = matrix_EEG;
% Se descartan aquellas tomas que no sean de la categoria: Imaginada
% index = find(matrix_EEG(:,24577) == 1);
% imaginada = matrix_EEG(index,:);
% Con el indice se pueden descartar las tomas que no sean vocales:
% index = find(imaginada(:,24578) < 6);
% imaginada = imaginada(index,:);
clearvars matrix_EEG index;

% Se reduce la tasa de muestreo de 1024 a 128 Hz
% La matriz queda con 3072 columnas correspondientes 
% a datos y 3 mas de etiquetas:
labels = imaginada(:,24577:24579);
imaginada_r = resample(imaginada(:,1:24576)',1,8)';
imaginada_r(:,3073:3075) = labels;
clearvars labels imaginada;

