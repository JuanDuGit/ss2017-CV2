function [summation] = addprimes3(s,e)
    a = s:e;
    summation = sum(isprime(a).*a);
end