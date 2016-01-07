pro warp

restore, '~/PhD/Data_sav_files/da.sav'
restore, '~/PhD/Data_sav_files/in.sav'

loadct, 8

sz = size(da, /dim)

entry = fltarr(sz[0],sz[1],sz[2])

for i=0,sz[2]-1 do begin
	plot_image, da[*,*,i]
	entry[*,*,i] = tvrd()
endfor
	
for i=0,sz[2]-2 do begin

	count = i
	
	plot_image, entry[*,*,i]
	im = tvrd()
	
	while(i lt count) do begin
		plot_image, im
		im = tvrd()
		i = i+1
	endwhile

	
endfor





end
