clear all;
close all;
clc;

% Quantidade de n?veis de cinza
L = 256;

% N?vel de cinza original
r = 0:L-1;

% Identidade
s = r;

plot(r,s);
hold on
xlabel('r');
ylabel('s = T(r)');
axis([0 255 0 255])
grid on

% Negativo
s = L-1-r;
plot(r,s,'r');

% Log
s = log10(1+r);
s2 = 255*(s/max(s));
plot(r,s2,'r--');
hold on

% Log inverso
s2 = (10).^s -1
s2 = 255*(s2/max(s2));
plot(255*(s/max(s)),s2,'--');

% Pot?ncia
gama = 2
s = (r.^gama)
s = 255*s/max(s)
plot(r,s,'--');

% Raiz
s = sqrt(r)
s = 255*s/max(s)
plot(r,s,'r--');


pause;

I = imread('im1.jpg');

%histograma da Imagem usando IMHIST
imhist(I,10);pause;
imhist(I,50);pause;
imhist(I); pause;
[COUNTS,X] = imhist(I);

%historgrama da Imagem usando HISt
hist(double(I(:)));pause;
hist(double(I(:)),50);pause;
hist(double(I(:)),256);
[n,x] = hist(double(I(:)));
[n2,x2] = hist(double(I(:)),[0:255]);