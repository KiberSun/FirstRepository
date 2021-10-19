// Крытьев      21-ИВТ-1 
// Лабораторная работа №2 
// Вариант 12
// 
// Техническое задание 1:
// Вывести индексы строк с наибольшей суммой элементов. Признаком конца ввода строки является 0.
//
// Техническое задание 2:
// Вывести из символьной матрицы уникальные столбцы.

type Matrix = array of array of integer;
     CharMatrix = array of array of char;

procedure SetMatrixLength(var a : Matrix);
var str : string;
    i, num, err: integer;
begin
    while true do begin
      err := 0; num := 0;
      write('Количество строк в матрице: ');
      readln(str);
      val(str, num, err);
      if (err = 0) and (num > 0) then break;
      if (err <> 0) then writeln('Количество строк должно быть числом');
      if (num <= 0) and (err = 0) then writeln('Количество строк должно быть больше нуля');
      writeln();
      end;
    SetLength(a, num);
    for i := 0 to high(a) do 
      SetLength(a[i], 0);
    writeln();
end;


procedure PrintMatrix(const a : Matrix);
var i, j : integer;
begin
    writeln();
    writeln('Матрица:');
    for i := 0 to high(a) do begin
      write(i : IntToStr(high(a)).Length);
      write(':  ');
      for j := 0 to high(a[i]) do write(a[i][j], ' ');
      writeln();
      end;
    writeln();
end;

procedure ReadMatrix(var a : Matrix);
var i, j, num, err :integer;
    str : string;
    nums : array of string;
begin
    writeln('Задайте элементы матрицы: ');
    writeln('Признаком конца строки является ввод нуля');
    i := 0;
    while i <= high(a) do begin
//      PrintMatrix(a);
      readln(str);
      nums := str.Split(' ');
      for j := 0 to high(nums) do begin
        if (i > high(a)) then break;
        val(nums[j], num, err);
        if (err <> 0) then writeln('элемент ', nums[j], ' был проигнорирован')
        else if (num = 0) then inc(i)
        else begin
          SetLength(a[i], Length(a[i]) + 1);
          a[i][high(a[i])] := num;
          end;
        end;
      end;
end;


function GetStringsWithHighestSumm(const a : Matrix) : array of integer;
var Indexes : array of integer;
    i, j, summ, max : integer;
begin
    max := integer.MinValue;
    for i := 0 to high(a) do begin
      summ := 0;
      for j := 0 to high(a[i]) do begin
        summ += a[i][j];
        end;
      if (summ = max) then begin
                        SetLength(Indexes, Length(Indexes) + 1);
                        Indexes[high(Indexes)] := i;
                        end;
      if (summ > max) then begin
                        max := summ;
                        SetLength(Indexes, 1);
                        Indexes[0] := i;
                        end;
      end;
    GetStringsWithHighestSumm := Indexes;
end;

procedure PrintArr(a : array of integer);
var i : integer;
begin
    for i := 0 to high(a) do
      write(a[i], ' ');
end;

procedure task1();
var a : Matrix;
begin
  SetMatrixLength(a);
  ReadMatrix(a);
  PrintMatrix(a);
  writeln('Индексы строк с максимальной суммой элементов:');
  PrintArr(GetStringsWithHighestSumm(a));
end;

procedure SetCharMatrixSize(var a : CharMatrix);
var str : string;
    i, num, err: integer;
begin
    while true do begin
      err := 0; num := 0;
      write('Количество строк в матрице: ');
      readln(str);
      val(str, num, err);
      if (err = 0) and (num > 0) then break;
      if (err <> 0) then writeln('Количество строк должно быть числом');
      if (num <= 0) and (err = 0) then writeln('Количество строк должно быть больше нуля');
      writeln();
      end;
    SetLength(a, num);
    while true do begin
      err := 0; num := 0;
      write('Количество столбцов в матрице: ');
      readln(str);
      val(str, num, err);
      if (err = 0) and (num > 0) then break;
      if (err <> 0) then writeln('Количество столбцов должно быть числом');
      if (num <= 0) and (err = 0) then writeln('Количество столбцов должно быть больше нуля');
      writeln();
      end;
    for i := 0 to high(a) do 
      SetLength(a[i], num);
    writeln();
end;

procedure PrintCharMatrix (var a : CharMatrix);
var i, j : integer;
begin
  for i := 0 to high(a) do begin
    for j := 0 to high(a[i]) do begin
      write(a[i][j]);
      end;
      writeln();
    end;
  writeln();
end;


procedure ReadCharMatrix(var a : CharMatrix);
var i, j : integer;
    c : char;
begin
    for i := 0 to high(a) do begin
      j := 0;
      while j <= high(a[i]) do begin
         read(c);
         if (ord(c) > 20) then begin
                             a[i][j] := c;
                             inc(j);
                             end
                           else begin
                             writeln();
                             PrintCharMatrix(a);
                             writeln();
                             end;
        end;
     end;
end;

function fond(x : integer; arr : array of integer) : boolean;
var i : integer;
    f : boolean;
begin
    f := false;
    for i := 0 to high(arr) do if (arr[i] = x) then f := true;
    fond := f;
end;

procedure PrintDifferentColumns(const a : CharMatrix);
var i, j, l : integer;
      indexes : array of integer;
      c : char;
      unical, similar : boolean;
begin
  writeln('Результат: ');
  setlength(indexes, 0);
  for j := 0 to high(a[0]) do begin
    unical := true;
    for l := 0 to high(a[0]) do begin
      similar := true;
      for i := 0 to high(a) do begin
        if (l <> j) and (a[i][j] <> a[i][l]) then similar := false;
        end;
        unical := unical and not (similar and (l <> j));
      end;
    if unical then begin
                 setlength(indexes, length(indexes) + 1);
                 indexes[high(indexes)] := j;
                 end;
    end;
  for i := 0 to high(a) do begin
    for j := 0 to high(a[i]) do begin
      if fond(j, indexes) then write(a[i][j]);
      end;
    writeln();
    end;
end;


procedure task2();
var a : CharMatrix;
begin
  SetCharMatrixSize(a);
  ReadCharMatrix(a);
  writeln();
  writeln('Ваша матрица:');
  PrintCharMatrix(a);
  PrintDifferentColumns(a);
end;


var task : integer;
begin
  while true do begin
    try 
      write('Выберите задание: ');
      readln(task);
      case task of 
        1: begin task1(); break; end;
        2: begin task2(); break; end;
        else writeln('Номер задания может быть только 1 или 2');
        end;
    except
      writeln('Номер задания может быть только 1 или 2')
    end;
    end;
end.
