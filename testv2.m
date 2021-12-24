clear all;
close all;
clc;

I = imread('im1.jpg');
%I = rgb2gray(I);

[rows columns rgb] = size(I);
tamanho = 1.75;
NovaImagem = zeros(uint16(round(tamanho*rows)), uint16(round(tamanho*columns)), rgb);
[new_rows new_columns new_rgb] = size(NovaImagem);

function v4 = vizinhos(M, linha, coluna, rgb, max_rows, max_columns)
  v4 = 0;
  v4 = double(v4);
  nVizinhos = 0;
  if linha < max_rows && M(linha + 1, coluna, rgb) != -1
    v4 += double(M(linha + 1, coluna, rgb));
    ++nVizinhos;
  endif
  if linha > 1 && M(linha - 1, coluna, rgb) > -1
    v4 += double(M(linha - 1, coluna, rgb));
    ++nVizinhos;
  endif
  if coluna < max_columns && M(linha, coluna + 1, rgb) > -1
    v4+= double(M(linha, coluna + 1, rgb));
    ++nVizinhos;
  endif
  if coluna > 1 && M(linha, coluna - 1, rgb) > -1
    v4 += double(M(linha, coluna - 1, rgb));
    ++nVizinhos;
  endif
  if nVizinhos != 0
    v4 /= nVizinhos;
    v4 = round(v4);
  else
    v4 = -1;
  endif
endfunction 

NovaImagem .-= 1;

for i = 1:rows
    for j = 1:columns
        for k = 1:rgb
            NovaImagem(round(tamanho*(i - 1) + 1), round(tamanho*(j - 1) + 1), k) = I(i, j, k);
        endfor
    endfor
endfor

repetir = 1;
while(repetir)
repetir = 0;
    for i = 1:new_rows
        for j = 1:new_columns
            for k = 1:new_rgb
                if NovaImagem(i, j, k) == -1
                    v4 = vizinhos(NovaImagem, i, j, k, new_rows, new_columns);
                    NovaImagem(i, j, k) = v4;
                    if NovaImagem(i,j, k) == -1
                        repetir = 1
                    endif
                endif
            endfor
        endfor
    endfor
endwhile

NovaImagem = uint8(NovaImagem);
imshow(NovaImagem);