LoadPlugin("..\libs\VSFilterMod.dll")
LoadPlugin("..\libs\LSMASHSource.dll")
LWLibavVideoSource(".%input_video%")
#deinterlace
#crop
LanczosResize(1280,720) # Lanczos (Sharp)
#denoise
TextSubMod(".%input_subtitle%", 1)
