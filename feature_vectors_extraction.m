
function feature_vectors =feature_vectors_extraction(sorted_data_for_session,events_task,number_channels)
%pre-req:- for this function is pre_feature_vector_extraction 
% which will give me spikes wih associated class of each electrode for
% complete seesion.

%--------------------------------------------------------------------------
%Responsibilty of this function:- This function will take following input
%argument 
%1) sorted_data_for session: which will be given by pre-req function
%explained above
%2)events_task: timing of each event in one paricular task given by function (single_unit_activity) 
%3)number_channel: total number of active channel which can be extracted
%from sorted data
%output argument will tell, how many spikes are associated with one
%paricular unit of one particular electrode 
%-------------------------------------------------------------------------



  
    data=sorted_data_for_session; %  

    
    event_time=events_task;
    total_number_of_events = length(event_time); 

    total_numnber_of_channels = number_channels;
   
    

    for kk=1:1:total_numnber_of_channels % k=total number of electrodes
        %pre_processed_data=data.information{1,kk};
        units= data.information{1,kk}(:,1); %sorted units per elecrode
        %spike_index=data.information{1,kk}(:,2); % spike_indices
        time_stamps=data.information{1,kk}(:,3);  % time stamps
    


        sorted_units = unique(units); % total number of sorted units of kth electrode
        total_sorted_units = length(sorted_units);
    
        spike_activity_over_complete_task = zeros(total_number_of_events-1,total_sorted_units); %spike_activity_over_complete_task = number_of_events,total_sorted_units
                                                                                           %Just using it here to preallocate the space in memory
        activity_particular_unit_per_event=zeros(total_sorted_units,1);  %%have a look at
                                                                      %preallcating memory
        %time_stamp_per_event= zeros(total_number_of_events,2);
                                                                      

        for ii=2:1:total_number_of_events  %ii=total number of events in task
            lower_limit=event_time(ii-1);
            upper_limit= event_time(ii);
            spike_activity_index = find(time_stamps>=lower_limit & time_stamps <upper_limit) ; %index of the unit
            spike_activity_values =units(spike_activity_index);  % identified units of particular electrode
        
        
        
            for jj =1:1:total_sorted_units    %% total number of sorted units in particular eletrode
                activity_particular_unit_per_event(jj)= sum(spike_activity_values==sorted_units(jj));
            end
        
        
            spike_activity_over_complete_task(ii-1,:)=activity_particular_unit_per_event;
        
        
                
        end
        feature_vectors.sorted_spikes_unit{kk}=spike_activity_over_complete_task;
        feature_vectors.sorted_units_ids{kk}=sorted_units;
    
    

    end

end











