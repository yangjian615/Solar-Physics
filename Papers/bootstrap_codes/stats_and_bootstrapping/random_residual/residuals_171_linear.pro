; Routine to plot the residuals of a linear fit to the 171A data

pro residuals_171_linear, time171, residuals_171_lin, dist_arr_171, date, h_err_171_lin, std_dev_171_lin, $
		mean_x_171_lin

	set_line_color

; Time calculations

	tim171 = time171 - time171[0]

	h_error_171 = h_err_171_lin

	print, std_dev_171_lin

	plot, tim171, residuals_171_lin, xr = [min(tim171) - 100, max(tim171) + 100], /xs, psym = 2, $
			ytitle = 'Residuals (Mm)', /ys, yr = [-std_dev_171_lin - 5, std_dev_171_lin + 5], $
			xtitle = 'Time range (s)', color = 0, background = 1, charsize = 2, $
			title = 'Linear fit ' + num2str(date) + ', Std Dev = ' + num2str(std_dev_171_lin)

	IF (h_error_171[0] LE 2.*std_dev_171_lin) THEN BEGIN
		oploterr, tim171, residuals_171_lin, h_error_171, errcolor = 0, /noconnect, /nohat
	ENDIF

	oplot, [min(tim171) - 100, max(tim171) + 100], [mean_x_171_lin,mean_x_171_lin], linestyle = 0, thick = 2, color = 0

	oplot, [min(tim171) - 100, max(tim171) + 100], [std_dev_171_lin, std_dev_171_lin], linestyle = 2, thick = 2, color = 0
	oplot, [min(tim171) - 100, max(tim171) + 100], [-std_dev_171_lin, -std_dev_171_lin], linestyle = 2, thick = 2, color = 0

	legend, ['Mean = ' + num2str(mean_x_171_lin), 'Standard Deviation = ' + num2str(std_dev_171_lin)], textcolors = [3, 3], $
				/top, charsize = 1.5, /clear, outline_color = 0

; Plot of residuals

	x = findgen(std_dev_171_lin*300.) / 10. - std_dev_171_lin*3.

	res_171_lin = histogram( residuals_171_lin, loc = loc, binsize = 1 )

	plot, loc, res_171_lin, psym = 10, color = 0, background = 1, yr = [0, max(res_171_lin) + 0.25*max(res_171_lin)], $
			xr = [-3.*std_dev_171_lin, 3.*std_dev_171_lin], /xs, /ys, xtitle = 'De-trended data values (Mm)', charsize = 2, $
			ytitle = 'De-trended data probability', title = 'Normalised Probability distribution function of de-trended data'

; Plot of Probability Distribution function with same mean and standard deviation as data

	gaussian = max( res_171_lin ) * exp(-(x - mean_x_171_lin)^2./(2.*std_dev_171_lin^2.))

	oplot, x, gaussian, color = 0

	gaussian_std_dev = max( res_171_lin ) * exp(-(std_dev_171_lin - mean_x_171_lin)^2./(2.*std_dev_171_lin^2.))

	oplot, [std_dev_171_lin, std_dev_171_lin], [0, gaussian_std_dev], linestyle = 2, thick = 2, color = 0
	oplot, [-std_dev_171_lin, -std_dev_171_lin], [0, gaussian_std_dev], linestyle = 2, thick = 2, color = 0

end