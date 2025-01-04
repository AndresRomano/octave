clear all;
close all;
clc;

n = 10;   % Número de clientes
k = 3;    % Número de cajas
mu1 = 3;  % Media de la distribución Poisson para llegadas
mu2 = 15;  % Media de la distribución normal para productos
s2 = 3;   % Desviación estándar de la distribución normal para productos
mu3 = 0.4; % Probabilidad de pagar en efectivo
t1 = 120;  % Tiempo en segundos para pagar en efectivo
t2 = 70;   % Tiempo en segundos para pagar con otro medio

% Convertir tiempos a minutos
t1 = t1 / 60;
t2 = t2 / 60;

% -----------------------------------
A = randp(mu1, n, 1) ; % Tiempo entre llegadas de clientes en minutos
A(:, 2) = max(normrnd(mu2, s2, n, 1), 0); % Cantidad de productos que tiene cada cliente

% Pago en efectivo o con otro medio
pago_efectivo = rand(n, 1) <= mu3; % Vector booleano: cliente paga en efectivo
A(:, 3) = t2; % Tiempo de pago por defecto para clientes que no pagan en efectivo
A(pago_efectivo, 3) = t1; % Tiempo de pago en efectivo para clientes que pagan en efectivo

% Parámetros de la simulación
n = size(A, 1);   % Número de clientes (tomado de la matriz A)
tiempo_llegada = A(:, 1);  % Tiempo entre llegadas de clientes en minutos
productos = A(:, 2);       % Cantidad de productos que tiene cada cliente
tiempo_pago = A(:, 3);     % Tiempo de pago de cada cliente en minutos

% Simulación con fila única y asignación a caja desocupada
tiempo_uso_cajas_fila_unica = zeros(k, 1);
tiempo_espera_fila_unica = zeros(n, 1);
tiempo_libre_cajas_fila_unica = zeros(k, 1); % Inicializar tiempo libre
matrix_cajas_elegidas_fila_unica = zeros(n, 1); %array para saber que caja eliguio
ocupacion_actual_caja_fila_unica = zeros(k, 1); %estado actual de que tan ocupada esta la caja
matix_ocupacion_cajas_fila_unica=zeros(n, k); %Una matrix de lo anterior para ver que decicion tomo en cada momento
pre_ocupacion_caja_fila_unica  = zeros(k, 1); %un estado prebio para calcular el tiempo libre de las cajas
for i = 1:n
    % Cliente i llega
    pre_ocupacion_caja_fila_unica(:)=ocupacion_actual_caja_fila_unica(:); %guardo la ocupacion antes de llegar el cliente por que nos sera util para calcular tiempo libre
   #Aqui se mira el estado actual de la caja, basicamente se resta al tiempo que le queda de uso por los clientes a cada caja el tiempo de llegada del cliente
   # asi que si tenemos que cuando entro el cliente anterior las cajas estaban ocupadas (2, 4, 5) minutos y este cliente tardo 3 minutos ahora estaran  (0, 1, 2)
    for numerocaja = 1:k
    ocupacion_actual_caja_fila_unica (numerocaja) = max(0, ocupacion_actual_caja_fila_unica (numerocaja) - tiempo_llegada(i));
    matix_ocupacion_cajas_fila_unica(i, numerocaja)=ocupacion_actual_caja_fila_unica (numerocaja);
  end



    % Cliente i elige la caja con menor tiempo de uso
    [~, caja_elegida] = min(ocupacion_actual_caja_fila_unica ); #Se fija cual es la caja menos ocupada cuando llego

    tiempo_espera_fila_unica(i) = ocupacion_actual_caja_fila_unica (caja_elegida); % Cliente i espera en la fila
    ocupacion_actual_caja_fila_unica (caja_elegida) = ocupacion_actual_caja_fila_unica (caja_elegida)+productos(i) + tiempo_pago(i); #Se suma a la ocupacion de caja cuanto va a tardar este cleinte
    matrix_cajas_elegidas_fila_unica(i, 1)=caja_elegida; #se guarda que caja se eliguio por si apetece verlo despues



    % Se calcula el tiempo libre de las cajas
     for numerocaja = 1:k
        if(numerocaja!=caja_elegida)
             tiempo_libre_cajas_fila_unica(numerocaja) = tiempo_libre_cajas_fila_unica(numerocaja) + max(0, tiempo_llegada(i) - pre_ocupacion_caja_fila_unica(numerocaja));
        endif
        if(numerocaja=caja_elegida)
             tiempo_libre_cajas_fila_unica(numerocaja) = tiempo_libre_cajas_fila_unica(numerocaja) + max(0, tiempo_llegada(i) - pre_ocupacion_caja_fila_unica(numerocaja) - productos(i) - tiempo_pago(i));
        endif
   endfor
   #se calcula el tiempo de uso de la caja
    tiempo_uso_cajas_fila_unica(caja_elegida) = tiempo_uso_cajas_fila_unica(caja_elegida) + productos(i) + tiempo_pago(i);
