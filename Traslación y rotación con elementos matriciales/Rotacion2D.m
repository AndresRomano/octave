# Recibe como entrada un Punto del plano P=[x y], un Centro y un Angulo [radianes]
# realiza la rotación tomando el origen como centro de giro
# Retorna las coordenadas del punto resultante de la traslacion.

function Punto_R = Rotacion2D( Punto, Centro, Angulo )
  % Arma la matriz de rotacion
  M = [cos(Angulo) -sin(Angulo); sin(Angulo) cos(Angulo)]
  
  % Mueve el punto para lograr equivalencia de giro en el origen
  Pt_aux = Traslacion2D(Punto, -Centro);
  
  % Procesa la rotacion en el origen
  Pr_aux = M * [Pt_aux(1); Pt_aux(2)];
  
  % Traslada el resultado, restituyendo posicion
  Punto_R = Traslacion2D(Pr_aux, Centro);

endfunction