function [ ans ] = ifequal( x,y,eps )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
return sum(sum(abs(x-y)>eps))==0;
    
end

