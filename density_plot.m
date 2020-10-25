function density_plot(Y)

[fy2,xi]=ksdensity(Y);
%figure;
plot(xi,fy2);

end