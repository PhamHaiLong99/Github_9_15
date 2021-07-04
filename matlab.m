
% Tinh toan chuyen vi nut, ung suat trong cac thanh cua he thanh 
% tinh phan luc lien ket tai cac lien ket cua he thanh phang chiu luc
% su dung phan tu thanh
% (Hinh. 5.4 mo ta mo hinh PTHH tinh he thanh phang) %
% Mo ta cac bien 
% k = ma tran do cung phan tu 
% f = vecto luc nut phan tu
% kk = ma tran do cung tong the
% ff = vecto luc nut tong the
% disp = vecto chuyen vi nut tong the
% eldisp = (element_disp) – vecto chuyen vi nut phan tu
% stress = ma tran ung suat
% strain = ma tran bien dang
% gcoord = toa do nut
% nodes = ma tran chi so nut cua moi phan tu
% index = vecto chuyen vi nut chung o moi phan tu
%---------------------------------------------------------------------------- 
%------------------------------------
% Cac tham so dau vao
%------------------------------------
clear
% Type of geometric construction
type_geometric =1;
switch (type_geometric)
 case 1
 a=3000; % mm thay doi
 b=6000;
 emodul=2.1*10e5; % MPa (N/mm^2) thay doi 210Gpa= 2.1 x 10^5 N/mm2
 area=(20*10).^2; % mm^2 thay doi
 force=10e3; % N thay doi ne
 noe=4; % noe = Number Of Elements(segments)
 non=4; % non = Number Of Nodes 
 lcoord(1,1,1)=0;
 lcoord(1,2,1)=0;
 lcoord(2,1,1)=a;
 lcoord(2,2,1)=0;
 lcoord(1,1,2)=a;
 lcoord(1,2,2)=0;
 lcoord(2,1,2)=a;
 lcoord(2,2,2)=b;
 lcoord(1,1,3)=0;
 lcoord(1,2,3)=b;
 lcoord(2,1,3)=a;
 lcoord(2,2,3)=0;
 lcoord(1,1,4)=0;
 lcoord(1,2,4)=b;
 lcoord(2,1,4)=a;
 lcoord(2,2,4)=b;
 % Chi so nut phan tu theo chi so nut chung
 index(1,1)=1;
 index(1,2)=2;
 index(2,1)=2;
 index(2,2)=3;
 index(3,1)=4;
 index(3,2)=2;
 index(4,1)=4;
 index(4,2)=3;
 %disp(index);
 %disp(lcoord);
end
for i=1:noe
 L(i)=sqrt((lcoord(2,1,i)-lcoord(1,1,i))^2+(lcoord(2,2,i)-
lcoord(1,2,i))^2);
 l(i)=(lcoord(2,1,i)-lcoord(1,1,i))/L(i);
 m(i)=(lcoord(2,2,i)-lcoord(1,2,i))/L(i);
 % Ma tran chuyen doi he toa do
 trans_mat(1,1,i)=l(i);
 trans_mat(1,2,i)=m(i);
 trans_mat(1,3,i)=0;
 trans_mat(1,4,i)=0;
 trans_mat(2,1,i)=0;
 trans_mat(2,2,i)=0;
 trans_mat(2,3,i)=l(i);
 trans_mat(2,4,i)=m(i);
 %disp(trans_mat);
 % Ma tran chuyen doi he toa do ung suat 
 stress_trans(i,1)=-l(i);
 stress_trans(i,2)=-m(i);
 stress_trans(i,3)=l(i);
 stress_trans(i,4)=m(i);
 %disp(stress_trans);
 % Modul dan hoi cua cac thanh 
 E(i)=emodul;
 A(i)=area; % Tiet dien ngang cua cac thanh
end
trans_mat
stress_trans
% Tinh ma tran do cung phan tu trong he toa do dia phuong
for i=1:noe 
 k_local(1,1,i)=(E(i)*A(i)/L(i));
 k_local(1,2,i)=-k_local(1,1,i);
 k_local(2,1,i)=-k_local(1,1,i);
 k_local(2,2,i)=k_local(1,1,i);
end
% Tinh ma tran do cung phan tu trong he toa do chung
trans_trans_mat=permute(trans_mat,[2,1,3])

for i=1:noe 
 k(:,:,i)=trans_trans_mat(:,:,i)*k_local(:,:,i)*trans_mat(:,:,i);
end
k % In ma tran do cung phan tu
% Xay dung ma tran do cung tong the
edof=2; %edof: so bac tu do cua 1 node
sdof=non*edof;
kk=zeros(sdof,sdof);
for row_indx=1:non
 for e=1:noe
 for n1=1:2
 if (index(e,n1) == row_indx)
 for col_indx=1:non
 for n2=1:2
 if (index(e,n2)==col_indx)
     for i=1:2
 for j=1:2
 kk((row_indx-1)*edof+i,(col_indx-1)*edof+j)=...
 kk((row_indx-1)*edof+i,(col_indx-1)*edof+j)+...
 k((n1-1)*edof+i,(n2-1)*edof+j,e);
 end
 end
 end
 end
 end
 end
 end
 end
end
kkk=kk;
kk % In ma tran do cung tong the
% Tinh ma tran luc nut phan tu
f=zeros(noe,2*edof);
f(2,1)=20000
f(2,4)=-25000;
f % In ve to luc nut phan tu 
% Xay dung ve to luc nut chung
ff=zeros(sdof,1);
for row_indx=1:non
 for e=1:noe
 for n=1:2 % 2:so node/phan tu
 if (index(e,n)==row_indx)
 for i=1:2
 ff((row_indx-1)*edof+i)=ff((row_indx-1)*edof+i)...
 +f(e,(n-1)*edof+i);
 end
 end
 end
 end
end
% In vec to luc nut chung
ff
% Ap dat dieu kien bien phai thay doi ne
for i=1:sdof
 disp(i)=1;
end
disp(1)=0;
disp(2)=0;
disp(4)=0;
disp(7)=0;
disp(8)=0;
for i=1:sdof
 if (disp(i)==0)
 kk(i,:)=0;%gach hang i
 kk(:,i)=0;%gach cot i
 ff(i)=0;
 kk(i,i)=1;
 end
end
kk
ff
% Giai he PT PTHH xac dinh chuyen vi nut
disp=kk\ff;
% In vec to chuyen vi nut chung
disp
% Xac dinh chuyen vi nut trong cac thanh
for e=1:noe
 for i=1:2 % 2 nut
 for j=1:edof % edof=2: 2 bac tu do/nut
 eldisp(e,(i-1)*edof+j)=disp((index(e,i)-1)*edof+j);
 end
 end
end
eldisp
% Tinh Ung suat trong cac thanh
stress=zeros(noe,1);
for e=1:noe
 stress(e)=(E(e)/L(e))*stress_trans(e,:)*eldisp(e,:)';
end
stress
% Tinh Phan luc lien ket tai cac goi 
R=zeros(sdof,1);
R=kkk*disp;
R