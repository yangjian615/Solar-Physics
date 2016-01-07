; Routine to simulate event data for a given event, allowing variation of cadence and std. dev. of error

pro r_diff_simulation_195_quadratic, date, time195, f_195_quad, cadence, std_dev_195_quad, mean_x_195_quad, errors
			
	set_line_color
	
; Time calculations

	tim195 = time195 - time195[0]
	
; Calculate scatter in the ideal data

	t = findgen((max(tim195))/cadence)

	cad = 1

	dist_195_quad = f_195_quad[0] + f_195_quad[1]*t + (1./2.)*f_195_quad[2]*t^2.

	n = size(dist_195_quad[0:*:cad], /n_elements)

	array = randomn(seed, n)
	
	delta_r_195_quad = array * std_dev_195_quad + mean_x_195_quad

; Calculate & plot simulated distance data

	sim_dist_195_quad = f_195_quad[0] + f_195_quad[1]*t[0:*:cad] + (1./2.)*f_195_quad[2]*t[0:*:cad]^2. $
		+ delta_r_195_quad

	x = findgen((max(tim195))/cadence)

	h_error = replicate(std_dev_195_quad, n)

	quad_fit_195 = 'p[0] + p[1] * x + (1./2.)*p[2]*x^2.'

	pi = replicate({fixed:0, limited:[0,0], limits:[0.D,0.D]},3)
	pi(0).limited(0) = 1
	pi(0).limits(0) = 0.
	pi(1).limited(0) = 1
	pi(1).limits(0) = 0.01
	pi(1).limited(1) = 1
	pi(1).limits(1) = 0.5
	pi(2).limited(0) = 1
	pi(2).limits(0) = -0.00025
	pi(2).limited(1) = 1
	pi(2).limits(1) = 0.00025

    fit_195_quad = mpfitexpr(quad_fit_195, t[0:*:cad], sim_dist_195_quad, h_error, [sim_dist_195_quad[0], 0.2, 0.00005], $
    		perror=perror, parinfo = pi, bestnorm = bestnorm_195_quad, /quiet)

	dist_195_fit_quad = fit_195_quad[0] + fit_195_quad[1]*x + (1./2.)*fit_195_quad[2]*x^2.

	res_dist_195_fit_quad = fit_195_quad[0] + fit_195_quad[1]*t[0:*:cad] + (1./2.)*fit_195_quad[2]*t[0:*:cad]^2.

	res_d_195_quad = sim_dist_195_quad - res_dist_195_fit_quad
	
	error_d_195_quad = stddev(res_d_195_quad)

	plot, t[0:*:cad], sim_dist_195_quad, xr = [min(t[0:*:cad]) - 10, max(t[0:*:cad]) + 10], $
		ytitle = '!6Simulated distance [!6Mm]', yrange = [0, max(sim_dist_195_quad)+100], $
		background = 1, color = 0, psym = 2, charsize = 2, xstyle = 1, ystyle = 1, thick = 2, $
		title = '195A Quadratic fit Sim. dist. plot ' + num2str(date) + ' , Standard Deviation = ' + $
		num2str(std_dev_195_quad) + ' , Data spread = ' + num2str(error_d_195_quad)

	error_195_quad = replicate(std_dev_195_quad, n)

	oploterr, t[0:*:cad], sim_dist_195_quad, error_195_quad, /nohat, /noconnect, errthick = 2, errcolor = 0

	oplot, t, dist_195_quad, linestyle = 0, thick = 2, color = 0

	oplot, x, dist_195_fit_quad, linestyle = 4, color = 3, thick = 2

	legend, ['Ideal: r(t) = ' + num2str(f_195_quad[0]) + ' + ' + num2str(f_195_quad[1]) + 't + ' + $
				num2str(f_195_quad[2]) + 't!U2!N', 'Fit: r(t) = ' + num2str(fit_195_quad[0]) + ' + ' $
				+ num2str(fit_195_quad[1]) + 't + '+ num2str(fit_195_quad[2]) + 't!U2!N'], $
				textcolors = [0, 3], /bottom, /right, charsize = 1.5, /clear, outline_color = 0

; Use fit parameters as basis for ideal velocity

	x = findgen((max(tim195))/cadence)

	v_sim_195_quad = 1000.*(f_195_quad[1] + f_195_quad[2]*x)

	v_195_ideal_quad = v_sim_195_quad

; Calculate numerically differentiated data

	t_cad = t[0:*:cad]

	d_y_f = sim_dist_195_quad[1:max(n)-1] - sim_dist_195_quad[0:max(n)-2]

	d_x_f = t_cad[1:max(n)-1] - t_cad[0:max(n)-2]

	v_195_deriv_quad = 1000.*((d_y_f)/(d_x_f))
	
	deltav_195_deriv = abs(v_sim_195_quad - v_195_deriv_quad)

; Constant a fit to velocity data

	x = findgen((max(tim195))/cadence)

	h_error = replicate(std_dev_195_quad, max(tim195))

	v_quad_fit_195 = 'p[0] + p[1]*x'

	pi = replicate({fixed:0, limited:[0,0], limits:[0.D,0.D]},2)
	pi(0).limited(0) = 1
	pi(0).limits(0) = 10
	pi(0).limited(1) = 1
	pi(0).limits(1) = 500
	pi(1).limited(0) = 1
	pi(1).limits(0) = -0.25
	pi(1).limited(1) = 1
	pi(1).limits(1) = 0.25

    f_195_v_quad = mpfitexpr(v_quad_fit_195, t_cad[0:max(n)-2], v_195_deriv_quad, h_error, $
    		[v_195_ideal_quad[0], 0.05], perror=perror, parinfo = pi, bestnorm = bestnorm_195_v_quad, /quiet)

	v_195_fit_quad = f_195_v_quad[0] + f_195_v_quad[1]*x

	res_v_195_fit_quad = f_195_v_quad[0] + f_195_v_quad[1]*t_cad[0:max(n)-2]

	res_v_195_quad = v_195_deriv_quad - res_v_195_fit_quad

	error_v_195_quad = stddev(res_v_195_quad)

