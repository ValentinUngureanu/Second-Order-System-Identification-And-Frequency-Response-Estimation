data=readmatrix('scope_53.csv','NumHeaderLines',2);
%prelucrara valorilor pentru t,u,y_s si y_z 
t=data(:,1);
u=data(:,2);
y_s=data(:,3);
y_z=data(:,4);

plot(t,[u y_s])
%%
% identificarea sistemului fara zero
% plot(t, [u y]);

% Mr = raport de amplitudini (= 1.2742)
% Mr = ((max(y) - min(y)) / 2) / ((max(u) - min(u)) / 2);
Mr = (max(y_s) - min(y_s)) / (max(u) - min(u));
% 4 * zeta^4 - 4 * zeta^2 + 1/Mr = 0;
rad = roots([4 0 -4 0 1/Mr^2]);
zeta = 0.4201;
Trez = 2.4000e-04; % 0.00024
frez = 1 / Trez;
wr = 2*pi * frez;
wn = wr / sqrt(1 - 2*zeta^2)
K = mean(y_s) / mean(u)
H = tf(K*wn^2, [1 2*zeta*wn wn^2])

figure;
bode(H);
%calculul pulsatiilor

w1=pi/(t(93)-t(78));
M1=(y_s(94)-y_s(81))/(u(93)-u(78));
Ph1 = w1 * (t(93)-t(94))*180/pi;

w2=pi/(t(131)-t(118));
M2=(y_s(132)-y_s(119))/(u(131)-u(118));
Ph2 = w2 * (t(131)-t(132))*180/pi;

w3=pi/(t(141)-t(131));
M3=(y_s(143)-y_s(132))/(u(141)-u(131));
Ph3 = w3 * (t(141)-t(142))*180/pi;

w4=pi/(t(227)-t(218));
M4=(y_s(228)-y_s(220))/(u(227)-u(218));
Ph4 = w4 * (t(227) - t(228))*180/pi;

w5=pi/(t(235)-t(227));
M5=(y_s(237)-y_s(228))/(u(235)-u(227));
Ph5 = w5 * (t(235) - t(236))*180/pi;

wr=pi/(t(364)-t(358));
Mr=(y_s(366)-y_s(360))/(u(364)-u(358));
Phr=wr*(t(364)-t(366))*180/pi;


w7=pi/(t(479)-t(474));
M7=(y_s(481)-y_s(477))/(u(479)-u(474));
Ph7 = w7 * (t(479) - t(481))*180/pi;

w8=pi/(t(546)-t(542));
M8=(y_s(548)-y_s(543))/(u(546)-u(542));
Ph8 = w8 * (t(546) - t(548))*180/pi;

w9=pi/(t(694)-t(691));
M9=(y_s(696)-y_s(692))/(u(694)-u(691));
Ph9 = w9 * (t(694) - t(696))*180/pi;

w10=pi/(t(986)-t(984));
M10=(y_s(989)-y_s(985))/(u(986)-u(984));
Ph10 = w10 * (t(986) - t(988))*180/pi;



Mtot=[M1,M2,M3,M4,M5,Mr,M7,M8,M9,M10];
wtot=[w1,w2,w3,w4,w5,wr,w7,w8,w9,w10];
Phtot=[Ph1,Ph2,Ph3,Ph4,Ph5,Phr,Ph7,Ph8,Ph9,Ph10];
w = logspace(4, 5.1);
Ns = H.Numerator;
Ds = H.Denominator;
[M, Ph] = bode(Ns, Ds, w);
subplot(211);
semilogx(wtot, 20*log10(Mtot), 'x', w, 20*log10(M)), grid, shg;

subplot(212);
semilogx(wtot, Phtot, 'x', w, Ph), grid, shg;




