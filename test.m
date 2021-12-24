I = imread('im1.jpg');
%I = rgb2gray(I);

[rows columns rgb] = size(I);
tamanho = 2;
NovaImagem = zeros(uint16(tamanho*rows), uint16(tamanho*columns), rgb);
[new_rows new_columns new_rgb] = size(NovaImagem);

if tamanho < 1
for i = 1:new_rows
  for j = 1:new_columns
    for k = 1:new_rgb
      NovaImagem(i, j, k) = I(uint16((i-1)*tamanho^(-1)) + 1, uint16((j-1)*tamanho^(-1) + 1), k);
    endfor
  endfor
endfor

else
function v4 = vizinhos(M, linha, coluna, max_rows, max_columns)
  v4 = 0;
  v4 = double(v4);
  nVizinhos = 0;
  if linha < max_rows && M(linha + 1, coluna) > -1
    v4 += double(M(linha + 1, coluna));
    ++nVizinhos;
  endif
  if linha > 1 && M(linha - 1, coluna) > -1
    v4 += double(M(linha - 1, coluna));
    ++nVizinhos;
  endif
  if coluna < max_columns && M(linha, coluna + 1) > -1
    v4+= double(M(linha, coluna + 1));
    ++nVizinhos;
  endif
  if coluna > 1 && M(linha, coluna - 1) > -1
    v4 += double(M(linha, coluna - 1));
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
        NovaImagem(tamanho*(i - 1) + 1, tamanho*(j - 1) + 1, k) = I(i, j, k);
        v = 0;
        v = vizinhos(I, i, j, rows, columns);
        if v > v4_max
          v4_max = v;
        endif
        NovaImagem(tamanho*(i - 1) + 1,  tamanho*(j - 1) + 2, k) = v;
        NovaImagem(tamanho*(i - 1) + 2,  tamanho*(j - 1) + 1, k) = v;
        NovaImagem(tamanho*(i - 1) + 2,  tamanho*(j - 1) + 2, k) = v;
      endfor
    endfor
  endfor

  while ismember(-1 , NovaImagem)
    for i = 1:new_rows
      for j = 1:new_columns
        for k = 1:new_rgb
          if(NovaImagem(i, j, k) == -1)
            v = vizinhos(NovaImagem, i, j, new_rows, new_columns);
            NovaImagem(tamanho*(i - 1) + 1,  tamanho*(j - 1) + 2, k) = v;
            NovaImagem(tamanho*(i - 1) + 2,  tamanho*(j - 1) + 1, k) = v;
            NovaImagem(tamanho*(i - 1) + 2,  tamanho*(j - 1) + 2, k) = v;
          endif
        endfor
      endfor
    endfor
  endwhile
endif

NovaImagem = uint8(NovaImagem);
imshow(NovaImagem);