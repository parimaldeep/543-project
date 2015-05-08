% close all;
data_set = 'rcv';
% data_set = 'corel';
sel_item = 5000;

input_file = ['data/', num2str(data_set), '_feature.mat'];
load(input_file);
input_file = ['data/', num2str(data_set), '_label.mat'];
load(input_file);
feature = feature(end-sel_item+1:end, :);
label = label(end-sel_item+1:end, :);


[M, N] = size(feature);

num_array = 20;
% sample_num_array = linspace(10, M -100, num_array);
% sample_num_array = sample_num_array(:, 1:end - 1);
% sample_num_array = sample_num_array(:, 2:end);
% sample_num_array = floor(sample_num_array);

% sample_num_array=[200 500 800 1000 1500 2000 2500 3000 3500];
sample_num_array=[20 50 100 200 500 1000 1500 2000];

sigma = 2;
num_clusters = 103;




result_mat_nystorm = zeros(numel(sample_num_array), 3);
  
for i = 1:numel(sample_num_array)
    tStart = tic;
    l = sample_num_array(i);
    
    [cluster_labels evd_time kmeans_time total_time] = nystrom(feature, l, sigma, num_clusters);
    accuracy_score = accuracy(label, cluster_labels);

    iteration_time = toc(tStart);
    result_mat_nystorm(i, :) = [l ,accuracy_score, iteration_time];
    
end
result_mat_nystorm

plot(result_mat_nystorm(:,1),result_mat_nystorm(:,2));
xlabel('Number of sample data points (l)');
ylabel('Accuracy percentage');
figure;
plot(result_mat_nystorm(:,1),result_mat_nystorm(:,3));
xlabel('Number of sample data points (l)');
ylabel('Time in seconds');
figure;

delete *.mat;
