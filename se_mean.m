function [val_e]=se_mean(x)

n=length(x);
s_sq=(1/(n-1))*sum((x-mean(x)).^2);

val_e=sqrt(s_sq)/sqrt(n);

end