using CSV
using DataFrames

dataBitcoin = CSV.read("Bitcoin01.csv",DataFrame);
dataBitcoin.Último .= replace.(dataBitcoin.Último, "," => "");
dataBitcoin.ÚltimoFloat = parse.(Float64, dataBitcoin.Último);
dataBitcoin.ÚltimoFloat = dataBitcoin.ÚltimoFloat.*1000;
dataBitcoin.ÚltimoFloat = reverse(dataBitcoin.ÚltimoFloat);

using Plots
plot(dataBitcoin.ÚltimoFloat, st = :scatter, label = "Bitcoin")
#plot!(dataBitcoin.ÚltimoFloat)

N = size(dataBitcoin.ÚltimoFloat,1);
A = Array((1:N));
b = Array(dataBitcoin.ÚltimoFloat);
A = [ones(N,1) A A.^2 A.^3 A.^4 A.^5];
#println("A = ", A)
#println(" ")
#println("b = ", b)

using Plots

function f(x,y) 
    sum((A[:,1]*x+A[:,2]*y-b)*transpose((A[:,1]*x+A[:,2]*y-b)))
end
plotlyjs()
surface(-50000:1000:50000,-10000:100:15000, f)

using LinearAlgebra
qrA = qr(A);
xhat = qrA\b

pred = xhat[6].*A[:,2].^5 + xhat[5].*A[:,2].^4 + xhat[4].*A[:,2].^3 + xhat[3].*A[:,2].^2 + xhat[2]*A[:,2] + xhat[1]*ones(N,1)
plot(A[:,2],pred, label = "Predicción Bitcoin")
plot!(dataBitcoin.ÚltimoFloat, st = :scatter, label = "Bitcoin")

g(x) = xhat[6].*x.^5 + xhat[5].*x.^4 + xhat[4].*x.^3 + xhat[3].*x.^2 + xhat[2]*x + xhat[1];

prediccion = [g(75), g(76), g(77), g(78), g(79), g(80), g(81)]

dataBitcoin02 = CSV.read("Bitcoin02.csv",DataFrame);
dataBitcoin02.Último .= replace.(dataBitcoin02.Último, "," => "");
dataBitcoin02.ÚltimoFloat = parse.(Float64, dataBitcoin02.Último);
dataBitcoin02.ÚltimoFloat = dataBitcoin02.ÚltimoFloat.*1000;
dataBitcoin02.ÚltimoFloat = reverse(dataBitcoin02.ÚltimoFloat)

real=[dataBitcoin02.ÚltimoFloat[1], dataBitcoin02.ÚltimoFloat[2], dataBitcoin02.ÚltimoFloat[3], dataBitcoin02.ÚltimoFloat[4], dataBitcoin02.ÚltimoFloat[5], dataBitcoin02.ÚltimoFloat[6], dataBitcoin02.ÚltimoFloat[7]]
plot(prediccion, label = "Predicción")
plot!(real, label = "Valores Reales")

using CSV
using DataFrames

dataBitcoinAnual = CSV.read("AnualBitcoin.csv",DataFrame);
dataBitcoinAnual.Último .= replace.(dataBitcoinAnual.Último, "," => "");
dataBitcoinAnual.ÚltimoFloat = parse.(Float64, dataBitcoinAnual.Último);
dataBitcoinAnual.ÚltimoFloat = dataBitcoinAnual.ÚltimoFloat.*1000;
dataBitcoinAnual.ÚltimoFloat = reverse(dataBitcoinAnual.ÚltimoFloat)

dataOroAnual = CSV.read("AnualOro.csv",DataFrame);
dataOroAnual.Último .= replace.(dataOroAnual.Último, "," => "");
dataOroAnual.ÚltimoFloat = parse.(Float64, dataOroAnual.Último);
dataOroAnual.ÚltimoFloat = dataOroAnual.ÚltimoFloat.*1000*(35.274);
dataOroAnual.ÚltimoFloat = reverse(dataOroAnual.ÚltimoFloat)

dataPlataAnual = CSV.read("AnualPlata.csv",DataFrame);
dataPlataAnual.Último .= replace.(dataPlataAnual.Último, "," => "");
dataPlataAnual.ÚltimoFloat = parse.(Float64, dataPlataAnual.Último);
dataPlataAnual.ÚltimoFloat = dataPlataAnual.ÚltimoFloat./1000*(35.274);
dataPlataAnual.ÚltimoFloat = reverse(dataPlataAnual.ÚltimoFloat)

