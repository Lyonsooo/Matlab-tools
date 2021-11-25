% Bag_ID, file_name, Instance_id, Instance_label, x_min, x_max, y_min, y_max 
%      1, 05.jpg,     1,           airplane,       89,   89,      98,  98
%      1, 05.jpg,     2,           person,         98,   98,      89,  89
%      1, 05.jpg,     2,           person,         11,   22,      33,  44
Path='VOC2007/Annotations/';
File = dir(fullfile(Path,'*.xml'));
FileNames = {File.name}'; 
Bag=[];
for i=1:length(FileNames)
%     xmlDoc = xmlread('VOC2007/Annotations/000005.xml');
    xmlDoc=xmlread(strcat('VOC2007/Annotations/',FileNames{i}));
    %获取filename
    file_name = xmlDoc.getElementsByTagName('filename');
    name = string(file_name.item(0).getTextContent());
    %获取xmin
    x_min=xmlDoc.getElementsByTagName('xmin');
    instance_num=x_min.getLength;
    X_min=[];
    for j = 1 : x_min.getLength    
        X_min(j,:)= string(x_min.item(j-1).getFirstChild.getData);
    end
    %x_max
    x_max=xmlDoc.getElementsByTagName('xmax');
    X_max=[];
    for j = 1 : x_max.getLength    
        X_max(j,:)= string(x_max.item(j-1).getFirstChild.getData); 
    end
    %y_min
    y_min=xmlDoc.getElementsByTagName('ymin');
    Y_min=[];
    for j = 1 : y_min.getLength    
        Y_min(j,:)= string(y_min.item(j-1).getFirstChild.getData); 
    end
    %y_max
     y_max=xmlDoc.getElementsByTagName('ymax');
     Y_max=[];
    for j = 1 : y_max.getLength    
      Y_max(j,:)= string(y_max.item(j-1).getFirstChild.getData); 
    end
    %label
    instance_label=xmlDoc.getElementsByTagName('name');
    Instance_label=[];
    for j = 1 : instance_label.getLength-1   
        tmp_instance_label= char(instance_label.item(j).getFirstChild.getData);
        Instance_label=[Instance_label;string(tmp_instance_label)];
    end
    
    Bag_id=repmat(i,instance_num,1);
    File_name=repmat(name,instance_num,1);
    Instance_id=1:1:instance_num;
    tmp_Bag=[num2str(Bag_id),File_name,num2str(Instance_id'),Instance_label,num2str(X_min),num2str(X_max),num2str(Y_min),num2str(Y_max)];
    Bag=[Bag;tmp_Bag];
    disp(name);
end





