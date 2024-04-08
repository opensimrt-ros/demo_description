#!/usr/bin/env bash
SESSION_NAME=ar_imu_combined

source "`rospack find tmux_session_core`/common_functions.bash"
ros_core_tmux "$SESSION_NAME"

tmux set -g pane-border-status top

W1=(

#"roslaunch realsense2_description view_d455_model.launch" 
"roslaunch demo_description more_complete.launch" 
"roslaunch brio_cam ar_brio_upperarm_multi.launch" 
#"roslaunch ar_test brio_video_stream.launch video_stream_provider:=$1 visualize:=true " 
"roslaunch ar_test brio_video_stream.launch video_stream_provider:=$1 " 
"sleep 10; roslaunch osrt_ros ik_upper_both.launch run_imu:=false" 
"ROS_NAMESPACE=usb_cam_brio rosrun image_proc image_proc" 
)

W2=(
	"rosrun tmux_session_core session_commander_ar_imu.py"
"#rosservice call /ar/ik_upperbody_node/set_name_and_path '' ''" 
"#rosservice call /imu/ik_upperbody_node/set_name_and_path '' ''"
)
create_tmux_window "$SESSION_NAME" "rviz_urdf" "${W1[@]}"
#create_tmux_window "$SESSION_NAME" "session" "${W2[@]}"
#create_tmux_window "$SESSION_NAME" "ik_imus" 	"${W3[@]}"

tmux -2 a -t $SESSION_NAME