dataPetroleoAnual = CSV.read("AnualPetroleo.csv",DataFrame);
dataPetroleoAnual.Último .= replace.(dataPetroleoAnual.Último, "," => "");
dataPetroleoAnual.ÚltimoFloat = parse.(Float64, dataPetroleoAnual.Último);
dataPetroleoAnual.ÚltimoFloat = dataPetroleoAnual.ÚltimoFloat./100;
dataPetroleoAnual.ÚltimoFloat = reverse(dataPetroleoAnual.ÚltimoFloat)

plot(dataBitcoinAnual.ÚltimoFloat, label = "Bitcoin")
plot!(dataOroAnual.ÚltimoFloat, label = "Oro")
plot!(dataPlataAnual.ÚltimoFloat, label = "Plata")
plot!(dataPetroleoAnual.ÚltimoFloat, label = "Petroleo")

N_1 = size(dataBitcoinAnual.ÚltimoFloat,1);
A_1 = Array(dataOroAnual.ÚltimoFloat);
b_1 = Array(dataBitcoinAnual.ÚltimoFloat);
A_1 = [ones(N_1,1) A_1 A_1.^2 A_1.^3];

using Plots

function f_1(x,y) 
    sum((A_1[:,1]*x+A_1[:,2]*y-b_1)*transpose((A_1[:,1]*x+A_1[:,2]*y-b_1)))
end
plotlyjs()
surface(-50000:1000:50000,-10000:100:15000, f_1)

using LinearAlgebra
qrA_1 = qr(A_1);       
xhat_1 = qrA_1\b_1

plot(61200:1:70018, x-> xhat_1[4].*x.^3 + xhat_1[3].*x.^2 + xhat_1[2]*x + xhat_1[1], label = "Predicción Bitcoin")
plot!(A_1[:,2], dataBitcoinAnual.ÚltimoFloat, st = :scatter, label = "Bitcoin")

g_1(x)=xhat_1[4].*x.^3 + xhat_1[3].*x.^2 + xhat_1[2]*x + xhat_1[1];

N_2 = size(dataBitcoinAnual.ÚltimoFloat,1);
A_2 = Array(dataPlataAnual.ÚltimoFloat);
b_2 = Array(dataBitcoinAnual.ÚltimoFloat);
A_2 = [ones(N_2,1) A_2 A_2.^2 A_2.^3];

function f_2(x,y) 
    sum((A_2[:,1]*x+A_2[:,2]*y-b_2)*transpose((A_2[:,1]*x+A_2[:,2]*y-b_2)))
end
plotlyjs()
surface(-50000:1000:50000,-10000:100:15000, f_2)

using LinearAlgebra
qrA_2 = qr(A_2);      
xhat_2 = qrA_2\b_2

plot(781:993, x-> xhat_2[4].*x.^3 + xhat_2[3].*x.^2 + xhat_2[2]*x + xhat_2[1], label = "Predicción Bitcoin")
plot!(A_2[:,2], dataBitcoinAnual.ÚltimoFloat, st = :scatter, label = "Bitcoin")

g_2(x) = xhat_2[4].*x.^3 + xhat_2[3].*x.^2 + xhat_2[2]*x + xhat_2[1];

N_3 = size(dataBitcoinAnual.ÚltimoFloat,1);
A_3 = Array(dataPetroleoAnual.ÚltimoFloat);
b_3 = Array(dataBitcoinAnual.ÚltimoFloat);
A_3 = [ones(N_3,1) A_3 A_3.^2 A_3.^3];

function f_3(x,y) 
    sum((A_3[:,1]*x+A_3[:,2]*y-b_3)*transpose((A_3[:,1]*x+A_3[:,2]*y-b_3)))
end
plotlyjs()
surface(-50000:1000:50000,-10000:100:15000, f_3)

using LinearAlgebra
qrA_3 = qr(A_3); 
xhat_3 = qrA_3\b_3

plot(59:116, x-> xhat_3[4].*x.^3 + xhat_3[3].*x.^2 + xhat_3[2]*x + xhat_3[1], label = "Predicción Bitcoin")
plot!(A_3[:,2], dataBitcoinAnual.ÚltimoFloat, st = :scatter, label = "Bitcoin")

g_3(x) = xhat_3[4].*x.^3 + xhat_3[3].*x.^2 + xhat_3[2]*x + xhat_3[1];
