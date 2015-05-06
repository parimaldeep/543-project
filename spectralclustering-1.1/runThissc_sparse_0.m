% data_set = 'rcv';
data_set = 'corel';
% sel_item = 5000;

input_file = ['data/', num2str(data_set), '_feature.mat'];
load(input_file);

input_file = ['data/', num2str(data_set), '_label.mat'];
load(input_file);

% feature = feature(1:sel_item, :);
% label = label(1:sel_item, :);

list_t = [20 50 100 200 500 1000 1500];
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

