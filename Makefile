################################################################################

# CUDA code generation flags
ifneq ($(OS_ARCH),armv7l)
#GENCODE_SM10    := -gencode arch=compute_10,code=sm_10
endif
#GENCODE_SM20    := -gencode arch=compute_20,code=sm_20
#GENCODE_SM30    := -gencode arch=compute_30,code=sm_30
#GENCODE_SM32    := -gencode arch=compute_32,code=sm_32
GENCODE_SM35    := -gencode arch=compute_35,code=sm_35
#GENCODE_SM50    := -gencode arch=compute_50,code=sm_50
#GENCODE_SMXX    := -gencode arch=compute_50,code=compute_50
GENCODE_FLAGS   ?= $(GENCODE_SM10) $(GENCODE_SM20) $(GENCODE_SM30) $(GENCODE_SM32) $(GENCODE_SM35) $(GENCODE_SM50) $(GENCODE_SMXX)

################################################################################

OPT = -O3
#MISC_FLAGS = --ptxas-options=-v

cudamat:
	nvcc $(OPT) $(MISC_FLAGS) $(GENCODE_FLAGS) \
	--compiler-options '-fPIC' -o libcudamat.so --shared cudamat.cu cudamat_kernels.cu -lcublas
	nvcc $(OPT) $(MISC_FLAGS) $(GENCODE_FLAGS) \
	--compiler-options '-fPIC' -o libcudalearn.so --shared learn.cu learn_kernels.cu -lcublas

clean:
	rm -f *.linkinfo *.pyc *.so
