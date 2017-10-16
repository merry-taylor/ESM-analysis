num=1;
T1=1800;
T2=100;
%alpha=30;
%for T1=300:200:2300
    for alpha=10:90 %T2=30:20:230
        filename = ['gm' num2str(num) '.txt'];
        fileID=fopen(filename, 'w');
        fprintf(fileID,'%6.2f\n %6.2f\n %6.2f\n',alpha, T1, T2);
        fclose(fileID);
        num=num+1;
    end
%end