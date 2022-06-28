% Requiere del "Electromagnetic Waves & Antennas Toolbox" de Sophocles Orfanidis

zg=50;
zl= 797.3 + 1i*1497.4;

f=sqrt(28*29.7)*1e6;

R = calcularRvirtual(zg,zl,20);

ImpedanciasAcople=pmatch(zg,zl,R);
ValoresAcople = impedance2inmitance(ImpedanciasAcople, f);
disp("4 posibles redes de acople (Condensadores negativos y en pF; inductores positivos y en nH)");
disp(ValoresAcople);

function Rvir = calcularRvirtual(z1, z2, q)
a1 = real(z1) + (imag(z1)^2)/(real(z1));
a2 = real(z2) + (imag(z2)^2)/(real(z2));
Rvir = (sqrt(4*q^2*a1*a2-(a1-a2)^2)+q*(a1+a2))/(4*q*(1+q^2));
end

function Inm = impedance2inmitance(Impedance, freq)
    Inm = zeros(size(Impedance));
    Inm(Impedance<0) = 1./(2*pi*freq*(Impedance(Impedance<0)))*1e12;
    Inm(Impedance>0) = (Impedance(Impedance>0))./(2*pi*freq)*1e9;
end