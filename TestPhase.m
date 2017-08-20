clc;
clear all;
close all;


input = '../../Notes_Images/Database/rupee_500_1_';
inputFront = imread(strcat(input,'front_norm.jpg'));
imshow(inputFront);
inputBack = imread(strcat(input,'back_norm.jpg'));
figure();
imshow(inputBack);

Classification(inputFront, inputBack)

