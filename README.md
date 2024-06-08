# Projeto de Geração de Vídeos

Este projeto permite a geração de vídeos em diferentes resoluções utilizando scripts personalizados. Ele mescla arquivos `.mkv` e legendas `.ass` com o mesmo nome que ficam na pasta `files`.

## Dependências

Para executar os scripts, é necessário ter as seguintes dependências instaladas:

- **FFmpeg**: Ferramenta de linha de comando para manipulação de arquivos de vídeo e áudio.
- **AviSynth**: Sistema de scripts para pós-produção de vídeo.

## Instalação das Dependências

### FFmpeg

Você pode instalar o FFmpeg seguindo as instruções do [site oficial](https://ffmpeg.org/download.html).

### AviSynth

Você pode baixar e instalar o AviSynth a partir do [site oficial](http://avisynth.nl/index.php/Main_Page).

## Como Usar

### Gerar Arquivos 1080p

Para gerar arquivos em resolução 1080p, execute o seguinte comando:

```bash
./generate_1080p.sh
```
### Gerar Arquivos 720p

Para gerar arquivos em resolução 720p, execute o seguinte comando:

```bash
./generate_720p.sh
```
