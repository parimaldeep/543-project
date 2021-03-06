% close all;
data_set = 'rcv';
% data_set = 'corel';
sel_item = 25000;

input_file = ['data/', num2str(data_set), '_feature.mat'];
load(input_file);

input_file = ['data/', num2str(data_set), '_label.mat'];
load(input_file);

% feature = feature(1:sel_item, :);
% label = label(1:sel_item, :);

num_n = 10;
list_n = linspace(0, sel_item, num_n);
list_n = list_n(:, 1:end - 1);
list_n = list_n(:, 2:end);
list_n = floor(list_n);

[M, N] = size(feature);

result_mat_sc1 = zeros(numel(list_n), 4);

sigma = 2;
num_clusters = 103;
block_size = 10;
for i = 1:numel(list_n)
    tStart = tic;
%     profile clear;
%     profile on -detail builtin -history -memory;
    t = 1;
    sel_item = list_n(i);
    feature_sel = feature(1:sel_item, :);
    label_sel = label(1:sel_item, :);
    gen_nn_distance(feature_sel, sel_item - 1, block_size, 0);

    input_file = [num2str(sel_item - 1), '_NN_sym_distance.mat'];
    load(input_file, 'A');

    size = ByteSize(A);
%     [cluster_labels evd_time kmeans_time total_time] = sc(A, sigma, num_clusters);
    accuracy_score = 0;
%     accuracy_score = accuracy(label_sel, cluster_labels);
    
    iteration_time = toc(tStart);
    result_mat_sc1(i, :) = [sel_item ,accuracy_score, iteration_time, size];
%     S = profile('status');
%     profile off;
%     profile viewer;
end
result_mat_sc1

plot(result_mat_sc1(:,1),result_mat_sc1(:,2));
xlabel('Number of images');
ylabel('Accuracy percentage');
figure;
plot(result_mat_sc1(:,1),result_mat_sc1(:,3));
xlabel('Number of images');
ylabel('Time in seconds');
figure;

delete *.mat;