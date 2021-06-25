opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (3:5);
data1 = readmatrix('Real estate valuation data set.xlsx',opts); %membaca file Real estate valuation data set.xlsx pada kolom 3-5

opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (8);
data2 = readmatrix('Real estate valuation data set.xlsx',opts);%membaca file Real estate valuation data set.xlsx pada kolom 8

data = [data1 data2]; %menggabungkan matriks data1 & data2 menjadi satu dengan nama data
data=data(1:50,:); %mengambil data matriks data hingga baris ke 50


x = data;%data kriteria
k = [0,0,1,0];%atribut tiap kriteria, nilai 0 = atribut biaya, 1 = atrribut keuntungan
w = [3,5,4,1];%Nilai bobot tiap kriteria 

%tahapan pertama, perbaikan bobot
[m n]=size (x); %membuat matriks m x n sesuai dengan ukuran x
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);%jika bobot kriteria biaya(0) maka akan dijadikan negatif
    end;
end;
for i=1:m,
    S(i)=prod(x(i,:).^w); %menentukan nilai vektor S dilakukan dengan mengalikan seluruh kriteria
end;

%tahapan ketiga, proses perangkingan
V= S/sum(S); %membagi nilai S(i) dengan total seluruh nilai S

Vtranspose=V.'; %mentransposekan v
opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (1);
alternatif= readmatrix('Real estate valuation data set.xlsx',opts);%membaca file Real estate valuation data set.xlsx pada kolom 1
alternatif=alternatif(1:50,:); %mengambil data matriks alternatif hingga baris ke 50
alternatif=[alternatif Vtranspose]; %menjadikan matriks alternatif dan Vtranspose menjadi 1 matriks
alternatif=sortrows(alternatif,-2); %mengurutkan matriks berdasarkan nilai kolom ke 2 dari yang tertinggi ke terendah
alternatif = alternatif(1:5,1); %menampilkan matriks alternatif dari baris ke 1-5 pada kolom ke 1

disp ('Nomor Real Estate yang paling direkomendasikan =') 
disp (alternatif)%menampilkan matriks alternatif