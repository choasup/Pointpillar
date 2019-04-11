if [ $# -lt 1 ]
then
    echo "<$0> data_dir"
fi

data_dir=${1}

# save train, val, trainval, test infos.
# output: *.pkl
python3 ./engines/create_data.py create_kitti_info_file --data_path=$data_dir

# remove outside of camera for kitti [not valid for others dataset]
# output: ./training/velodyne_reduced
python3 ./engines/create_data.py create_reduced_point_cloud --data_path=$data_dir

# need set classes. default for kitti classes:
# 'Car': 0,
# 'Pedestrian': 1,
# 'Cyclist': 2,
# 'Van': 3,
# 'Person_sitting': 4,
# 'Truck': 5,
# 'Tram': 6,
# 'Misc': 7,
# output: ./gt_database
python3 ./engines/create_data.py create_groundtruth_database --data_path=$data_dir