end



% Visualización de resultados para fila única
figure;
subplot(2, 1, 1);
bar(tiempo_uso_cajas_fila_unica);
title('Tiempo de uso de cada caja (Fila única)');
xlabel('Caja');
ylabel('Tiempo de uso');

subplot(2, 1, 2);
bar(tiempo_espera_fila_unica);
title('Tiempo de espera de cada cliente en la fila (Fila única)');
xlabel('Cliente');
ylabel('Tiempo de espera');

fprintf('Estadísticas (Fila única):\n');
fprintf('Tiempo de uso - Media: %.2f, Desviación estándar: %.2f\n', mean(tiempo_uso_cajas_fila_unica), std(tiempo_uso_cajas_fila_unica));
fprintf('Tiempo de espera - Media: %.2f, Desviación estándar: %.2f\n', mean(tiempo_espera_fila_unica), std(tiempo_espera_fila_unica));
fprintf('Tiempo libre de cajas - Media: %.2f\n', mean(tiempo_libre_cajas_fila_unica));

% Simulación con cada caja teniendo su propia fila
tiempo_uso_cajas_cada_una_con_fila = zeros(k, 1);
tiempo_espera_cada_una_con_fila = zeros(n, 1);
tiempo_libre_cajas_cada_una_con_fila = zeros(k, 1); % Inicializar tiempo libre
matrix_cajas_elegidas_cada_una_con_fila = zeros(n, 1);  % Un array para saber que caja eligio
ocupacion_actual_cajas_cada_una_con_fila = zeros(k, 1);  % estado de como estan en todo momento de ocupadas las cajas
matix_ocupacion_cajas_cada_una_con_fila=zeros(n, k); % una lista de lo anterior para ver como ta la cosa
numero_clientes_en_caja=zeros(k, 1); % Controlador para ver a tiempo real cuantos clientes hay en cada caja
matrix_numero_clientes_en_caja=zeros(n, k); %Matrix de lo anterior para saber que diccion toma en cada momento
cola_de_caja=zeros(n, k); # Esto es una fumada que funciona lo explico mas abajo
pre_ocupacion_cajas_cada_una_con_fila=zeros(k, 1); %un estado prebio para calcular el tiempo libre de las cajas
for i = 1:n
  %guardo la ocupacion antes de llegar el cliente por que nos sera util para calcular tiempo libre
  pre_ocupacion_cajas_cada_una_con_fila(:)=ocupacion_actual_cajas_cada_una_con_fila(:);
  #Aqui se mira el estado actual de la caja, basicamente se resta al tiempo que le queda de uso por los clientes a cada caja el tiempo de llegada del cliente
   # asi que si tenemos que cuando entro el cliente anterior las cajas estaban ocupadas (2, 4, 5) minutos y este cliente tardo 3 minutos ahora estaran  (0, 1, 2)
   for numerocaja = 1:k
    ocupacion_actual_cajas_cada_una_con_fila (numerocaja) = max(0, ocupacion_actual_cajas_cada_una_con_fila (numerocaja) - tiempo_llegada(i));
    matix_ocupacion_cajas_cada_una_con_fila(i, numerocaja)=ocupacion_actual_cajas_cada_una_con_fila (numerocaja);
  end



  #Muy bien esto es raro asi que poco a poco, primero lo que hago es restar el tiempo de llegada a cola_de_caja siempre va a aparecer los primeros valores como nogativos
  # pero eso es por la comparacion que hago
  for numerocaja = 1:k
    for numerorep = 1:i
      cola_de_caja(numerorep, numerocaja)=cola_de_caja(numerorep, numerocaja)-tiempo_llegada(i);
    endfor
  endfor
 for numerocaja = 1:k
   numero_clientes_en_caja(numerocaja)=0;
   for cola_i = 1:n
        if(cola_de_caja(cola_i, numerocaja)>0) #La clabe esta aqui, si el numero de cola_de_caja es >0 es decir no es negativo o 0, singnifica que hay un cliente en la caja, y colacaja
          #Guarda el tiempo que le falta para terminar a cada cliente entonces en todo momento sabe si un cliente termino o no, si no termino se le suma 1 el numero de clientes
          # En esa caja
          numero_clientes_en_caja(numerocaja)=numero_clientes_en_caja(numerocaja)+1;
         endif

    endfor
    matrix_numero_clientes_en_caja(i, numerocaja)=numero_clientes_en_caja(numerocaja);
  endfor


  % Cliente i elige la caja con menor tiempo de uso
    [~, caja_elegida] = min(numero_clientes_en_caja); #para comparar me fijo en vez de que caja se desocupa primero que caja tiene menos clientes
     tiempo_espera_cada_una_con_fila(i) = ocupacion_actual_cajas_cada_una_con_fila(caja_elegida);   % Cliente i espera en la fila de la caja elegida

    matrix_cajas_elegidas_cada_una_con_fila(i)=caja_elegida;
    cola_de_caja(i,caja_elegida)=ocupacion_actual_cajas_cada_una_con_fila(caja_elegida)+ productos(i) + tiempo_pago(i); #Y aqui lo que hago es guardar la instancia del cliente en la colacaja
    #para poder saber cuando termina con lo de antes
    ocupacion_actual_cajas_cada_una_con_fila(caja_elegida) = ocupacion_actual_cajas_cada_una_con_fila(caja_elegida) + productos(i) + tiempo_pago(i);
    % Cliente i es atendido en la caja elegida
   for numerocaja = 1:k
    if(numerocaja!=caja_elegida)
             tiempo_libre_cajas_cada_una_con_fila(numerocaja) = tiempo_libre_cajas_cada_una_con_fila(numerocaja) + max(0, tiempo_llegada(i) - pre_ocupacion_cajas_cada_una_con_fila(numerocaja));
    endif
    if(numerocaja=caja_elegida)
           tiempo_libre_cajas_cada_una_con_fila(numerocaja) = tiempo_libre_cajas_cada_una_con_fila(numerocaja) + max(0, tiempo_llegada(i) - pre_ocupacion_cajas_cada_una_con_fila(numerocaja) - productos(i) - tiempo_pago(i));
    endif

   endfor
    tiempo_uso_cajas_cada_una_con_fila(caja_elegida) = tiempo_uso_cajas_cada_una_con_fila(caja_elegida) + productos(i) + tiempo_pago(i);% Cliente i es atendido en la caja elegida



end



% Visualización de resultados para cada caja con su propia fila
figure;
subplot(2, 1, 1);
bar(tiempo_uso_cajas_cada_una_con_fila);
title('Tiempo de uso de cada caja (Cada una con su propia fila)');
xlabel('Caja');
ylabel('Tiempo de uso');


subplot(2, 1, 2);
bar(tiempo_espera_cada_una_con_fila);
title('Tiempo de espera de cada cliente en la fila (Cada una con su propia fila)');
xlabel('Cliente');
ylabel('Tiempo de espera');

fprintf('Estadísticas (Cada una con su propia fila):\n');
fprintf('Tiempo de uso - Media: %.2f, Desviación estándar: %.2f\n', mean(tiempo_uso_cajas_cada_una_con_fila), std(tiempo_uso_cajas_cada_una_con_fila));
fprintf('Tiempo de espera - Media: %.2f, Desviación estándar: %.2f\n', mean(tiempo_espera_cada_una_con_fila), std(tiempo_espera_cada_una_con_fila));
fprintf('Tiempo libre de cajas - Media: %.2f\n', mean(tiempo_libre_cajas_cada_una_con_fila));