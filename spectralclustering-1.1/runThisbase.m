% close all;
data_set = 'rcv';
% data_set = 'corel';
sel_item = 25000;

input_file = ['data/', num2str(data_set), '_feature.mat'];
load(input_file);

input_file = ['data/', num2str(data_set), '_label.mat'];
load(input_file);

feature = feature(1:sel_item, :);
label = label(1:sel_item, :);

[M, N] = size(feature);

result_mat_sc = zeros(1, 3);

sigma = 2;
num_clusters = 103;
block_size = 10;
for i = 1:1
    tStart = tic;
%     profile clear;
%     profile on -detail builtin -history -memory;
    t = 1;
    gen_nn_distance_base(feature, block_size, 0);

    input_file = ['base', '_NN_sym_distance.mat'];
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


delete *.mat;