close all;
plot(result_mat_sc(:,1),result_mat_sc(:,3), 'r', result_mat_nystorm(:,1),result_mat_nystorm(:,3), 'g', result_mat_sc_E(:,1),result_mat_sc_E(:,3), 'b');
% plot();
% plot();
xlabel('Number of images');
ylabel('Time in seconds');