#!/usr/bin/env bash

gst-launch-1.0 \
    v4l2src name=cam_src ! videoconvert ! videoscale ! video/x-raw,width={{ nn_capture_height }},height={{ nn_capture_width }},format=RGB,framerate={{ nn_capture_framerate }}/1 ! tee name=t \
    t. ! queue leaky=2 max-size-buffers=2 ! videoscale ! video/x-raw,width={{ nn_tensor_width }},height={{ nn_tensor_height }},format=RGB ! tensor_converter ! \
        tensor_transform mode=arithmetic option=typecast:float32,add:-127.5,div:127.5 ! \
        tensor_filter framework={{ nn_framework }} model={{ nn_model_file }} ! \
        tensor_decoder mode=bounding_boxes option1=mobilenet-ssd option2={{ nn_label_file }} option3=%i:%i:%i:%i,%i option4={{ nn_capture_width }}:{{ nn_capture_height}} option5={{ nn_tensor_width}}:{{ nn_tensor_height }} ! \
        compositor name=mix sink_0::zorder=2 sink_1::zorder=1 ! videoconvert ! ximagesink \
    t. ! queue leaky=2 max-size-buffers=10 ! mix.
