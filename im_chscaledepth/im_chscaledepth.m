1;

function ret = im_chscaledepth(img, bits, tamanho)

  %%%%%%%%%%%%%%%%% Parte 1 %%%%%%%%%%%%%%%%%%%%%

  img
  I = imread(img);

  % Criando array onde cada posicao representa o nivel de cor do pixel original e seu valor sera o novo nivel de cor do pixel.
  if(bits != 8)
    niveis = [1:256];
    valoresIguais = 2^(8 - bits);  %quantas vezes cada valor ira se repetir
    intervalo = 255/((2^bits) - 1); %Intervalo entre os diferente niveis de brilho
    nIntervalos = 0; %contando em qual intervalo estamos comparando
    nValoresIguais = 0; %contando quantas vezes ja repetimos cada valor

    for i = 1:256
      niveis(i) = round(nIntervalos*intervalo);
      nValoresIguais += 1;
      if nValoresIguais == valoresIguais
        nValoresIguais = 0;
        nIntervalos += 1;
      endif
    endfor

    if ndims(I) == 2
      [rows columns] = size(I);

      for i = 1:rows
        for j = 1:columns
          I(i,j) = niveis(I(i,j) + 1); %passando o nivel de brilho de X como posicao para o array 'niveis' retornando o valor que esse nivel de brilho ira assumir para a quantidade de n bits
        endfor
      endfor

    elseif ndims(I) == 3
      [rows columns rgb] = size(I);
      for i = 1:rows
        for j = 1:columns
          for k = 1:rgb
            I(i,j,k) = niveis(I(i,j,k) + 1); %passando o nivel de brilho de X como posicao para o array 'niveis' retornando o valor que esse nivel de brilho ira assumir para a quantidade de n bits
          endfor
        endfor
      endfor
    endif
  endif

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parte 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


  [rows columns rgb] = size(I);
  NovaImagem = zeros(uint16(round(tamanho*rows)), uint16(round(tamanho*columns)), rgb);
  [new_rows new_columns new_rgb] = size(NovaImagem);

  if tamanho < 1
    for i = 1:new_rows
      for j = 1:new_columns
        for k = 1:new_rgb
          NovaImagem(i, j, k) = I(uint16((i-1)*tamanho^(-1)) + 1, uint16((j-1)*tamanho^(-1) + 1), k);
        endfor
      endfor
    endfor

  elseif tamanho > 1
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
  endif
  NovaImagem = uint8(NovaImagem);
  imshow(NovaImagem);
endfunction

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