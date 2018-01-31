addpath('usctsim\')

% paramters 
result_path = '\\azlab-fs01\€Ί\Βlwork\xδ\2018-01-13_1\';

num_of_cirle = 20; % ~ΜΒ
num_of_trial = 1;  % sρ

% initialization
load('usctsim\param_sample.mat');
Nx = param.grid.Nx;
Ny = param.grid.Ny;
Cx = Nx/2;         % 
Cy = Ny/2;         %
R_max = Nx/8;      %

for n = 1:num_of_trial
    
    out_dir = [result_path, 'trial_', num2str(n, '%03d')];
    disp(out_dir);

    load("usctsim\medium_sample.mat");
    sum_amount = mean(mean(medium.density));
    
    arr_params = rand(3, num_of_cirle);
    for v = arr_params
        %SΚuΖΌaπ_Ιέθ΅A§xͺzΙdΛ«΅Δ’­
        x = v(1,1);
        y = v(2,1);
        r  = v(3,1); 
        medium.density= func_putCircle( ...
            medium.density, ...
            Cx+(x*Nx - Cx)/(Cx/R_max), Cy+(y*Ny - Cy)/(Cy/R_max), r*R_max, sum_amount);
    end

    imagesc(medium.density);colorbar();
    
    simulate_usct(param, medium, out_dir);

end