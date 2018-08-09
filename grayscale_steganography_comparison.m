%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   LSB GRAYSCALE STEGANOGRAPHY (Comparison)

%   Author                   Usman Iqbal
%   Email                    usmaniqbal0001@gmail.com
%   Contact                  +923355251592
%   Last Modified            July 30, 2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%% Getting the input images
disp('Provide the main image...')
[img_file1, img_path1] = uigetfile({'*.png';'*.jpg'});
img1 = imread([img_path1,img_file1]);
disp('Provide the image to be concealed...')
[img_file2, img_path2] = uigetfile({'*.png';'*.jpg'});
img2 = imread([img_path2,img_file2]);
tic;

%% Conditioning of images
%checking for coloured images
if length(size(img1))==3
    img1 = rgb2gray(img1);
end
if length(size(img2))==3
    img2 = rgb2gray(img2);
end

%checking for unequal sizes of both images
[r1,c1,l1] = size(img1);
[r2,c2,l2] = size(img2);
r = min(r1,r2);
c = min(c1,c2);
img1 = imresize(img1,[r c]);
img2 = imresize(img2,[r c]);

%% Main Function
for n=1:7
    %performing steganography
    fprintf('\nPerforming %d-bit LSB steganography...\n',n);
    values = [254, 252, 248, 240, 224, 192, 128];
    final_img = img1;
    for i=1:r
        for j=1:c
            num1 = bitand(img1(i,j),values(n));
            num2 = bitshift(img2(i,j),n-8);
            final_img(i,j) = bitor(num1,num2);
        end
    end

    %recovering the concealed image
    fprintf('Recovering the image from %d-bit LSB steganography...\n',n);
    recovered_img = final_img;
    for i=1:r
        for j=1:c
            recovered_img(i,j) = bitshift(final_img(i,j),8-n);
        end
    end
    
    %comparison\correlation
    one(1,n) = corr2(img1, final_img);
    two(1,n) = corr2(img2, recovered_img);
end

%% Plotting
%plotting the correlation values
plot(1:7,one,'-x',1:7,two,'-x','LineWidth',2)
xlabel('Steganography Type (bits)')
ylabel('Correlation with Original Image')
title('COMPARISON GRAPH')
ylim([0.7 1.05])
legend({'Main Image Correlation','Concealed Image Correlation'},'Location','southwest')
fprintf('\n\n');
toc;

disp('Done')