LoadPlugin("..\libs\VSFilterMod.dll")
LoadPlugin("..\libs\LSMASHSource.dll")
clip = LWLibavVideoSource(".%input_video%").ConvertBits(8)
#deinterlace
#crop
new_width = Round(clip.Width * 720.0 / clip.Height)
clip = clip.LanczosResize(new_width, 720)
#denoise
clip = clip.TextSubMod(".%input_subtitle%", 1)
clip
