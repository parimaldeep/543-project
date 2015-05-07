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
num_t = 20;
sigma = 10;
num_clusters = 103;
block_size = 10;

[A, minVal, maxVal] = gen_nn_distance_sparse_0(feature, block_size, 0, -1);

list_E = linspace(minVal, maxVal, num_t);
list_E = list_E(:, 1:end - 1);
list_E = list_E(:, 2:end);


% list_t = [20 50 100 200 500 1000 1500];
result_mat_sc_E = zeros(numel(list_E), 3);

for i = 1:numel(list_E)
    tStart = tic;
    t = list_E(i);
    
%     gen_nn_distance_sparse_0(feature, block_size, 0, t);
%     input_file = 'sparse0_distance.mat';
%     load(input_file, 'A');

    B = A;
    index = find (B < t);
    B(index) = 0;
    
    [cluster_labels evd_time kmeans_time total_time] = sc(B, sigma, num_clusters);
    
    accuracy_score = accuracy(label, cluster_labels);
    
    iteration_time = toc(tStart);
    result_mat_sc_E(i, :) = [t ,accuracy_score, iteration_time];
%     S = profile('status');
%     profile off;
%     profile viewer;
end
result_mat_sc_E

plot(result_mat_sc_E(:,1),result_mat_sc_E(:,2));
xlabel('Threshold value (epsilon)');
ylabel('Accuracy percentage');
figure;
plot(result_mat_sc_E(:,1),result_mat_sc_E(:,3));
xlabel('Threshold value (epsilon)');
ylabel('Time in seconds');
figure;

delete *.mat;