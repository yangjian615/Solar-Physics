; Make plots for the AandA paper using toggle.

; Last Edited: 30-01-08

pro make_plots4


	!p.multi=[0,2,4]

	toggle;, /color, /landscape

	k=2
	
	fls = file_search('~/phd/data_vso/20000102/c2/normalised_rm/*fts')
	mreadfits, fls[k], temp, da
	fls = file_search('~/phd/data_Vso/20000102/c2/*fts')
	mreadfits, fls[k], in

	restore, '~/PhD/data_vso/20000102/errorsc2.sav'
	restore, '~/PhD/data_vso/20000102/c2/normalised_rm/edg_images/my_fronts.sav'
	
;	ell_kinematics_printout3, in, da, edges, errorsc2, 2
	
	pos = [0, 0.8, 0.2, 1]
	front_ell_kinematics_printout_chose4, my_fronts[*,*,k], errorsc2[k], in, da, 2, pos
	;**********

	k=8
	fls = file_search('~/phd/data_vso/20000102/c3/normalised_rm/*fts')
	mreadfits, fls[k], temp, da
	fls = file_search('~/phd/data_vso/20000102/c3/*fts')
	mreadfits, fls[k], in

	restore, '~/phd/data_vso/20000102/errorsc3.sav'
	restore, '~/phd/data_vso/20000102/c3/normalised_rm/edg_images/my_fronts.sav'

;	ell_kinematics_printout3, in, da, edges[*,*,2:*], errorsc3, 2

	pos = [0.2, 0.8, 0.4, 1]
	front_ell_kinematics_printout_chose4, my_fronts[*,*,k], errorsc3[k], in, da, 2, pos
	;***********

	k=2
	fls = file_search('~/phd/data_vso/20000118/c2/normalised_rm/*fts')
        mreadfits, fls[k], temp, da
        fls = file_search('~/phd/data_Vso/20000118/c2/*fts')
        mreadfits, fls[k], in

        restore, '~/PhD/data_vso/20000118/errorsc2.sav'
	restore, '~/phd/data_vso/20000118/c2/normalised_rm/edg_images/my_fronts.sav'
					        
;        ell_kinematics_printout3, in, da, edges, errorsc2, 2

        pos = [0, 0.66, 0.2, 0.86]
        front_ell_kinematics_printout_chose4, my_fronts[*,*,k], errorsc2[k], in, da, 2, pos
	;*****

	k=14
        fls = file_search('~/phd/data_vso/20000118/c3/normalised_rm/*fts')
        mreadfits, fls[14], temp, da
        fls = file_search('~/phd/data_vso/20000118/c3/*fts')
        mreadfits, fls[14], in

        restore, '~/phd/data_vso/20000118/errorsc3.sav'
        restore, '~/phd/data_vso/20000118/c3/normalised_rm/edg_images/my_fronts.sav'

;        ell_kinematics_printout3, in, da, edges[*,*,*], errorsc3, 2

        pos = [0.2, 0.66, 0.4, 0.86]
        front_ell_kinematics_printout_chose4, my_fronts[*,*,k], errorsc3[k], in, da, 2, pos

	;**********

	k=5
	fls = file_search('~/phd/data_vso/20000418/c2/normalised_rm/*fts')
        mreadfits, fls[k], temp, da
        fls = file_search('~/phd/data_Vso/20000418/c2/*fts')
        mreadfits, fls[k], in

        restore, '~/PhD/data_vso/20000418/errorsc2.sav'

        restore, '~/PhD/data_vso/20000418/c2/normalised_rm/edg_images/my_fronts.sav'
					        
;        ell_kinematics_printout3, in, da, edges, errorsc2, 2

        pos = [0, 0.52, 0.2, 0.72]
        front_ell_kinematics_printout_chose4, my_fronts[*,*,k], errorsc2[k], in, da, 2, pos
        ;**********

	k=6
	fls = file_search('~/phd/data_vso/20000418/c3/normalised_rm/*fts')
        mreadfits, fls[k], temp, da
        fls = file_search('~/phd/data_vso/20000418/c3/*fts')
        mreadfits, fls[k], in 

        restore, '~/phd/data_vso/20000418/errorsc3.sav'
        restore, '~/phd/data_vso/20000418/c3/normalised_rm/edg_images/my_fronts.sav'

;        ell_kinematics_printout3, in, da, edges[*,*,*], errorsc3, 2

        pos = [0.2, 0.52, 0.4, 0.72] 
        front_ell_kinematics_printout_chose4, my_fronts[*,*,k], errorsc3[k], in, da, 2, pos

	;**********

	k=2
	fls = file_search('~/phd/data_vso/20010423/c2/cme1/normalised_rm/*fts')
        mreadfits, fls[k], temp, da
        fls = file_search('~/phd/data_Vso/20010423/c2/cme1/*fts')
        mreadfits, fls[k], in

        restore, '~/PhD/data_vso/20010423/errorsc2.sav'

        restore, '~/PhD/data_vso/20010423/c2/cme1/normalised_rm/edg_images/my_fronts.sav'

;        ell_kinematics_printout3, in, da, edges, errorsc2, 2

        pos = [0, 0.38, 0.2, 0.58]
        front_ell_kinematics_printout_chose4, my_fronts[*,*,k], errorsc2[k], in, da, 2, pos
        ;**********

	k=6	
	fls = file_search('~/phd/data_vso/20010423/c3/cme1/normalised_rm/*fts')
        mreadfits, fls[k], temp, da
        fls = file_search('~/phd/data_vso/20010423/c3/cme1/*fts')
        mreadfits, fls[k], in

        restore, '~/phd/data_vso/20010423/errorsc3.sav'
        restore, '~/phd/data_vso/20010423/c3/cme1/normalised_rm/edg_images/my_fronts.sav'

;        ell_kinematics_printout3, in, da, edges[*,*,*], errorsc3, 2

        pos = [0.2, 0.38, 0.4, 0.58]
        front_ell_kinematics_printout_chose4, my_fronts[*,*,k], errorsc3[k], in, da, 2, pos

         ;**********
														 
	toggle
	
end
