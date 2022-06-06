
function main
clear all;clc;
%the main function calling the optimizer
global A trn vald;
%A=load('zoo.dat');

A=load('IslamDataSetNoUrea.csv');
r=randperm(size(A,1));
trn=r(1:floor(length(r)/2));
vald=r(floor(length(r)/2)+1:end);
[Alpha_score,Alpha_pos]=ASMAQI_BGWO(50,size(A,2)-1,2)