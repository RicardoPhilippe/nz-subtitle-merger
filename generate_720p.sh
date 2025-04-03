#!/bin/bash

# Diretórios
input_dir="$(dirname "$0")/files"
output_dir="$(dirname "$0")/output"
script_dir="$(dirname "$0")/scripts"

# Template do script Avisynth
avs_template="$script_dir/720p_template.avs"
avs_script="$script_dir/720p.avs"

# Loop pelos arquivos MKV na pasta de entrada
for input_video in "$input_dir"/*.mkv; do
    input_subtitle="${input_video%.mkv}.ass"
    output_video="$output_dir/$(basename "${input_video%.mkv}.720p.mkv")"
    temp_video="$output_dir/temp_video_with_audio.mkv"

    # Exibe o arquivo atual sendo processado
    echo "Processing $input_video"

    # Cria o script Avisynth com os parâmetros corretos
    while IFS= read -r line; do
        line="${line//%input_video%/$input_video}"
        line="${line//%input_subtitle%/$input_subtitle}"
        echo "$line"
    done < "$avs_template" > "$avs_script"

    # Exibe o script Avisynth gerado para debug
    echo "Generated Avisynth script:"
    cat "$avs_script"
    
    # Executa o ffmpeg para codificar o vídeo
    ffmpeg -hide_banner -y -i "$avs_script" -c:v h264_nvenc -cq 23 "$output_video"
    
    echo "Created output video: $output_video"

    # Copia as faixas de áudio do vídeo de entrada para um arquivo temporário
    ffmpeg -hide_banner -y -i "$output_video" -i "$input_video" -c copy -map 0:v:0 -map 1:a "$temp_video"

    # Substitui o arquivo de saída original pelo arquivo com áudio
    mv -f "$temp_video" "$output_video"

    echo "Audio tracks copied successfully for $input_video!"

    # Calcula o CRC do arquivo de saída usando cksum
    crc=$(cksum "$output_video" | awk '{print $1}')
    # Extrai o nome do arquivo e seus componentes
    filename=$(basename "$output_video")
    dirname=$(dirname "$output_video")
    base="${filename%.*}"   # remove a extensão
    ext="${filename##*.}"
    # Substitui ".720p" por " [720p]" e adiciona o CRC
    name="${base/.720p/ [720p]}"
    # Adiciona o prefixo [NewWave] e o CRC no nome do arquivo
    new_filename="[NewWave] ${name} [${crc}].${ext}"
    mv -f "$output_video" "$dirname/$new_filename"
    
    echo "Renamed output video to: $dirname/$new_filename"
done
