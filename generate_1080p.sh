#!/bin/bash

# Directory paths
input_dir="$(dirname "$0")/files"
output_dir="$(dirname "$0")/output"
script_dir="$(dirname "$0")/scripts"

# Prepare the Avisynth script template
avs_template="$script_dir/1080p_template.avs"
avs_script="$script_dir/1080p.avs"

# Loop through MKV files in the input directory
for input_video in "$input_dir"/*.mkv; do
    input_subtitle="${input_video%.mkv}.ass"
    output_video="$output_dir/$(basename "${input_video%.mkv}.1080p.mkv")"
    temp_video="$output_dir/temp_video_with_audio.mkv"

    # Print current file being processed
    echo "Processing $input_video"

    # Create a new Avisynth script with the correct parameters
    while IFS= read -r line; do
        line="${line//%input_video%/$input_video}"
        line="${line//%input_subtitle%/$input_subtitle}"
        echo "$line"
    done < "$avs_template" > "$avs_script"

    # Print the generated Avisynth script for debugging
    echo "Generated Avisynth script:"
    cat "$avs_script"
    
    # Run ffmpeg to encode video
    ffmpeg -hide_banner -i "$avs_script" -c:v h264_nvenc -cq 23 "$output_video"
    
    # Print output video status
    echo "Created output video: $output_video"

    # Copy audio tracks from input video to temporary video with audio
    ffmpeg -hide_banner -i "$output_video" -i "$input_video" -c copy -map 0:v:0 -map 1:a "$temp_video"

    # Replace original output video with the new one
    mv -f "$temp_video" "$output_video"

    echo "Audio tracks copied successfully for $input_video!"
done
