data_set = 'rcv';
% data_set = 'corel';
sel_item = 5000;

input_file = ['data/', num2str(data_set), '_feature.mat'];
load(input_file);
input_file = ['data/', num2str(data_set), '_label.mat'];
load(input_file);
feature = feature(1:sel_item, :);
label = label(1:sel_item, :);

sample_num_array = [20 50 100 200 500 1000 1500];
sigma = 20;
num_clusters = 18;

result_mat_nystorm = zeros(numel(sample_num_array), 3);
  
for i = 1:numel(sample_num_array)
    tStart = tic;
    l = sample_num_array(i);
    
    [cluster_labels evd_time kmeans_time total_time] = nystrom(feature, l, sigma, num_clusters);
    accuracy_score = accuracy(label, cluster_labels);

    iteration_time = toc(tStart);
    result_mat_nystorm(i, :) = [l ,accuracy_score, iteration_time];
    
end
% result_mat_nystorm

plot(result_mat_nystorm(:,1),result_mat_nystorm(:,2));
xlabel('l');
ylabel('accuracy');
figure;
plot(result_mat_nystorm(:,1),result_mat_nystorm(:,3));
xlabel('l');
ylabel('time');