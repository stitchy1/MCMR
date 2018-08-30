function plotdata(data,a,b,c,d)

%频谱计算
Fs=512;                 %取样频率
L=1506;                 %序列长度
f = Fs*(0:(L/2))/L;
Y=fft(data{a,b}(:,1));  %傅里叶变换
P2 = abs(Y/L);          %双边谱
P1 = P2(1:L/2+1);       
P1(2:end-1) = 2*P1(2:end-1);%单边谱
figure(1);
subplot(2,1,1);
plot(data{a,b}(:,1));
axis([0 1505 -inf inf]);
title(['Raw Data(',num2str(a),',',num2str(b),')']);
xlabel('t/(1/512)s');
ylabel('Amplitude');
subplot(2,1,2);
plot(f,P1);
axis([0 128 1 20]);
title(['Single-Sided Spectrum of Raw Data(',num2str(a),',',num2str(b),')']);
xlabel('f/Hz');
ylabel('Amplitude');

% %卷积验证
% fl=0.5;fh=2.75;
% b=(fh-fl)/2;
% f0=fh-b;A=1;
% clear j;                %sinc函数
% t=-753:753;
% sinc=A*b*sin(pi*t*b)./(pi*t*b).*exp(j*2*pi*f0*t);
% Delta=conv(sinc,data');
% Delta1=Delta(1:1506);
% subplot(2,2,3);
% plot(t,sinc);
% axis([-50 50 -inf inf]);
% title('sinc');
% t=0:1505;
% subplot(2,2,4);
% plot(t,Delta1);
% axis([0 1505 -inf inf]);
% title('Delta');

figure(2)
subplot(4,2,1);
plot(data{a,b}(:,2));
axis([0 1506 -inf inf]);
title(['Delta(',num2str(a),',',num2str(b),')']);
ylabel('Amplitude');
subplot(4,2,2);
plot(data{a,b}(:,3));
axis([0 1506 -inf inf]);
title(['Theta(',num2str(a),',',num2str(b),')']);
ylabel('Amplitude');
subplot(4,2,3);
plot(data{a,b}(:,4));
axis([0 1506 -inf inf]);
title(['Alpha1(',num2str(a),',',num2str(b),')']);
ylabel('Amplitude');
subplot(4,2,4);
plot(data{a,b}(:,5));
axis([0 1506 -inf inf]);
title(['Alpha2(',num2str(a),',',num2str(b),')']);
ylabel('Amplitude');
subplot(4,2,5);
plot(data{a,b}(:,6));
axis([0 1506 -inf inf]);
title(['Beta1(',num2str(a),',',num2str(b),')']);
ylabel('Amplitude');
subplot(4,2,6);
plot(data{a,b}(:,7));
axis([0 1506 -inf inf]);
title(['Beta2(',num2str(a),',',num2str(b),')']);
ylabel('Amplitude');
subplot(4,2,7);
plot(data{a,b}(:,8));
axis([0 1506 -inf inf]);
title(['Gamma1(',num2str(a),',',num2str(b),')']);
ylabel('Amplitude');
subplot(4,2,8);
plot(data{a,b}(:,9));
axis([0 1506 -inf inf]);
title(['Gamma2(',num2str(a),',',num2str(b),')']);
ylabel('Amplitude');

%% 对比图
if (c~=0 && d~=0)
    %频谱计算
    Fs=512;                 %取样频率
    L=1506;                 %序列长度
    f = Fs*(0:(L/2))/L;
    Y=fft(data{c,d}(:,1));            %傅里叶变换
    P2 = abs(Y/L);          %双边谱
    P1 = P2(1:L/2+1);       
    P1(2:end-1) = 2*P1(2:end-1);%单边谱
    figure(3);
    subplot(2,1,1);
    plot(data{c,d}(:,1));
    axis([0 1505 -inf inf]);
    title(['Raw Data(',num2str(c),',',num2str(d),')']);
    xlabel('t/(1/512)s');
    ylabel('Amplitude');
    subplot(2,1,2);
    plot(f,P1);
    axis([0 128 1 20]);
    title(['Single-Sided Spectrum of Raw Data(',num2str(c),',',num2str(d),')']);
    xlabel('f/Hz');
    ylabel('Amplitude');

    figure(4)
    subplot(4,2,1);
    plot(data{c,d}(:,2));
    axis([0 1506 -inf inf]);
    title(['Delta(',num2str(c),',',num2str(d),')']);
    ylabel('Amplitude');
    subplot(4,2,2);
    plot(data{c,d}(:,3));
    axis([0 1506 -inf inf]);
    title(['Theta(',num2str(c),',',num2str(d),')']);
    ylabel('Amplitude');
    subplot(4,2,3);
    plot(data{c,d}(:,4));
    axis([0 1506 -inf inf]);
    title(['Alpha1(',num2str(c),',',num2str(d),')']);
    ylabel('Amplitude');
    subplot(4,2,4);
    plot(data{c,d}(:,5));
    axis([0 1506 -inf inf]);
    title(['Alpha2(',num2str(c),',',num2str(d),')']);
    ylabel('Amplitude');
    subplot(4,2,5);
    plot(data{c,d}(:,6));
    axis([0 1506 -inf inf]);
    title(['Beta1(',num2str(c),',',num2str(d),')']);
    ylabel('Amplitude');
    subplot(4,2,6);
    plot(data{c,d}(:,7));
    axis([0 1506 -inf inf]);
    title(['Beta2(',num2str(c),',',num2str(d),')']);
    ylabel('Amplitude');
    subplot(4,2,7);
    plot(data{c,d}(:,8));
    axis([0 1506 -inf inf]);
    title(['Gamma1(',num2str(c),',',num2str(d),')']);
    ylabel('Amplitude');
    subplot(4,2,8);
    plot(data{c,d}(:,9));
    axis([0 1506 -inf inf]);
    title(['Gamma2(',num2str(c),',',num2str(d),')']);
    ylabel('Amplitude');
end