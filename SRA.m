
function [FailureRate Rank Mymat]=SRA(Data,Algorithms,Functions,AlgorithmNames,alpha,Beta,FunctionGroup)


if nargin<1
    error('Input data missing. Please provide the required arguments.');
end
if nargin<2 || isempty(Algorithms)
    NA = size(Data,1);
    Algorithms=1:NA;
end
if nargin<3 ||  isempty(Functions)
    NF = size(Data,2);
    Functions=1:NF;
end
if nargin<4 ||  isempty(AlgorithmNames)
    AlgorithmNames = "Alg" + string(Algorithms);
end
if nargin<5 || isempty(alpha)
    alpha=0.05;
end
NF=numel(Functions);
NA=numel(Algorithms);
if nargin<6 || isempty(Beta)
    FunctionGroup=ones(1,NF);
    Beta=1;
end


%compute Adaptive Beta
NG=numel(Beta);
for i=1:NG
    N(i)=numel(find(FunctionGroup==i));
end
AdaptiveBeta=Beta.*sum(N)./N;




mat=zeros(NA);
Mymat.mat=zeros(NA);
l=1;
ii=0;
Mymat.CombinedP_values=nan*ones(NA,NA);
for i=[ Algorithms(1:end-1)]
    j=l+1:NA;
    [W,L]=WHX(Data,i,Algorithms(j),Functions,alpha,AdaptiveBeta,FunctionGroup);
    k=NF-(W+L);
    mat(l,j)=W+k/2;
    mat(j,l)=L+k/2;
    l=l+1;
    ii=ii+1;
    jj=ii+1:NA;
    %jj(ii)=[];
    Mymat.Name(ii)={AlgorithmNames(i)};
    Mymat.mat(ii,jj)=W+k/2;
    Mymat.mat(jj,ii)=L+k/2;
     jj1=jj;
    for jj=jj1
        if  Mymat.mat(ii,jj)> Mymat.mat(jj,ii)
            Mymat.Comp(ii,jj)=1; Mymat.Comp(jj,ii)=0;
        elseif Mymat.mat(ii,jj)< Mymat.mat(jj,ii)
            Mymat.Comp(ii,jj)=0;Mymat.Comp(jj,ii)=1;
        else
            Mymat.Comp(ii,jj)=0.5; Mymat.Comp(jj,ii)=0.5;
        end
    end
    
end

FailureRate=sum(mat);
[k1 id]=sort(FailureRate);
[f Rank]=sort(id);

end
function [Winner Failure P_values L]=WHX(Data,myMID,ComparedMID,F_index,alpha,AdaptiveBeta,FunctionGroup)
% for alg=[]
%     for F=F_index
% Data(alg,F,:)=Data(alg).R(F).Fbest
%     end
% end

g=[];
ss=zeros(3,numel(ComparedMID));
P_values=ones(numel(ComparedMID),numel(F_index))*nan;

indexcounter=1;
for index=F_index
    X=squeeze(Data(myMID,index,:))';
    %  X=controlsize(X);
    methodI=0;
    for method=ComparedMID
        methodI=methodI+1;
        Y=squeeze(Data(method,index,:))';
        %      Y=controlsize(Y);
        [p1 h d]=signrank(Y,X,'alpha',alpha);
        F(index).signedrank(method,1)=d.signedrank;
        [p2 h d]=signrank(X,Y,'alpha',alpha);
        P_values(methodI,indexcounter)=p1;
        F(index).signedrank(method,2)=d.signedrank;
        L(index,methodI,1:2)=[F(index).signedrank(method,1)  F(index).signedrank(method,2) ];
        [m T]=max(L(index,methodI,(1:2)));
        if(h==0)
            g=[g sum(L(index,methodI,(1:2)))];
            T=3;
            %     disp(num2str([index,method]))
        end
        L(index,methodI,3)=p1;
        L(index,methodI,4)=T;
        switch(T)
            case 1
                ch='+';
            case 2
                ch='-';
            case 3
                ch='=';
        end
         Allsign{index,method}=ch;       
    end
    indexcounter=indexcounter+1;
end

sign=  L(F_index,:,4);
c=sum((sign==2).*AdaptiveBeta(FunctionGroup)');
a=sum((sign==1).*AdaptiveBeta(FunctionGroup)');
b=sum((sign==3).*AdaptiveBeta(FunctionGroup)');
ss(1,:)=ss(1,:)+a;
ss(2,:)=ss(2,:)+b;
ss(3,:)=ss(3,:)+c;

Winner=ss(1,:);
Failure=ss(3,:);



end
function x=controlsize(x)

if numel(x)<30
    disp('error the number of the x dimension')
    pause(1000);
    %  x=[x x];
end
x(31:end)=[];
end
