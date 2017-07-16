#!/bin/sh

# ----------------------------------------------------
# 1D tests
# ----------------------------------------------------

./Config.pl -g=1,1,50,4
make
rm -rf run

make rundir
mv run run_1d
cp srcData/UAM.in.1d run_1d/UAM.in
cd run_1d
./GITM.exe
../share/Scripts/DiffNum.pl -b -r=1e-5 UA/data/log0000000?.dat UA/DataIn/log0000000?.1d.dat >& ../test_1d.diff
diff UA/data/run_information.txt UA/DataIn/run_information.txt >> ../test_1d.diff
cd UA ; pGITM ; cd ..
cd ..
ls -l test_1d.diff

make rundir
mv run run_eclipse
cp srcData/UAM.in.eclipse run_eclipse/UAM.in
cd run_eclipse
./GITM.exe
../share/Scripts/DiffNum.pl -b -r=1e-5 UA/data/log0000000?.dat UA/DataIn/log0000000?.eclipse.dat >& ../test_eclipse.diff
diff UA/data/run_information.txt UA/DataIn/run_information.txt >> ../test_eclipse.diff
cd UA ; pGITM ; cd ..
cd ..
ls -l test_eclipse.diff

# ----------------------------------------------------
# 3D tests
# ----------------------------------------------------

./Config.pl -g=9,9,50,4
make
rm -rf run

make rundir
mv run run_3d
cp srcData/UAM.in.3d run_3d/UAM.in
cd run_3d
mpirun -np 4 ./GITM.exe
../share/Scripts/DiffNum.pl -b -r=1e-5 UA/data/log0000000?.dat UA/DataIn/log0000000?.3d.dat >& ../test_3d.diff
diff UA/data/run_information.txt UA/DataIn/run_information.txt >> ../test_3d.diff
cd UA ; pGITM ; cd ..
cd data ; idl < ../DataIn/idl_input.3d ; cd ..
cd ../..
ls -l test_3d.diff

