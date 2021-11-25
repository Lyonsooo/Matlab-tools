% img = imread('UTKFace\1_0_0_20161219140623097.jpg.chip.jpg');
Path = 'UTKFace'; 
File = dir(fullfile(Path,'*.jpg'));
FileNames = {File.name}'; 
[m,~]=size(FileNames);
HOG_feature=[];
LBP_feature=[];
idx=FileNames;
for i=1:m
    img=imread(strcat(Path,'/',FileNames{i}));
    img_rgb=imresize(img,[128,128]);
    [HOG_featureVector,hogVisualization] = extractHOGFeatures(img_rgb);
    gray_img=rgb2gray(img_rgb);
    LBP_featureVector = extractLBPFeatures(gray_img);
    HOG_feature=[HOG_feature;HOG_featureVector];
    LBP_feature=[LBP_feature;LBP_featureVector];
    disp(i);
end
save idx idx;
save HOG_feature HOG_feature;
save LBP_feature LBP_feature;
