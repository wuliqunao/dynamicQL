from quspin.operators import hamiltonian
from quspin.basis import spin_basis_1d
import numpy as np

def Hamiltonian(L,J,hz,hx,fct=None):
	
	basis = spin_basis_1d(L=L,pauli=False)
	fct_arg=[]
		
	zz_int =[[J,i,(i+1)%L] for i in range(L)] # Has periodic boundary conditions
	ones=[[1,i] for i in range(L)]
	z_field=[[-hz,i] for i in range(L)]

	static = [["zz",zz_int],["z",z_field]]
	dynamic = [["x",ones,fct,fct_arg]]

	kwargs = {'dtype':np.float64,'basis':basis,'check_symm':False,'check_herm':False,'check_pcon':False}
	
	return hamiltonian(static,dynamic,**kwargs), basis
