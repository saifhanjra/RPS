clear all
clc

behavioral_data=load('C:\Users\KlaesLab03\Desktop\OneDrive for Business\matlab_script\PhD_stuff\feature_extraction(supervised_learning)\20131016-115158_rps_01_behav.mat'); 
labels_session=csvread('C:\Users\KlaesLab03\Desktop\OneDrive for Business\matlab_script\PhD_stuff\feature_extraction(supervised_learning)\csv_files\labels.csv');

% label of rock is 1
% label of paper is 2
% label of scissor is 3
total_feature_vectors = length(labels_session);


button_pressed=[];
action_type=[];
cmp_actual_predicted=[];

% figuring out successful trials
for ii=1:1:50
    button_pressed_ii=behavioral_data.saveData.Trials(ii).ButtonPressed;
    button_pressed=strvcat(button_pressed,button_pressed_ii);
    action_type_ii=behavioral_data.saveData.Trials(ii).ActionType;
    action_type  =strvcat(action_type,action_type_ii);
    cmp_actual_predicted_ii=strcmp(button_pressed_ii,action_type_ii);
    cmp_actual_predicted=[cmp_actual_predicted,cmp_actual_predicted_ii];
    
end

get_label=find(cmp_actual_predicted==1);

labels_session=labels_session(get_label);


rock=find(labels_session==1);
paper=find(labels_session==2);
scissor=find(labels_session==3);

data_session =csvread('C:\Users\KlaesLab03\Desktop\OneDrive for Business\matlab_script\PhD_stuff\feature_extraction(supervised_learning)\csv_files\feature_vetcor_imp.csv');
%data_session= features_vetctors_this_task
data_session =data_session(get_label,:);

data_rock=data_session(rock,:);
data_paper=data_session(paper,:);
data_scissor=data_session(scissor,:);
data_in_order=[data_rock;data_paper;data_scissor];
%#############################################################################################%
%##############################################################################################

% Applying PCA (feature reduction)
% m= total training examples
% n dmension of each example
% data matrix every row is one observation

X=data_in_order;
m=length(X(:,1)); % total training example
n=length(X(1,:));  %dimension of each training example

% Apply mean normalization(data_preprocessing)
 for jj = 1:n
     x_jj=X(:,jj);
     mean_jj=mean(x_jj);
     norm_features=x_jj-mean_jj;
     X(:,jj)=norm_features;
 end
 %vectorize implementation of covarinace matrix
sigma=(1/m)*(X'*X); 

% Singualr value decompoistion
% Eigen value decomposition can also be used 
[U,S,V]=svd(sigma); %Singular value decomposition
%[U,S,V]=eig(sigma)

% Tuning the paramter,number of principle component
 sum_of_all_princ=sum(diag(S));

 diag_s=diag(S);
% 
k=1;
% var=1; %intializing the variance parmter
% I don't want to loose meaningful information from the data
 var=1; %means i want to maintain 99% variance of data
while var >0.05  
    sum_of_selected_princ=sum(diag_s(1:k));
    var=1-sum_of_selected_princ/sum_of_all_princ;
    k=k+1;
       
end
u_reduce =U(:,1:k); %selecting the eigen vectors, which contain most of the variance in data
z=zeros(m,k); %pre allocation

for ll=1:m
    x_ll=X(ll,:);
    z_ll=u_reduce'*x_ll';
    z_ll=z_ll';
    z(ll,:)=z_ll;
end




