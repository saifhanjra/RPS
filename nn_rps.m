clear 
clc

% data prepocessing

Data=csvread('C:\Users\KlaesLab03\Desktop\OneDrive for Business\matlab_script\PhD_stuff\feature_extraction(supervised_learning)\csv_files\feature_vetcor_label.csv');

data = Data(:,1:17);
labels = Data(:,18);

target_matrix=zeros(3,26);


for ii=1:26
    label_ii=labels(ii);
    target_matrix(label_ii,ii) =1;  
end

data=data';
%Feed forward Artificial Neural Networks 
x = data; % data, each column corresponds to one observation
t = target_matrix; %true output

setdemorandstream(6899851)

net = patternnet([12]); % architecture of network, contain one hidden layer with 10 neurons
%view(net);

[net,tr]= train(net,x,t);
%nntraintool

%plotperform(tr)

testX = x(:,tr.testInd);
testT = t(:,tr.testInd);

testY = net(testX);
testIndices = vec2ind(testY)

[c,cm] = confusion(testT,testY)

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);



