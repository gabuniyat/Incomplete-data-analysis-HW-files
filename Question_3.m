clear all;
close all;

%%%Generate a complete data set of 500 observations
Nc=3;%Cross-sectional dimension of the data
N=500;%Number of observations
mu=zeros(1,Nc);
Sigm=eye(Nc);
rng('default')
Z = mvnrnd(mu,Sigm,N);

%%Question a
Y1=1+Z(:,1);
Y2=5+2*Z(:,1)+Z(:,2);

figure;
subplot(2,1,1)
density_plot(Y2);
title('Complete');
xlabel('Y_{2}');
ylabel('Frequency');

a=2;
b=0;
[Mc]=missing_criteria(a,b,Y1,Y2,Z(:,3));
inx=find(Mc<0);
Y2_miss=Y2;
Y2_miss(inx)=-9999999999999999999999;
Y2_miss=standardizeMissing(Y2_miss,-9999999999999999999999);

subplot(2,1,2);
density_plot(Y2_miss(~isnan(Y2_miss)));
title('Observed')
xlabel('Y_{2}');
ylabel('Frequency');

%%Question b
Y1_a=Y1;
Y1_a(isnan(Y2_miss))=[];
Y2_a=Y2_miss;
Y2_a(isnan(Y2_miss))=[];
X=[ones(size(Y2_a,1),1) Y1_a];
Y=Y2_a;
b=inv(X'*X)*X'*Y;
err_hat=Y-X*b;
Sigm_hat=(1/(size(Y2_a,1)-2))*sum(err_hat.^2);

err=mvnrnd(0,Sigm_hat,size(Y2,1)-size(Y2_a,1));
Rsq_comp_a=mean((Y-mean(Y)).^2);
Rsq=1-mean(err_hat.^2)/Rsq_comp_a;
disp('R-squared resulting from the regression is:');
disp(Rsq);


Y_hat=[ones(sum(isnan(Y2_miss)),1) Y1(isnan(Y2_miss))]*b+err;
Y2_semp=Y2_miss;
Y2_semp(isnan(Y2_semp))=Y_hat;

figure;
subplot(2,1,1);
density_plot(Y2);
title('Observed')
xlabel('Y_{2}');
ylabel('Frequency');

subplot(2,1,2);
density_plot(Y2_semp);
title('Imputed')
xlabel('Y_{2}');
ylabel('Frequency');

%%Question c
a=0;
b=2;
[Mc]=missing_criteria(a,b,Y1,Y2,Z(:,3));
inx=find(Mc<0);
Y2_miss=Y2;
Y2_miss(inx)=-9999999999999999999999;
Y2_miss=standardizeMissing(Y2_miss,-9999999999999999999999);

figure;
subplot(2,1,1);
density_plot(Y2);
title('Complete');
xlabel('Y_{2}');
ylabel('Frequency');

subplot(2,1,2);
density_plot(Y2_miss(~isnan(Y2_miss)));
title('Observed')
xlabel('Y_{2}');
ylabel('Frequency');

%%Question d
Y1_a=Y1;
Y1_a(isnan(Y2_miss))=[];
Y2_a=Y2_miss;
Y2_a(isnan(Y2_miss))=[];
X=[ones(size(Y2_a,1),1) Y1_a];
Y=Y2_a;
b=inv(X'*X)*X'*Y;
err_hat=Y-X*b;
Sigm_hat=(1/(size(Y2_a,1)-2))*sum(err_hat.^2);

err=mvnrnd(0,Sigm_hat,size(Y2,1)-size(Y2_a,1));
Rsq_comp_a=mean((Y-mean(Y)).^2);
Rsq=1-mean(err_hat.^2)/Rsq_comp_a;
Rsq

Y_hat=[ones(sum(isnan(Y2_miss)),1) Y1(isnan(Y2_miss))]*b+err;
Y2_semp=Y2_miss;
Y2_semp(isnan(Y2_semp))=Y_hat;

figure;
subplot(2,1,1);
density_plot(Y2);
title('Observed')
xlabel('Y_{2}');
ylabel('Frequency');

subplot(2,1,2);
density_plot(Y2_semp);
title('Imputed')
xlabel('Y_{2}');
ylabel('Frequency');


