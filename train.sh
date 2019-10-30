#!/bin/sh
# Lib cuda
wget -P /tmp https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1404/x86_64/libcudnn5_5.1.10-1+cuda8.0_amd64.deb

wget -P /tmp https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1404/x86_64/libcudnn5-dev_5.1.10-1+cuda8.0_amd64.deb

wget -P /tmp http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb

sudo dpkg -i /tmp/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb

sudo dpkg -i /tmp/libcudnn5_5.1.10-1+cuda8.0_amd64.deb libcudnn5-dev_5.1.10-1+cuda8.0_amd64.deb

sudo apt-get update

sudo sh -c \"echo 'CUDA_HOME=/usr/local/cuda' >> /etc/profile.d/cuda.sh\"

sudo sh -c \"echo 'export LD_LIBRARY_PATH=\\${LD_LIBRARY_PATH}:\\${CUDA_HOME}/lib64' >> /etc/profile.d/cuda.sh\"

sudo sh -c \"echo 'export LIBRARY_PATH=\\${LIBRARY_PATH}:\\${CUDA_HOME}/lib64' >> /etc/profile.d/cuda.sh\"

sudo sh -c \"echo 'export C_INCLUDE_PATH=\\${C_INCLUDE_PATH}:\\${CUDA_HOME}/include' >> /etc/profile.d/cuda.sh\"

sudo sh -c \"echo 'export CXX_INCLUDE_PATH=\\${CXX_INCLUDE_PATH}:\\${CUDA_HOME}/include' >> /etc/profile.d/cuda.sh\"

sudo sh -c \"echo 'export PATH=\\${PATH}:\\${CUDA_HOME}/bin' >> /etc/profile.d/cuda.sh\"

sudo apt-get install  cuda-8.0 -y

sudo apt-get update

sudo apt install gcc-5 g++-5

sudo apt-get update

sudo ln -s /usr/bin/gcc-5 /usr/local/cuda/bin/gcc

sudo ln -s /usr/bin/g++-5 /usr/local/cuda/bin/g++

sudo apt-get update

#wget -P /tmp https://bootstrap.pypa.io/get-pip.py && python /tmp/get-pip.py --user
wget -P /tmp https://bootstrap.pypa.io/get-pip.py && python /tmp/get-pip.py

git clone https://github.com/Xilinx/BNN-PYNQ.git

sudo apt-get install git python-dev libopenblas-dev liblapack-dev gfortran -y

#pip install --user git+https://github.com/Theano/Theano.git
pip install git+https://github.com/Theano/Theano.git

#pip install --user https://github.com/Lasagne/Lasagne/archive/master.zip
pip install https://github.com/Lasagne/Lasagne/archive/master.zip

sudo apt-get update

echo "[global]" >> ~/.theanorc

echo "floatX = float32" >> ~/.theanorc

echo "device = cuda0" >> ~/.theanorc

echo "openmp = True" >> ~/.theanorc

echo "openmp_elemwise_minsize = 200000" >> ~/.theanorc

echo "" >> ~/.theanorc

echo "[nvcc]" >> ~/.theanorc

echo "fastmath = True" >> ~/.theanorc

echo "" >> ~/.theanorc

echo "[blas]" >> ~/.theanorc

echo "ldflags = -lopenblas" >> ~/.theanorc

export OMP_NUM_THREADS=`nproc`

#cd BNN-PYNQ/bnn/src/training/

#git clone https://github.com/lisa-lab/pylearn2

#cd pylearn2

#python setup.py develop --user


## Install libgpuarray 
cd /tmp
git clone https://github.com/Theano/libgpuarray.git
cd ./libgpuarray
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l
make -j$((`nproc`+1))
make install
cd ..
python setup.py build
python setup.py install

# Refresh ld link
sudo ldconfig
ldconfig -p | grep libgpuarray

echo "Set up has finished"

