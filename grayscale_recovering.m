%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   LSB 3-bit GRAY-SCALE STEGANOGRAPHY (Recovering)

%   Author                   Usman Iqbal
%   Email                    usmaniqbal0001@gmail.com
%   Contact                  +923355251592
%   Last Modified            July 27, 2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%% Getting the input image
disp('Provide the image...')
[img_file, img_path] = uigetfile({'*.png'});
img = imread([img_path,img_file]);

%% Recovering the concealed image
disp('Recovering the concealed image')
recovered_img = img;
[r,c] = size(img);
for i=1:r
    for j=1:c
        recovered_img(i,j) = bitshift(img(i,j),5);
    end
end

imwrite(recovered_img,'recovered.png');
disp('Done')