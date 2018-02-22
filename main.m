addpath('usctsim\')

% paramters 
result_path = '\\azlab-fs01\��������\�lwork\�x��\nb_usctsim\sim_005\';

num_of_cirle = 10; % �~�̌�
num_of_trial = 10; % ���s��

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
    medium.sound_speed(:,:) = mean(mean(medium.sound_speed)); % ������l
    medium.density(:,:)     = mean(mean(medium.density));
    
    arr_params = rand(3, num_of_cirle);
    for v = arr_params
        %���S�ʒu�Ɣ��a�������_���ɐݒ肵�A���x���z�ɏd�ˏ������Ă���
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