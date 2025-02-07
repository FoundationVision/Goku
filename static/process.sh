#!/bin/bash

# 原始视频目录
INPUT_DIR="videos"
# 新视频输出目录
OUTPUT_DIR="new_videos"
# 水印文件
WATERMARK="watermark.png"

# 遍历原始视频目录及其子目录中的所有视频文件
find "$INPUT_DIR" -type f -name "*.mp4" | while read -r FILE; do
    # 获取相对于原始输入目录的文件路径
    RELATIVE_PATH="${FILE#$INPUT_DIR/}"
	echo $RELATIVE_PATH
    # 确定新视频文件夹路径
    OUTPUT_PATH="$OUTPUT_DIR/$RELATIVE_PATH"
    echo $OUTPUT_PATH
    # 创建新视频文件夹（如果不存在）
    mkdir -p "$(dirname "$OUTPUT_PATH")"
    # 去除文件名中的扩展名后缀
    OUTPUT_PATH="${OUTPUT_PATH%.*}.mp4"
    echo $OUTPUT_PATH
    
    # 执行 FFmpeg 命令，将水印添加到视频中
    ffmpeg -i $FILE -i $WATERMARK -filter_complex "overlay=W-w-10:H-h-10" $OUTPUT_PATH
    wait

    # 打印处理进度
    echo "Processed $FILE -> $OUTPUT_PATH"
done
