clear all;
close all;

load databp

databp=databp(:,3:end);

%Question a
disp('missing in the logdose');
disp([sum(isnan(databp(:,1)))]);
disp('missing in the bloodp');
disp([sum(isnan(databp(:,2)))]);
disp('missing in recover time');
disp([sum(isnan(databp(:,3)))]);

inx=find(~isnan(databp(:,3)));

databp_complete_case=databp;
databp_complete_case=databp_complete_case(inx,:);

disp('Complete case analysis');
recovery_mean=disp_descr_stats(databp_complete_case);

%Question b
databp_mean_imputation=databp;
databp_mean_imputation(isnan(databp_mean_imputation(:,3)),3)=recovery_mean;
disp('Mean imputation');
disp_descr_stats(databp_mean_imputation);

%Question c
X=[ones(size(databp_complete_case,1),1) databp_complete_case(:,[1:2])];
Y=databp_complete_case(:,3);
b=inv(X'*X)*X'*Y;

err_hat=Y-X*b;
Sigm_hat=(1/(size(Y,1)-3))*sum(err_hat.^2);

Y_hat=[ones(sum(isnan(databp(:,3))),1) databp((isnan(databp(:,3))),1:2)]*b;
databp_conmean_imputation=databp;
databp_conmean_imputation(isnan(databp_conmean_imputation(:,3)),3)=Y_hat;
disp('Condintional mean imputation');
disp_descr_stats(databp_conmean_imputation);

%Question d
err=mvnrnd(0,Sigm_hat,size(databp,1)-size(Y,1));
Y_hat_sr=Y_hat+err;
databp_sregression_imputation=databp;
databp_sregression_imputation(isnan(databp_sregression_imputation(:,3)),3)=Y_hat_sr;
disp('Stochastic regression imputation');
disp_descr_stats(databp_sregression_imputation);

%Question e
inx_nan=find(isnan(databp(:,3)));
Y_hat_pmm_a=[ones(size(databp,1),1) databp(:,1:2)]*b;

Y_hat_pmm=zeros(length(inx_nan),1);
for i=1:length(inx_nan)
diff=Y_hat_pmm_a-Y_hat_pmm_a(inx_nan(i));
diff(inx_nan)=[];
Y_hat_red=databp(:,3);
Y_hat_red(inx_nan)=[];
inx_min=find(abs(diff)==min(abs(diff)));
inx_min=inx_min(1);
Y_hat_pmm(i)=Y_hat_red(inx_min);
end

databp_predictive_mean_matching=databp;
databp_predictive_mean_matching(isnan(databp_predictive_mean_matching(:,3)),3)=Y_hat_pmm;
disp('Predictive mean matching');
disp_descr_stats(databp_predictive_mean_matching);
