%dataset URL http://ufldl.stanford.edu/housenumbers/
%SVHN dataset 中读取bbox->取出图像->抽取HOG特征
% SVHN_data -> name (string)
%           -> feature(struct)->[label, HOG_features,LBP_feature]
% load digitStruct.mat
%加载bbox
for i = 1:length(digitStruct)
    im = imread([digitStruct(i).name]);
    SVHN_data(i).name=digitStruct(i).name;
    %save name
    for j = 1:length(digitStruct(i).bbox)
        [height, width] = size(im);
        x_min = max(digitStruct(i).bbox(j).top+1,1);
        x_max = min(digitStruct(i).bbox(j).top+digitStruct(i).bbox(j).height, height);
        y_min = max(digitStruct(i).bbox(j).left+1,1);
        y_max = min(digitStruct(i).bbox(j).left+digitStruct(i).bbox(j).width, width);
        
        tmp_image=im(x_min:x_max, y_min:y_max, :);
        %取出instance
        SVHN_data(i).feature(j).label=digitStruct(i).bbox(j).label;
        %save label
        
        SVHN_data(i).feature(j).HOG_feature=extractHOGFeatures(imresize(tmp_image,[64,64]));
        %save HOG_feature
        SVHN_data(i).feature(j).LBP_feature=extractLBPFeatures(rgb2gray(imresize(tmp_image,[64,64])));
        %save LBP_feature
        
%         imshow(tmp_image);
        disp(strcat(num2str(i),'-th:',num2str(j)));
    end
end