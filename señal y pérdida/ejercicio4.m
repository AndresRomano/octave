clear
Vector_X = [0,1,2,3,4,5,6,7,8,9,10];
Vector_Y =[-23,-31,-33,-36,-38,-44,-46,-48,-49,-51,-62];
plot(Vector_X, Vector_Y);
title('Gr�fico de lineas');
xlabel('Distancia (m)');
ylabel('Se�al (dBm)');
%---------------------------------------------------------
figure(2)
clear
Vector_X = [0,1,2,3,4,5,6,7,8,9,10];
Vector_Y =[-23,-31,-33,-36,-38,-44,-46,-48,-49,-51,-62];
bar(Vector_X, Vector_Y);
title('Gr�fico de barras');
xlabel('Distancia (m)');
ylabel('Se�al (dBm)');