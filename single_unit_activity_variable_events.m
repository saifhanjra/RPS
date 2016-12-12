

function [semi_final_sorted_units_labels,accumulative_activity_units_result]=single_unit_activity_variable_events(sorted_data,behavioral_data)

sorted_data_for_session=sorted_data;
loading_behavioral_data=behavioral_data;

% sorted_data_for_session= pre_feature_vector_extraction('C:\Users\KlaesLab03\Desktop\20131016\NSP1\SortedObjects\rps_20131016-115158-NSP1-001.mat');
% loading_behavioral_data=load('C:\Users\KlaesLab03\Desktop\20131016\Task\20131016-115158_rps_01_behav.mat');

tasks_with_events=loading_behavioral_data.saveData.EventTimes; %% tasks with events

total_number_task = length(tasks_with_events(:,1));
total_number_events = length(tasks_with_events(1,:));

number_channels=length(sorted_data_for_session.information);

%events_task=tasks_with_events(1,:);
%extracted_features = feature_vectors_extraction(sorted_data_for_session,events_task,number_channels);


for ii = 1:1:total_number_task
    events_task=tasks_with_events(ii,:);
    events_task=events_task/3.3333e-05; %mapping task time into NSP
    extracted_features = feature_vectors_extraction_variable_event_time(sorted_data_for_session,events_task,number_channels);
    extracted_features_final.data{ii}=extracted_features;
end

for jj=1:1:total_number_task
   data=extracted_features_final.data{1, jj}; %%
   for kk=1:1:number_channels
       sorted_units=extracted_features_final.data{1, jj}.sorted_spikes_unit{1,kk};
       sorted_units_labels = extracted_features_final.data{1, jj}.sorted_units_ids{1,kk};
       length_sorted_units=length(sorted_units_labels);
       filter_noise_data=sorted_units_labels(length_sorted_units);
       if filter_noise_data==255
           sorted_units_labels=sorted_units_labels(1:length_sorted_units-1,:);
           sorted_units=sorted_units(:,1:length_sorted_units-1);
       end
       
       semi_final_sorted_units_labels.data{1, jj}.sorted_spikes_unit{1,kk}=sorted_units;
       semi_final_sorted_units_labels.data{1, jj}.sorted_spikes_labels{1,kk}=sorted_units_labels;
       
       accum_result=size(sorted_units);
       accum_result=accum_result(2);
       accumulative_activity_per_unit = zeros(1,accum_result);
       
       for ll=1:1:accum_result
           accumulative_activity_per_unit(ll)=sum(sorted_units(:,ll));
       end
       final_sorted_units_result.data{1, jj}.sorted_spikes_unit{1,kk}=accumulative_activity_per_unit;
       
       if ~isempty(final_sorted_units_result.data{1, jj}.sorted_spikes_unit{1,kk})
           accumulative_activity_units_result.data{1, jj}.sorted_spikes_unit{1,kk}=accumulative_activity_per_unit;
          
       end
    
       
        
    end 
end













    


    






























