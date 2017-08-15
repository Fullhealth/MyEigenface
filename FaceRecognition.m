%function FaceRecognition(TestFace)
%����Eigenface
exm=imread('face1.jpg');
[m,n]=size(exm);
l=m*n;
VectorAll=zeros(l,20);  %��ʼ�������(��ΪͼƬ�����������ĳ���,��ΪͼƬ��)
figure;suptitle('������');
for i=1:20
    name1=sprintf('face%d.jpg',i);
    A= imread(name1);
    subplot(4,5,i);
    imshow(A);
    VectorAll(:,i)=A(:); %ͼƬת��Ϊ������
end
%�����������ľ�ֵ
MeanAll=zeros(l,20);
for k=1:l
    MeanAll(k,:)=mean(VectorAll(k,:));
end
Face=reshape(MeanAll(:,1),m,n);
Face=uint8(Face);
direct=[cd,'\TestSet\'];   %����ƽ����
imwrite(Face,[direct, 'MeanFace.gif']);
figure;
imshow(Face);title('����ͼƬ��ƽ����')
Differ=VectorAll-MeanAll; %ÿ����������ƽ��������
figure;suptitle('ԭͼ��ƽ�����Ĳ�ֵ');
for j=1:20
   B0=reshape(Differ(:,j),230,200); 
   B=uint8(B0);
   subplot(4,5,j);
   imshow(B);
   direct=[cd,'\TestSet\DifferFace\'];   %����ƽ����
   imwrite(B,[direct, 'DifferFace',sprintf('%d',j),'.gif']);
end
%����Э�������Differ*Differ'��������ֵ����������
C=cov(Differ);%Differ'*Differ;%�ȼ���C������������
[V,~] = eig(C);%DΪ����ֵ���ɵĶԽ���ÿ������ֵ��Ӧ��V��������������Ҳ����������������
U=zeros(46000,20);
figure;suptitle('������');
%����C��������������Э�������ġ��ټ�������������ʾ����
for p=1:20 
    U(:,p)=Differ*V(:,p);
    FeatureFace=reshape(U(:,p),230,200);
    FeatureFace=uint8(FeatureFace);
    subplot(4,5,p);
    imshow(FeatureFace);
    direct=[cd,'\TestSet\FeatureFaces\'];   %����������
    imwrite(FeatureFace,[direct, 'FeatureFace',sprintf('%d',p),'.gif']);
end
%������������ÿ����ͨ����������Ȩ�ر�ʾ,OmegaAllÿһ��Ϊÿ������Ӧ����������ʾ
OmegaAll=zeros(20,20);  %19�У�ÿ���˵�Ȩ��ֵ��9������ֵ��Ȩ�أ�20�У�20���ˣ�
for s=1:20
    for r=1:20
        OmegaAll(r,s)=U(:,r)'*Differ(:,s);
    end
end
%������һ������testEigenface�Ľ����ʶ��ѵ�����������
%TestFace=imread('TestFace4.jpg');  %TF:TestFace
VTestFace=double(TestFace(:));
DiFace=VTestFace-MeanAll(:,1);  %DiFaceΪ��ʶ��������������ƽ����֮��
OmegaTF=zeros(20,1);%19�У�1��
for t=1:20
    OmegaTF(t,1)=U(:,t)'*DiFace;
end
Distance=zeros(20,2);%distance��һ������Ϊ����ͼ��20�������ľ��룬�ڶ���Ϊ���Ӧ�����
for u=1:20
    Distance(u,2)=u;
    Distance(u,1)=norm(OmegaTF-OmegaAll(:,u));
end
A1=Distance;
A1(:,1)=sort(Distance(:,1));     %A1��һ�д�ž������������
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
num=MatrixAll(1,4);     % [~,num]=min(Distance(:,1));
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