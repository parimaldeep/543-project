close all;
data_set = 'rcv';
% data_set = 'corel';
sel_item = 5000;

input_file = ['data/', num2str(data_set), '_feature.mat'];
load(input_file);
input_file = ['data/', num2str(data_set), '_label.mat'];
load(input_file);

l = 50;
num_n = 20;
list_n = linspace(0, sel_item, num_n);
list_n = list_n(:, 1:end - 1);
list_n = list_n(:, 2:end);
list_n = floor(list_n);

sigma = 20;
num_clusters = 18;

result_mat_nystorm = zeros(numel(list_n), 3);
  
for i = 1:numel(list_n)
    tStart = tic;
    sel_item = list_n(i);
    feature_sel = feature(1:sel_item, :);
    label_sel = label(1:sel_item, :);
    
    [cluster_labels evd_time kmeans_time total_time] = nystrom(feature_sel, l, sigma, num_clusters);
    accuracy_score = accuracy(label_sel, cluster_labels);

    iteration_time = toc(tStart);
    result_mat_nystorm(i, :) = [sel_item ,accuracy_score, iteration_time];
    
end
result_mat_nystorm

plot(result_mat_nystorm(:,1),result_mat_nystorm(:,2));
xlabel('Number of images');
ylabel('Accuracy percentage');
figure;
plot(result_mat_nystorm(:,1),result_mat_nystorm(:,3));
xlabel('Number of images');
ylabel('Time in seconds');

delete *.mat;