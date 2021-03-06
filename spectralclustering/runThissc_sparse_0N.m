% close all;
data_set = 'rcv';
%data_set = 'corel';
sel_item = 10000;

input_file = ['data/', num2str(data_set), '_feature.mat'];
load(input_file);

input_file = ['data/', num2str(data_set), '_label.mat'];
load(input_file);

t = 0.6667; 
num_n = 10;
list_n = linspace(0, sel_item, num_n);
list_n = list_n(:, 1:end - 1);
list_n = list_n(:, 2:end);
list_n = floor(list_n);
%list_n = [50 100 200 500];

sigma = 2;
num_clusters = 103;
block_size = 10;

% list_t = [20 50 100 200 500 1000 1500];
result_mat_sc_E = zeros(numel(list_n), 4);

for i = 1:numel(list_n)
    tStart = tic;
    sel_item = list_n(i);
    
    feature_sel = feature(1:sel_item, :);
    label_sel = label(1:sel_item, :);
    
    gen_nn_distance_sparse_0(feature_sel, block_size, 0, t);
    input_file = 'sparse0_distance.mat';
    load(input_file, 'A');
    
    size = ByteSize(A);
   
    %[cluster_labels evd_time kmeans_time total_time] = sc(A, sigma, num_clusters);

    accuracy_score=0;
%     accuracy_score = accuracy(label_sel, cluster_labels);

    
    iteration_time = toc(tStart);
    result_mat_sc_E(i, :) = [sel_item ,accuracy_score, iteration_time, size];
%     S = profile('status');
%     profile off;
%     profile viewer;
end
result_mat_sc_E


display(result_mat_sc_E(:,1));
display(result_mat_sc_E(:,2));
display(result_mat_sc_E(:,3));
display(result_mat_sc_E(:,4));

plot(result_mat_sc_E(:,1),result_mat_sc_E(:,2));
xlabel('Number of images');
ylabel('Accuracy percentage');
figure;
plot(result_mat_sc_E(:,1),result_mat_sc_E(:,3));
xlabel('Number of images');
ylabel('Time in seconds');
figure;

delete *.mat;