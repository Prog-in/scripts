# Install scr
chmod +x install_scr.sh
./install_scr.sh

SCR_ROOT="$HOME/scr"
echo "export SCR_ROOT=\"$SCR_ROOT\"" >> ~/.bashrc
source ~/.bashrc

# Remove hpcac-toolkit
cd ../../..
rm -rf hpcac-toolkit

# Install jacobi-method
git clone https://github.com/Prog-in/jacobi-method.git
cd jacobi-method

# Build all versions
make all

nproc_value=$(nproc)

if [ "$nproc_value" -eq 1 ]; then
    half_nproc=1
else
    half_nproc=$((nproc_value / 2))
fi

# Run the noft version of the program
mpirun --hostfile /var/nfs_dir/hostfile -np $(nproc) ./jacobi_noft -p $half_nproc -q $half_nproc -NB 1024 >> noft.log

# Run the ulfm version of the program
mpirun --hostfile /var/nfs_dir/hostfile -np $(nproc) --with-ft=ulfm --oversubscribe ./jacobi_ulfm -p $half_nproc -q $half_nproc -NB 1024 >> ulfm.log

# Run the scr version of the program
mpirun --hostfile /var/nfs_dir/hostfile -np $(nproc) ./jacobi_scr -p $half_nproc -q $half_nproc -NB 1024 >> scr.log
