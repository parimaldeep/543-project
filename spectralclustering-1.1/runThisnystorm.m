% data_set = 'rcv';
data_set = 'corel';

input_file = ['data/', num2str(data_set), '_feature.mat'];
load(input_file);
input_file = ['data/', num2str(data_set), '_label.mat'];
load(input_file);

sample_num_array = [20 50 100 200 500 1000 1500 2000];
sigma = 20;
num_clusters = 18;

result_mat_nystorm = zeros(numel(sample_num_array), 3);
  
for i = 1:numel(sample_num_array)
    tic;
    l = sample_num_array(i);
    
    [cluster_labels evd_time kmeans_time total_time] = nystrom(feature, l, sigma, num_clusters);
    accuracy_score = accuracy(label, cluster_labels);

    iteration_time = toc;
    result_mat_nystorm(i, :) = [l ,accuracy_score, iteration_time];
    
end
result_mat_nystorm