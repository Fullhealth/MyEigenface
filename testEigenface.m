%function[MeanAll,U,OmegaAll]= testEigenface
%���ղ���http://blog.csdn.net/smartempire/article/details/21406005
clear all
close all
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

%����Differ��Ӧԭ�����еľ���A��CΪԭ�����еľ���L
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
%Differ=bsxfun(@minus, VectorAll, mean(VectorAll,2));
% Differ0=VectorAll-MeanAll;
% Differ=Differ0+ones(l,20)*127.5;
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
[V,D] = eig(C);  %DΪ����ֵ���ɵĶԽ���ÿ������ֵ��Ӧ��V��������������Ҳ����������������
%U=zeros(46000,20);%U�����洢���е�������������
U=zeros(46000,20);
figure;suptitle('������');
%����C��������������Э�������ġ��ټ�������������ʾ����
for p=1:20 
%     for q=1:20
%         U(:,p)=V(q,p)*Differ(:,q)+U(:,p);
%     end
    U(:,p)=Differ*V(:,p);
    FeatureFace=reshape(U(:,p),230,200);
    FeatureFace=uint8(FeatureFace);
    subplot(4,5,p);
    imshow(FeatureFace);
    direct=[cd,'\TestSet\FeatureFaces\'];   %����ƽ����
   imwrite(FeatureFace,[direct, 'FeatureFace',sprintf('%d',p),'.gif']);
end
%������������ÿ����ͨ����������Ȩ�ر�ʾ,OmegaAllÿһ��Ϊÿ������Ӧ����������ʾ
% OmegaAll=zeros(20,20);
% for r=1:20
%     OmegaAll(:,r)=U(:,r)'*Differ(:,r);
% end
OmegaAll=zeros(20,20);  %19�У�ÿ���˵�Ȩ��ֵ��9������ֵ��Ȩ�أ�20�У�20���ˣ�
for s=1:20
    for r=1:20
        OmegaAll(r,s)=U(:,r)'*Differ(:,s);
    end
end

