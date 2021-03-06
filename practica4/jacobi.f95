
!Factorizacion de Jacobi: A=D-E-F, con D diagonal, E triangular inferior con diagonal nula e F triangular superior con diagonal nula
!O metodo iterativo e u(k+1)=inv(D)*(E+F)*u(k) + inv(D)*b, con inv(D) matriz inversa de D

subroutine jacobi(a,b,u,eps,nmaxit)

implicit none

real(8),dimension(:,:),intent(in)::a
real(8),dimension(:),intent(in)::b
real(8),dimension(:),intent(out)::u
real(8),intent(in)::eps
integer,intent(in)::nmaxit

real(8),allocatable::v(:) !Esta variable hace la labor de !Uk,ya que necesitamos u para calcular Uk
integer::n,i,j,k
real(8)::error,xnorm !Error=err
character(len=10)::formator4='(100e12.4)'

n=size(b)
allocate(v(n))

u=0
do i=1,n !Comprobacion da diagonal
	if(abs(a(i,i))< 1.e-12) then
		print*,'Elemento diagonal ',i,' nulo'
		print*,'O metodo non se pode aplicar'
		stop
	end if
end do

do k=1,nmaxit
	error=0
	xnorm=0
	v=b !Facemos v=b 
	do i=1,n
		do j=1,i-1
			v(i)=v(i)-a(i,j)*u(j) !Restamos os elementos de E a 'b'
		end do
		do j=i+1,n
			v(i)=v(i)-a(i,j)*u(j) !Restamos os elementos de F a 'b'
		end do
		v(i)=v(i)/a(i,i) !Dividimos entre o elemento diagonal correspondente de D
		error=error+abs(v(i)-u(i))
		xnorm=xnorm+abs(u(i))
	end do
	u=v
	
	error=error/(xnorm+1) !Calculo do erro relativo

	if(mod(k,10).eq.0) then
		print*,'Iteracion',k
		print*, 'Error relativo',error
		print*,'Vector u:'
		print formator4,u
	end if

	if(error<eps) then !Test de parada
		print*,'Alcanzouse o test de parada'
		print*,'O numero de iteracions realizadas foi',k
		return
	end if
end do

print*,'Alcanzouse o numero maximo de iteracions'

end subroutine

