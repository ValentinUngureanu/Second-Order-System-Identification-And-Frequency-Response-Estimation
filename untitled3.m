data = readmatrix('scope_53.csv', 'NumHeaderLines', 2);

t = data(:, 1);
u = data(:, 2);
y_s = data(:, 3);
y_z = data(:, 4);

dt = t(2) - t(1); % perioada de esantionare

%% autocorr
% Identificarea sistemului fara zero 
dy = iddata(y_s, u, dt);
Marmx = armax(dy, [2, 3, 2, 0]);
figure;
compare(dy, Marmx);
figure
resid(dy, Marmx,'corr'), shg;

[Ns, Ds] = tfdata(Marmx, 'v');
H_z = tf(Ns, Ds, dt, 'Variable', 'z^-1');
Hc = d2c(Hz, 'zoh')

%%
% Identificarea sistemului cu zero
dyz = iddata(y_z, u, dt);
Marmx_yz = armax(dyz, [2, 3, 3, 0]);
figure;
compare(dyz, Marmx_yz);
figure;
resid(dyz, Marmx_yz, 'corr'), shg;
[Ns, Ds] = tfdata(Marmx, 'v');
H_z = tf(Ns, Ds, dt, 'Variable', 'z^-1')
Hc = d2c(Hz, 'zoh')
%% xcorr
% Identificarea sistemului fara zero

% EO
dy = iddata(y_s, u, dt);
Moe = oe(dy, [3, 2, 0]);
figure;
compare(dy, Moe);
figure;
resid(dy, Moe), shg;
[Ns, Ds] = tfdata(Moe, 'v');
Hz = tf(Ns, Ds, dt, 'Variable', 'z^-1')
Hc = d2c(Hz, 'zoh')

%%
% Identificarea sistemului cu zero
dyz = iddata(y_z, u, dt);
Moe = oe(dyz, [3, 2, 0]);

figure;
compare(dyz,Moe)
figure
resid(dyz, Moe), shg;
[Ns, Ds] = tfdata(Moe, 'v');
Hz = tf(Ns, Ds, dt, 'Variable', 'z^-1')
Hc = d2c(Hz, 'zoh')