; Plot of velocity

	plot, t_cad[1:max(n)-2], v_195_deriv_quad, xr = [min(t[0:*:cad]) - 10, max(t[0:*:cad]) + 10], $
		ytitle = '!6Velocity [!6kms!U-1!N]', yrange = [min(v_195_deriv_quad)-100, max(v_195_deriv_quad)+100], $
		background = 1, color = 0, psym = 2, charsize = 2, xstyle = 1, ystyle = 1, thick = 2, $
		title = '195A Quadratic fit Sim. vel. plot ' + num2str(date) + ' , Deriv error = ' + $
		num2str(mean(deltav_195_deriv)) + ' , Data spread = ' + num2str(error_v_195_quad)

	error_v_195 = replicate(mean(deltav_195_deriv), size(v_195_deriv_quad, /n_elements))

	oploterr, t_cad[1:max(n)-2], v_195_deriv_quad, error_v_195, /nohat, /noconnect, errthick = 2, errcolor = 0

; Over-plot the ideal velocity line

	oplot, x, v_195_ideal_quad, linestyle = 2, color = 0, thick = 2

	oplot, x, v_195_fit_quad, linestyle = 4, color = 3, thick = 2

	legend, ['Ideal: v(t) = ' + num2str(1000*f_195_quad[1]) + ' + ' + num2str(1000*f_195_quad[2]) + 't', $
				'Fit: v(t) = ' + num2str(f_195_v_quad[0]) + ' + ' + num2str(f_195_v_quad[1]) + 't'], $
				textcolors = [0, 3], /bottom, /right, charsize = 1.5, /clear, outline_color = 0

; Use fit parameters as basis for ideal acceleration

	x = findgen((max(tim195))/cadence)

	a_sim_195_quad = 1e6*f_195_quad[2]

	a_195_ideal_quad = replicate(a_sim_195_quad, max(tim195))

; Calculate numerically differentiated data

	t_cadence = t_cad[1:max(n)-2]

	m = size(t_cadence, /n_elements)

	d_y_f = v_195_deriv_quad[1:max(m)-1] - v_195_deriv_quad[0:max(m)-2]

	d_x_f = t_cadence[1:max(m)-1] - t_cadence[0:max(m)-2]

	a_195_deriv_quad = 1000.*((d_y_f)/(d_x_f))
	
	deltaa_195_deriv = abs(a_sim_195_quad - a_195_deriv_quad)

; Constant a fit to acceleration data

	x = findgen((max(tim195))/cadence)

	h_error = replicate(std_dev_195_quad, max(tim195))

	a_quad_fit_195 = 'p[0]'

	pi = replicate({fixed:0, limited:[0,0], limits:[0.D,0.D]},1)
	pi(0).limited(0) = 1
	pi(0).limits(0) = -250
	pi(0).limited(1) = 1
	pi(0).limits(1) = 250

    f_195_a_quad = mpfitexpr(a_quad_fit_195, t_cadence[0:max(m)-2], a_195_deriv_quad, h_error, $
    		[a_195_ideal_quad[0]], perror=perror, parinfo = pi, bestnorm = bestnorm_195_a_quad, /quiet)

	a_195_fit_quad = replicate(f_195_a_quad[0], max(tim195))

	res_a_195_fit_quad = replicate(f_195_a_quad[0], n)

	res_a_195_quad = a_195_deriv_quad - res_a_195_fit_quad

	error_a_195_quad = stddev(res_a_195_quad)

	plot, t_cadence[1:max(m)-2], a_195_deriv_quad, xr = [min(t[0:*:cad]) - 10, max(t[0:*:cad]) + 10], $
		ytitle = '!6Acceleration [!6ms!U-2!N]', yrange = [min(a_195_deriv_quad)-100, max(a_195_deriv_quad)+100], $
		background = 1, color = 0, psym = 2, charsize = 2, xstyle = 1, ystyle = 1, thick = 2, $
		title = '195A Quadratic fit Sim. acc. plot ' + num2str(date) + ' , Deriv error = ' + $
		num2str(mean(deltaa_195_deriv)) + ' , Data spread = ' + num2str(error_a_195_quad)

	error_a_195 = replicate(mean(deltaa_195_deriv), size(a_195_deriv_quad, /n_elements))

	oploterr, t_cadence[1:max(m)-2], a_195_deriv_quad, error_a_195, /nohat, /noconnect, errthick = 2, errcolor = 0

; Over-plot the ideal acceleration line

	oplot, x, a_195_ideal_quad, linestyle = 2, color = 0, thick = 2

	oplot, x, a_195_fit_quad, linestyle = 4, color = 3, thick = 2

	legend, ['Ideal: a(t) = ' + num2str(1e6*f_195_quad[2]), 'Fit: a(t) = ' + num2str(f_195_a_quad[0])], $
				textcolors = [0, 3], /bottom, /right, charsize = 1.5, /clear, outline_color = 0

	errors = [mean(deltav_195_deriv), mean(deltaa_195_deriv)]

end
