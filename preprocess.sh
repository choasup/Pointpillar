if [ $# -lt 1 ]
then
    echo "<$0> data_dir"
fi

data_dir=${1}

python3 create_data.py create_kitti_info_file --data_path=$data_dir
