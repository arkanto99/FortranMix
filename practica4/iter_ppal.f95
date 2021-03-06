
program iter_ppal

!Declaracion de modulos/interfaces
use datsis_interf
use jacobi_interf
use gseidel_interf
use residuo_interf

implicit none
!Declaracion de variables y parametros
character(len=10)::formato4='(100e12.4)',formato10='(50e18.10)' !FORMATO

real(8),allocatable::a(:,:)
real(8),allocatable::b(:),u(:),r(:) !r es para el residuo, u para o resultado
real(8):: eps
integer:: nmaxit,metodo,n

print*,'Resolucion polo metodo de Gauss-Seidel e Jacobi'
print*,'Introduza a orde do sistema'
read*,n

allocate(a(n,n),b(n), u(n), r(n))

call datsis(a, b)

print*,'Elixa o metodo: '
print*,'1: Jacobi - 2: Gauss-Seidel'
read*,metodo
print*,'Tolerancia?'
read*,eps
print*,'Numero maximo iterantes?'
read*,nmaxit

select case(metodo)
	case(1)
		print*,'Metodo de Jacobi'
		call jacobi(a,b,u,eps,nmaxit)
	case(2)
		print*,'Metodo de Gauss-Seidel'
		call gseidel(a,b,u,eps,nmaxit)
	case default
		stop
end select



call residuo(a,b,u,r)

print*,' '
print*,'O resultado u ,empregando a factorizacion de elixida, e:'
print formato10,u
print*,' '
print*,'El residuo r=Au-b es:'
print formato4,r
print*,' '
print*,'La norma del residuo es :'
print formato4,sqrt(dot_product(r,r))

deallocate(a,b,u,r)

end program
