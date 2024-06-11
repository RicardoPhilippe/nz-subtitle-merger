LoadPlugin("..\libs\VSFilterMod.dll")
LoadPlugin("..\libs\LSMASHSource.dll")
LWLibavVideoSource(".%input_video%")
#deinterlace
#denoise
TextSubMod(".%input_subtitle%", 1)
