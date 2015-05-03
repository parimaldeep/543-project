load data/corel_feature.mat;
load data/corel_label.mat;
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
    result_mat_nystorm(i, :) = [result_mat_nystorm ,accuracy_score, iteration_time];
    
end
result_mat_nystorm