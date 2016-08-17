load('Data1.mat');
load('Data2.mat');

Depth = zeros(16,32);
for i = 1:length(Data1)
    xi = Data1(i,3);
    yi = Data1(i,4);
        for j = 1:length(Data2)
        x2i = Data2(j,3);
        y2i = Data2(j,4);
        if xi == x2i && yi == y2i && xi ~= 0 && y2i ~= 0
            Depth(xi,yi) = abs(Data1(i,1) - Data2(j,1)) + abs(Data1(i,2) - Data2(j,2));
            if Depth(xi,yi)>100, Depth(xi,yi)=64;
                
            end
        end
        end
end
Depth = Depth(:,1:32,:);
surf(Depth);
       
