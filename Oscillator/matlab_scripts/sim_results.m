close all

sim_data1 = LTspice2Matlab('BJT_gain_characterization.raw');

Ic = sim_data1.freq_vect;
Vin = sim_data1.variable_mat(4,:);
Vout = sim_data1.variable_mat(6,:);
gain = abs(Vout)./abs(Vin);
figure(1)
p = plot(Ic*1e3,gain,'LineWidth',1);
row = dataTipTextRow('Ic',Ic*1e3,'%5.5g mA');
p.DataTipTemplate.DataTipRows(1) = row;
row = dataTipTextRow('Gain',gain,'%5.5g');
p.DataTipTemplate.DataTipRows(2) = row;
dt = datatip(p,30,gain(30));
dt.Location = 'northwest';
xlabel('colector current [mA]');
ylabel('gain');
grid on


sim_data2 = importdata('osc_clapp.txt');

freq = sim_data2(:,1)*1e-6;
spectrum = db(sim_data2(:,2)+1i*sim_data2(:,3));
index_q = find(spectrum>max(spectrum)-3);
BW = freq(index_q(end)+1)-freq(index_q(1)-1);
Q = freq(spectrum == max(spectrum))/BW;
disp("Q = "+Q)
figure()
sm = semilogx(freq,spectrum);
grid on
xlim([freq(1) freq(end)])
ylim([-100 15])
xlabel('frequency [MHz]')
ylabel('output voltage [dB]')
row = dataTipTextRow('f',freq,'%5.5g MHz');
sm.DataTipTemplate.DataTipRows(1) = row;
row = dataTipTextRow('Vout',spectrum,'%5.5g dB');
sm.DataTipTemplate.DataTipRows(2) = row;
dt1 = datatip(sm,freq(spectrum == max(spectrum)),max(spectrum));
dt1.Location = 'northwest';
dt2 = datatip(sm,freq(5860),spectrum(5860));
dt2.Location = 'northeast';




