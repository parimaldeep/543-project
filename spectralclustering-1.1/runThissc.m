data_set = 'rcv';
% data_set = 'corel';

input_file = ['data/', num2str(data_set), '_feature.mat'];
load(input_file);
input_file = ['data/', num2str(data_set), '_label.mat'];
load(input_file);


list_t = [5 10 15 20 50 100 150 200];
result_mat_sc = zeros(numel(list_t), 3);

sigma = 20;
num_clusters = 18;
block_size = 10;
for i = 1:numel(list_t)
    tic;
    t = list_t(i);
    gen_nn_distance(feature, t, block_size, 0);

    input_file = [num2str(t), '_NN_sym_distance.mat'];
    load(input_file, 'A');

    [cluster_labels evd_time kmeans_time total_time] = sc(A, sigma, num_clusters);
    
    accuracy_score = accuracy(label, cluster_labels);
    
    iteration_time = toc;
    result_mat(i, :) = [t ,accuracy_score, iteration_time];
end
result_mat