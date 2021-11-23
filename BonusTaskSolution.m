%% Known Info
tn = 10;        % RH edge
t0 = 0;         % LH edge
a = .5;         % Grid point spacing

%% Setup Linear System
t = t0:a:tn;                % Vector of grid points
A = zeros(length(t));       % Empty matrix of coefficeints
b = zeros(length(t), 1);    % Empty vector of RH side of equations

% Build in a loop
for i = 1 : length(t)
   if i == 1
       A(i, i + 1) = 1 / a;
       b(i) = 85 / a - 32;
   elseif i == length(t)
       A(i, i) = (0.5 + 1 / a);
       A(i, i - 1) = - 1 / a;
       b(i) = 10.5;
   else
       A(i, i + 1) = 1 / (2 * a);
       A(i, i) = 0.5;
       A(i, i - 1) = - 1 / (2 * a);
       b(i) = 10.5;
       
   end
end

%% Solve Linear System
T = A \ b;

%% Plot
t_an = linspace(0, 10, 100);
T_an = 21 + 64 * exp(-0.5 * t_an);
plot(t_an, T_an, '-', t, T, '-x', 'linewidth', 2, 'markersize', 10);
xlabel('Time (mins)');
ylabel('Temperature (deg C)');
legend('Exact', ['Finite Difference a = ' num2str(a)])
set(gca, 'FontName', 'Times', 'FontSize', 14);