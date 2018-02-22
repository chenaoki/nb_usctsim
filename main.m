addpath('usctsim\')

% paramters 
result_path = '\\azlab-fs01\東研究室\個人work\富井\nb_usctsim\sim_005\';

num_of_cirle = 10; % 円の個数
num_of_trial = 10; % 試行回数

% initialization
load('usctsim\param_sample.mat');
Nx = param.grid.Nx;
Ny = param.grid.Ny;
Cx = Nx/2;     % 
Cy = Ny/2;     %
R_min = Nx/16; %
R_max = Nx/8;  %

if ~exist(result_path, 'dir')
    mkdir(result_path);
end

for n = 1:num_of_trial
    
    out_dir = [result_path, 'trial_', num2str(n, '%03d')];
    disp(out_dir);

    load("usctsim\medium_sample.mat");
    density_sum = mean(mean(medium.density));
    medium.sound_speed(:,:) = mean(mean(medium.sound_speed)); % 音速一様
    medium.density(:,:)     = mean(mean(medium.density));
    
    arr_params = rand(3, num_of_cirle);
    for v = arr_params
        %中心位置と半径をランダムに設定し、密度分布に重ね書きしていく
        x = v(1,1);
        y = v(2,1);
        r  = v(3,1); 
        medium.density= func_putCircle( ...
            medium.density, ...
            Cx+(x*Nx - Cx)/(Cx/R_max), ...
            Cy+(y*Ny - Cy)/(Cy/R_max), ...
            r*(R_max-R_min)+R_min, ...
            density_sum);
    end

    imagesc(medium.density);colorbar();
    
    simulate_usct(param, medium, out_dir);

end