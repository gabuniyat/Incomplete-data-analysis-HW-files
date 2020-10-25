function [recovery_mean]=disp_descr_stats(databp)

recovery_mean=mean(databp(:,3));
disp('mean recovery time is:');
disp([recovery_mean]);

[semean]=se_mean(databp(:,3));

disp('se of the mean recovery time is:');
disp([semean]);

[corr_log_dose_recovery_time]=pearson_corr(databp(:,1),databp(:,3));
[corr_average_bloodpr_recovery_time]=pearson_corr(databp(:,2),databp(:,3));

disp('Pearson correlation between recovery time and log dose is:');
disp([corr_log_dose_recovery_time]);
disp('Pearson correlation between recovery time and average blood preasure is:');
disp([corr_average_bloodpr_recovery_time]);

end