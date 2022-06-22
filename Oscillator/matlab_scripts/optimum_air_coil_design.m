close all
C = 30e-12;
f0 = sqrt(28e6*29.71e6);

inductance_obj = 1/(C*(2*pi*f0)^2)*1e6;   % in uH



AWG_d = [1.29,1.15,1.0240,0.9120,0.812,0.723,0.644,0.573,0.511,0.455,...
         0.405,0.361,0.321,0.286,0.255,0.227,0.202,0.18,0.16]/10;
AWG = 16:34;
l = 10*(197*AWG_d).^(2/3)*(29*inductance_obj)^(1/3)/197; % in cm; inductance in uH
N = l./AWG_d;

figure()
yyaxis left
scatter(AWG,l,'Linewidth',1.2),
xlabel('AWG number'),ylabel('coil length [cm]'),
yyaxis right
scatter(AWG,N,'Linewidth',1.2),
hold on 
for n = floor(min(N)):floor(max(N))+1
    plot([AWG(1) AWG(end)],[n n],':k')
end
ylabel('coil number of turns'),
set(gca,'ytick',floor(min(N)):floor(max(N))+1);
    
    


index_design = 5; % select design point

final_N = round(N(index_design));
final_l = final_N*AWG_d(index_design);
final_r = final_l/2;
final_inductance = 0.394*final_r^2*final_N^2/(9*final_r+10*final_l);
needed_C = 1/(final_inductance*1e-6*(2*pi*f0)^2)*1e12;
disp("design result:")
disp("objetiv inductance: "+inductance_obj*1e3+" nH")
disp("turns: "+final_N);
disp("diameter: "+2*final_r+" cm");
disp("final inductance: "+final_inductance*1e3+" nH")
disp("error: "+(final_inductance-inductance_obj)/inductance_obj*100+" %");
disp("needed C: "+needed_C+" pF")


