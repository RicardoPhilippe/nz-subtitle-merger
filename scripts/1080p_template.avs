LoadPlugin("..\libs\VSFilterMod.dll")
LoadPlugin("..\libs\LSMASHSource.dll")
clip = LWLibavVideoSource(".%input_video%").ConvertBits(8)
#deinterlace
#denoise
clip = clip.TextSubMod(".%input_subtitle%", 1)
clip
