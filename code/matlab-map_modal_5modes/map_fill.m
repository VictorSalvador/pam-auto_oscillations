%% Init resonator
close all;
clear;

l = 0.5042; % 0.5042 pour que g=0.4, z=0.15 donne un mi a 1e-2 près

run("init_resonator");

t_end = 2;
Fs = 44100;
%% Test unique

% 0.7 0.5 est quasi periodique
gamma = 0.4; 
zeta = 0.15;

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

plot(p)



% --- MIR Toolbox ---
% mirgetdata(mirscalar) -> ce qu'on veut
% a = miraudio(p,Fs) -> MIRobject
% mirattacktime

%% Fill Colormap
N_split = 20;
gamma_list = linspace(0, 1, N_split);
zeta_list = linspace(0, 1, N_split);
characteristics = zeros(N_split) * nan;

% descriptor = @(x,y) descriptor_mir(x, y, res, t_end, Fs
descriptor = @(x,y) descriptor_in_tune(x, y, res, t_end, Fs);
% descriptor = @(x,y) descriptor_periodic(x, y, res, t_end, Fs);

svm_has_osc = load("descriptor_has_oscillations.mat").svm_col{end};
svm_is_stable = load("descriptor_itg_instable.mat").svm_col{end};


for i = 1:N_split
    for j = 1:N_split
        gamma = gamma_list(i);
        zeta = zeta_list(j);
        if (svm_has_osc.eval([gamma, zeta])> 0) && (svm_is_stable.eval([gamma, zeta]) < 0)
            characteristics(j,i) = descriptor(gamma, zeta);
        end
    end
end

%% 
figure;
% data = (characteristics - 164.814)/164.814;
data = characteristics;
p = imagesc(gamma_list, zeta_list, data);
xlabel('$\gamma$', 'Interpreter', 'latex');
ylabel('$\zeta$', 'Interpreter', 'latex');
set(p,'AlphaData',~isnan(data));
set(gca,'YDir','normal');
colorbar;
