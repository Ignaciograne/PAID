function Q=cuantificacion(n)
  % n debe estar en el intervalo [0,100[
  Q50 = [16 11 10 16 24  40  51  61;
         12 12 14 19 26  58  60  55;
         14 13 16 24 40  57  59  56;
         14 17 22 29 51  87  80  62;
         18 22 37 56 68  109 103 77;
         24 35 55 64 81  104 113 92;
         49 64 78 87 103 121 120 101;
         72 92 95 98 112 100 103 99];

  if n==50
    Q=Q50;
  elseif n==0
    Q=ones(8,8);
  elseif and(n>50,n<100)
    Q = round(((100-n)/50)*Q50);
  elseif and(0<n,n<50)
    Q = round((50/n)*Q50);
  else
    Q=NaN;
    display('n debe ser un valor en el intervalo [0,100[')
  end

end
