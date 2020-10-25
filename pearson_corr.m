function [val_e]=pearson_corr(x,y)

val_e=sum((x-mean(x)).*(y-mean(y)))/sqrt(sum((x-mean(x)).^2)*sum((y-mean(y)).^2));

end