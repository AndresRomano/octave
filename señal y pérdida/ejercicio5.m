clear
valor =input('indique el nivel de se�al: ', 's');
dBm=str2num(valor);
valor =input('indique la potencia emitida: ', 's');
mW=str2num(valor);
disp(['nivel de se�al: ',num2str(dBm),'dBm'])
disp(['Potencia emitida: ',num2str(mW),'mW'])
K=dBm/10;
Psal=10^K;
disp(['La potencia m�xima de la se�al en ese momento es:',num2str(Psal),'mW'])
disp(' ')
disp(['Verifiquemos: 10*log10(',num2str(Psal),'/',num2str(mW),')','=',num2str(dBm),'?'])
ver=10*log10(Psal/mW);
disp(['Verificaci�n:',num2str(ver),'dBm'])
