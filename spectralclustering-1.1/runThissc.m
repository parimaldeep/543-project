close all;
data_set = 'rcv';
% data_set = 'corel';
sel_item = 50000;

input_file = ['data/', num2str(data_set), '_feature.mat'];
load(input_file);

input_file = ['data/', num2str(data_set), '_label.mat'];
load(input_file);

feature = feature(1:sel_item, :);
label = label(1:sel_item, :);

[M, N] = size(feature);

% list_t = [20 50 100 200 500 1000 1500];
num_t = 20;
list_t = linspace(0, M, num_t);
list_t = list_t(:, 1:end - 1);
list_t = list_t(:, 2:end);
list_t = floor(list_t);

result_mat_sc = zeros(numel(list_t), 3);

sigma = 20;
num_clusters = 18;
block_size = 10;
for i = 1:numel(list_t)
    tStart = tic;
%     profile clear;
%     profile on -detail builtin -history -memory;
    t = list_t(i);
    gen_nn_distance(feature, t, block_size, 0);

    input_file = [num2str(t), '_NN_sym_distance.mat'];
    load(input_file, 'A');

    [cluster_labels evd_time kmeans_time total_time] = sc(A, sigma, num_clusters);
    
    accuracy_score = accuracy(label, cluster_labels);
    
    iteration_time = toc(tStart);
    result_mat_sc(i, :) = [t ,accuracy_score, iteration_time];
%     S = profile('status');
%     profile off;
%     profile viewer;
end
result_mat_sc

plot(result_mat_sc(:,1),result_mat_sc(:,2));
xlabel('Number of nearest neighbors');
ylabel('Accuracy percentage');
figure;
plot(result_mat_sc(:,1),result_mat_sc(:,3));
xlabel('Number of nearest neighbors');
ylabel('Time in seconds');


delete *.mat;