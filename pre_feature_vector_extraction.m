function feature_vector = pre_feature_vector_extraction(sorted_spikes)
% This function takes .mat file as an input argument
% the .mat file conatin two construct(NEV,sortedspikes)
% 1)NEV is again a construct conatin the spiking activity of cells(neuron) on all
% electrodes(channels).
% 2) SortedSpikes is  a consruct contains the information about sorted spikes
% of each channels
% This function process the raw inoframtion comming from .NEV file and 

%spike_data = sorted_spikes;

% Loading mat file path must be provided as input argument to function
spike_data=load(sorted_spikes);
%-----------------------------------------------------------------------------
% First extract all the necessary from nev construct
%1) indices of spikes
%2) time stamp of spikes
%3) Data of each spike(not needed to process further)
%----------------------------------------------------------------------


spike_data_of_all_channels=spike_data.NEV.Data.Spikes.Waveform; % spike data not required
spikes_occurance_accumulative = spike_data.NEV.Data.Spikes.Electrode; % occurance of spikes  with respect to electorde 
                                                                        % number  
spikes_time_stamp_accumulative = spike_data.NEV.Data.Spikes.TimeStamp; %time stamp of each spike 

electrode_used = unique(spike_data.NEV.Data.Spikes.Electrode); % total number of used lectrode

for ii=1:1:length(electrode_used)
    spikes_indices_of_single_electrode = find(spikes_occurance_accumulative==ii); % find the all spikes of every individual 
                                                                                   %electrode                     
    single_electrode.spike_indices{ii}=spikes_indices_of_single_electrode;
    time_stamps_single_electrode =spikes_time_stamp_accumulative(spikes_indices_of_single_electrode);
    single_electrode.time_stamps{ii}=time_stamps_single_electrode;
    data_spikes_single_eletrode= spike_data_of_all_channels(spikes_indices_of_single_electrode);
    single_electrode.waveforms=data_spikes_single_eletrode; 
end
%-----------------------------------------------------------%
% Now extracting inforamtion from sortedSpikes construct and putting all the information together
%1)I am intersted, which spike belongs to which eletrode.
%2) More specefically, which spikes belongs to which unit.
%3) Time stamps of spike.
%The section given below extract all the necessary information comming from
%different sources and putting  them together in single matrix.
% Later on I will use this inofrmation and extract fetaure vector, which
% later on will be used to train my model(machine learning) algorithm.
%--------------------------------------------------------------%
sorted_spikes_raw = spike_data.sortedSpikes;
for jj=1:1:length(electrode_used)
    unit_activity=sorted_spikes_raw{1, jj}.index;
    elctrode_activity=single_electrode.spike_indices{jj};
    time_stamps_activity =single_electrode.time_stamps{jj};
    information = vertcat(unit_activity,elctrode_activity,time_stamps_activity);
    sorted_spike_filtered.information{jj} = information';
end
feature_vector=sorted_spike_filtered;
end











