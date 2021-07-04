% Chuong trinh so 1, chuong 4. (P4_1)
%---------------------------------------------------------------------------- 
% Tinh chuyen vi nut trong cac ket cau 1-D %
% Mo ta cac bien 
% k = ma tran do cung phan tu 
% f = vecto luc nut phan tu
% kk = ma tran do cung tong the
% ff = vecto luc nut tong the
% gcoord = toa do nut
% nodes = ma tran chi so nut cua moi phan tu
% index = vecto chuyen vi nut chung o moi phan tu
%---------------------------------------------------------------------------- 
%------------------------------------
% Cac tham so dau vao
%------------------------------------
clear
edof=1; % edof = so bac tu do tai nut
noe=input('Nhap so phan tu:'); % noe = so phan tu
% Nhap du lieu: cac thong so hinh hoc cua ket cau va co tinh vat lieu
for i=1:noe 
 Doan_truc=i
 los(i)=input('Nhap chieu dai (don vi mm) cua doan '); 
 E(i)=input('Nhap modul dan hoi keo nen (N/mm2) cua doan (phan 
tu)'); 
 A(i)=input('Nhap tiet dien mat cat ngang (mm2) cua doan (phan 
tu)');
end
% Nhap du lieu: cac thong tin ve chi so nut phan tu tuong ung voi chi 
so
% nut tong the, phuc vu cho viec ghep noi phan tu
for i=1:noe 
 Phan_tu = i
 index(i,1)=input('Chi so nut toan cuc cua nut 1:');
 index(i,2)=input('Chi so nut toan cuc cua nut 2:');
end
% Nhap du lieu: cac thong tin ve tai trong tac dung. 
% 1. Tai trong tap trung
nof=input('Nhap so luc tap trung:'); % nof=Number Of Force
for i=1:nof 
 Luc_thu =i
 temp_f(i)=input('Gia tri luc (don vi N): '); 
 force_pos(i)=input('Vi tri dat luc (nut so): '); 
end
% Thong tin ve lien ket 
noc=0; % noc=Number Of Clamp
while ((noc==0)|(noc>2))
 noc=input('So luong lien ket (1 hoac 2):'); 
end
for i=1:noc
 c(i)=input('Vi tri dat lien ket (nut dat lien ket): ');
end
% Tinh ma tran do cung phan tu
for i=1:noe 
 k(1,1,i)=E(i)*A(i)/los(i);
 k(1,2,i)=-k(1,1,i);
 k(2,1,i)=-k(1,1,i);
 k(2,2,i)=k(1,1,i);
end
for e=1:noe % In ma tran do cung cac phan tu
 k(e,:) 
end
% Xay dung ma tran do cung tong the
non=noe+1; % non = Number Of Nodes
sdof=non*edof;
kk=zeros(sdof,sdof);
for row_indx=1:non
for e=1:noe
for n1=1:2
if (index(e,n1)==row_indx)
for col_indx=1:non
for n2=1:2
if (index(e,n2)==col_indx)
kk(row_indx,col_indx)=kk(row_indx,col_indx)+ k(n1,n2,e);
end
end
end
end
end
end
end
kk % In ma tran do cung tong the
% Tinh ma tran luc nut phan tu
f=zeros(noe,2);
for e=1:noe
 for i=1:nof
 if (index(e,1)==force_pos(i))
 f(e,1)=temp_f(i);
 end
 if (index(e,2)==force_pos(i))
 f(e,2)=temp_f(i);
 end
 end
end
f
% Xay dung vecto luc nut chung
ff=zeros(sdof,1);
for node=1:non
 for e=1:noe
 for n=1:2
 if (index(e,n)==node)
 ff(node)=f(e,n);
 end
 end
 end
end
ff % In vecto luc nut chung
% Ap dat dieu kien bien
for node=1:noc
 kk(c(node),:)=0;
 kk(:,c(node))=0;
 ff(c(node))=0;
 kk(c(node),c(node))=1;
end
kk
ff
Q=kk\ff;