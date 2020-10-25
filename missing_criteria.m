function [Mc]=missing_criteria(a,b,Y1,Y2,Z3)

%Generate a criteria for missingness depending on the parameters a and b

Mc=a*(Y1-1)+b*(Y2-5)+Z3;


end