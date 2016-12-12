clear all
clc

sorted_data= pre_feature_vector_extraction('C:\Users\KlaesLab03\Desktop\OneDrive for Business\matlab_script\PhD_stuff\feature_extraction(supervised_learning)\rps_20131016-115158-NSP1-001.mat');
behavioral_data=load('C:\Users\KlaesLab03\Desktop\OneDrive for Business\matlab_script\PhD_stuff\feature_extraction(supervised_learning)\20131016-115158_rps_01_behav.mat');

[semi_final_sorted_units_labels,accumulative_activity_units_result]=single_unit_activity_variable_events(sorted_data,behavioral_data);

%accumulative_activity=accumulative_activity_units_result;



total_tasks_session=length(accumulative_activity_units_result.data);

electrode_implanted=length(accumulative_activity_units_result.data{1, 1}.sorted_spikes_unit);

index=1;

for ii=1:electrode_implanted
    if ~isempty(accumulative_activity_units_result.data{1, 1}.sorted_spikes_unit{1, ii})
        index_meaningful_data(index)=ii;
        index=index+1;
        
        
    end
end
data=[];
features_vetctors_this_task=zeros(50,45);
for jj=1:total_tasks_session
    for kk=1:length(index_meaningful_data)
    new_data=accumulative_activity_units_result.data{1, jj}.sorted_spikes_unit{1,index_meaningful_data(kk)};
    data=[data,new_data];
    end
    
    feature_vectors_final.data{jj}=data;
    features_vetctors_this_task(jj,:)=data;
    data=[];
    
end



