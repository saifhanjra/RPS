% this script will extract the label from th behavioral mat file of one complete session



behavioral_data=load('C:\Users\KlaesLab03\Desktop\20131016\Task\20131016-115158_rps_01_behav.mat');


trials_data = behavioral_data.saveData.Trials;

% Now I am intersted in onl in thge labels

labels=[];
for ii=1:1:50
    labels_ii = behavioral_data.saveData.Trials(ii).ActionType;
    labels=strvcat(labels,labels_ii);   
end

for jj=1:1:50
    label_conversion=labels(jj,:);
    find_spaces=isspace(label_conversion);
   
    find_spaces=find(find_spaces==1);
    
    if ~isempty(find_spaces)
     label_conversion=label_conversion(1:find_spaces-1);
    end
    
    
   

if strcmp('rock',label_conversion)==1
    label_conversion=1;
elseif strcmp('paper',label_conversion)==1
    label_conversion=2;
elseif strcmp('scissors',label_conversion)==1
    label_conversion=3;
else
    label_conversion=4;
    
end
    
    label_int(jj)=label_conversion;
end



