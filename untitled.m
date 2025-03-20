data=readmatrix('scope_53.csv','NumHeaderLines',2);
%prelucrara valorilor pentru t,u,y si w 
t=data(:,1);
u=data(:,2);
y_s=data(:,3);
y_z=data(:,4);
%reprezentarea grafica a semanalelor 
plot(t,[u,y_s+3,y_z+6]);
xlabel('time[s]');
ylabel('volti');
legend('u - semanlul de intrare','y_s - raspunsul sistemului de ordin 2 fara zero','y_z - raspunsul sistemului de ordin 2 cu zero');
%% Identificarea sistemului fara zero
figure
plot(t,y_s);
figure;
%Mr=1.3115;
max(y_s);
min(y_s);
max(u);
min(u);
Mr = ((max(y_s)-min(y_s))/2)/((max(u)-min(u))/2);
%4*zeta^2*(1-zeta^2)-1/Mr^2=0
x=roots([-4,0,4,0,-1/Mr^2]);
zeta=min(x(x>0)); %se alege valoarea intre 0 si sqrt(2)/2
T_rez=t(360)-t(348);
f_rez=1/T_rez;
wr = 2*pi * f_rez;
wn=wr/(sqrt(1-2*zeta^2));
K=mean(y_s)/mean(u);
H_s=tf(K*wn^2,[1 2*zeta*wn wn^2]);
x=[1 2*zeta*wn wn^2];
A=[0 1; -wn^2 -2*zeta*wn];
B=[0; K*wn^2];
C=[1 0];
D=0;
%[A,B,C,D] = tf2ss(K*wn^2,[1 2*zeta*wn wn^2]);
[y_s_sim,~,~] = lsim(ss(A,B,C,D),u,t,[y_s(1),(y_s(2)-y_s(1))/(t(2)-t(1))]);
figure;
plot(t,u,t,y_s)
legend('u - semanlul de intrare','y - raspunsul sistemului de ordin 2 fara zero');
figure
plot(t,[y_s,y_s_sim]);
legend('y - raspunsul sistemului de ordin 2 fara zero','y-simulat/calculat');
errmp = norm(y_s - y_s_sim)/sqrt(length(y_s));
errmpn = norm(y_s-y_s_sim)/norm(y_s-mean(y_s));
bode(H_s);
