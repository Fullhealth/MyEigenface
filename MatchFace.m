%function MatchFace(MeanAll,U,OmegaAll,TestFace)
%������һ������testEigenface�Ľ����ʶ��ѵ�����������
TestFace=imread('TestFace7.jpg');  %TF:TestFace
VTestFace=double(TestFace(:));
DiFace=VTestFace-MeanAll(:,1);  %DiFaceΪ��ʶ��������������ƽ����֮��
OmegaTF=zeros(20,1);
for t=1:20
    OmegaTF(t,1)=U(:,t)'*DiFace;
end
Distance=zeros(20,2);%distance��һ������Ϊ����ͼ��20�������ľ��룬�ڶ���Ϊ���Ӧ�����
for u=1:20
    Distance(u,2)=u;
    Distance(u,1)=norm(OmegaTF-OmegaAll(:,u));
end
%A1��һ�д�ž������������
A1=Distance;
A1(:,1)=sort(Distance(:,1));
ser=zeros(20,1);
for w=1:20
    [ser(w,1),~]=find(Distance(:,1)==A1(w,1));
end
%MatrixAllǰ����ΪDistance��������Ϊ�����������У�������Ϊ�����и�ֵԭ�������
MatrixAll=zeros(20,4);
MatrixAll(:,1)=Distance(:,1);
MatrixAll(:,2)=Distance(:,2);
MatrixAll(:,3)=A1(:,1);
MatrixAll(:,4)=ser;
%Ѱ�Ҿ�����̵�ͼ��Ϊʶ�����������
num=MatrixAll(1,4);
% [~,num]=min(Distance(:,1));
name2=sprintf('face%d.jpg',num);  
figure;
subplot(1,2,1),imshow(TestFace);
title('���������');
subplot(1,2,2),imshow(name2);
title('ʶ�����ӽ�������')
%����ͼ�����վ����С�����˳�����
figure;suptitle('ʶ�����������ң��ϵ������ƶ����ν��ͣ�');
for x=1:20
    name3=sprintf('face%d.jpg',MatrixAll(x,4)); 
    subplot(4,5,x),imshow(name3);
end    