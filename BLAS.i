%module BLAS

%include "typemaps.i"

%apply float *OUTPUT { float *result };
%apply double *OUTPUT { double *result };

%{
    #include "gsl/gsl_blas.h"
    #include "gsl/gsl_blas_types.h"
%}

%include "gsl/gsl_blas.h"
%include "gsl/gsl_blas_types.h"

%perlcode %{

@EXPORT_OK_level1 = qw/
                        gsl_blas_sdsdot gsl_blas_dsdot gsl_blas_sdot gsl_blas_ddot 
                        gsl_blas_cdotu gsl_blas_cdotc gsl_blas_zdotu gsl_blas_zdotc 
                        gsl_blas_snrm2 gsl_blas_sasum gsl_blas_dnrm2 gsl_blas_dasum 
                        gsl_blas_scnrm2 gsl_blas_scasum gsl_blas_dznrm2 gsl_blas_dzasum 
                        gsl_blas_isamax gsl_blas_idamax gsl_blas_icamax gsl_blas_izamax 
                        gsl_blas_sswap gsl_blas_scopy gsl_blas_saxpy gsl_blas_dswap 
                        gsl_blas_dcopy gsl_blas_daxpy gsl_blas_cswap gsl_blas_ccopy 
                        gsl_blas_caxpy gsl_blas_zswap gsl_blas_zcopy gsl_blas_zaxpy 
                        gsl_blas_srotg gsl_blas_srotmg gsl_blas_srot gsl_blas_srotm 
                        gsl_blas_drotg gsl_blas_drotmg gsl_blas_drot gsl_blas_drotm 
                        gsl_blas_sscal gsl_blas_dscal gsl_blas_cscal gsl_blas_zscal 
                        gsl_blas_csscal gsl_blas_zdscal
                    /;
@EXPORT_OK_level2 = qw/
                        gsl_blas_sgemv gsl_blas_strmv 
                        gsl_blas_strsv gsl_blas_dgemv gsl_blas_dtrmv gsl_blas_dtrsv 
                        gsl_blas_cgemv gsl_blas_ctrmv gsl_blas_ctrsv gsl_blas_zgemv 
                        gsl_blas_ztrmv gsl_blas_ztrsv gsl_blas_ssymv gsl_blas_sger 
                        gsl_blas_ssyr gsl_blas_ssyr2 gsl_blas_dsymv gsl_blas_dger 
                        gsl_blas_dsyr gsl_blas_dsyr2 gsl_blas_chemv gsl_blas_cgeru 
                        gsl_blas_cgerc gsl_blas_cher gsl_blas_cher2 gsl_blas_zhemv 
                        gsl_blas_zgeru gsl_blas_zgerc gsl_blas_zher gsl_blas_zher2 
                    /;

@EXPORT_OK_level3 = qw/
                        gsl_blas_sgemm gsl_blas_ssymm gsl_blas_ssyrk gsl_blas_ssyr2k 
                        gsl_blas_strmm gsl_blas_strsm gsl_blas_dgemm gsl_blas_dsymm 
                        gsl_blas_dsyrk gsl_blas_dsyr2k gsl_blas_dtrmm gsl_blas_dtrsm 
                        gsl_blas_cgemm gsl_blas_csymm gsl_blas_csyrk gsl_blas_csyr2k 
                        gsl_blas_ctrmm gsl_blas_ctrsm gsl_blas_zgemm gsl_blas_zsymm 
                        gsl_blas_zsyrk gsl_blas_zsyr2k gsl_blas_ztrmm gsl_blas_ztrsm 
                        gsl_blas_chemm gsl_blas_cherk gsl_blas_cher2k gsl_blas_zhemm 
                        gsl_blas_zherk gsl_blas_zher2k 
                    /;
@EXPORT_OK = (@EXPORT_OK_level1, @EXPORT_OK_level2, @EXPORT_OK_level3);
%EXPORT_TAGS = (
                all    => [ @EXPORT_OK ],
                level1 => [ @EXPORT_OK_level1 ],  
                level2 => [ @EXPORT_OK_level2 ],  
                level3 => [ @EXPORT_OK_level3 ],  
               );
__END__

=head1 NAME

Math::GSL::BLAS - Basic Linear Algebra Subprograms

=head1 SYNOPSIS

use Math::GSL::QRNG qw/:all/;

=head1 DESCRIPTION

The functions of this module are divised into 3 levels:

=head2 Level 1 - Vector operations

=over 3  

=item C<gsl_blas_sdsdot>

=item C<gsl_blas_dsdot>

=item C<gsl_blas_sdot>

=item C<gsl_blas_ddot($x, $y)> - This function computes the scalar product x^T y for the vectors $x and $y. The function returns two values, the first is 0 if the operation suceeded, 1 otherwise and the second value is the result of the computation. 

=item C<gsl_blas_cdotu>

=item C<gsl_blas_cdotc>

=item C<gsl_blas_zdotu($x, $y, $dotu)> - This function computes the complex scalar product x^T y for the complex vectors $x and $y, returning the result in the complex number $dotu. The function returns 0 if the operation suceeded, 1 otherwise.

=item C<gsl_blas_zdotc($x, $y, $dotc)> - This function computes the complex conjugate scalar product x^H y for the complex vectors $x and $y, returning the result in the complex number $dotc. The function returns 0 if the operation suceeded, 1 otherwise.

=item C<gsl_blas_snrm2> 
=item C<gsl_blas_sasum>

=item C<gsl_blas_dnrm2($x)> - This function computes the Euclidean norm ||x||_2 = \sqrt {\sum x_i^2} of the vector $x. 

=item C<gsl_blas_dasum($x)> - This function computes the absolute sum \sum |x_i| of the elements of the vector $x. 

=item C<gsl_blas_scnrm2>

=item C<gsl_blas_scasum>

=item C<gsl_blas_dznrm2($x)> - This function computes the Euclidean norm of the complex vector $x, ||x||_2 = \sqrt {\sum (\Re(x_i)^2 + \Im(x_i)^2)}.

=item C<gsl_blas_dzasum($x)> - This function computes the sum of the magnitudes of the real and imaginary parts of the complex vector $x, \sum |\Re(x_i)| + |\Im(x_i)|. 

=item C<gsl_blas_isamax>

=item C<gsl_blas_idamax>

=item C<gsl_blas_icamax>

=item C<gsl_blas_izamax >

=item C<gsl_blas_sswap>

=item C<gsl_blas_scopy>

=item C<gsl_blas_saxpy>

=item C<gsl_blas_dswap($x, $y)> - This function exchanges the elements of the vectors $x and $y. The function returns 0 if the operation suceeded, 1 otherwise.

=item C<gsl_blas_dcopy($x, $y)> - This function copies the elements of the vector $x into the vector $y. The function returns 0 if the operation suceeded, 1 otherwise.

=item C<gsl_blas_daxpy($alpha, $x, $y)> - These functions compute the sum $y = $alpha * $x + $y for the vectors $x and $y. 

=item C<gsl_blas_cswap>

=item C<gsl_blas_ccopy >

=item C<gsl_blas_caxpy>

=item C<gsl_blas_zswap>

=item C<gsl_blas_zcopy>

=item C<gsl_blas_zaxpy >

=item C<gsl_blas_srotg>

=item C<gsl_blas_srotmg>

=item C<gsl_blas_srot>

=item C<gsl_blas_srotm >

=item C<gsl_blas_drotg>

=item C<gsl_blas_drotmg>

=item C<gsl_blas_drot($x, $y, $c, $s)> - This function applies a Givens rotation (x', y') = (c x + s y, -s x + c y) to the vectors $x, $y. 

=item C<gsl_blas_drotm >

=item C<gsl_blas_sscal>

=item C<gsl_blas_dscal($alpha, $x)> - This function rescales the vector $x by the multiplicative factor $alpha.

=item C<gsl_blas_cscal>

=item C<gsl_blas_zscal >

=item C<gsl_blas_csscal>

=item C<gsl_blas_zdscal>

=back

=head2 Level 2 - Matrix-vector operations

=over 3 

=item C<gsl_blas_sgemv>

=item C<gsl_blas_strmv >

=item C<gsl_blas_strsv>

=item C<gsl_blas_dgemv>

=item C<gsl_blas_dtrmv>

=item C<gsl_blas_dtrsv >

=item C<gsl_blas_cgemv >

=item C<gsl_blas_ctrmv>

=item C<gsl_blas_ctrsv>

=item C<gsl_blas_zgemv >

=item C<gsl_blas_ztrmv>

=item C<gsl_blas_ztrsv>

=item C<gsl_blas_ssymv>

=item C<gsl_blas_sger >

=item C<gsl_blas_ssyr>

=item C<gsl_blas_ssyr2>

=item C<gsl_blas_dsymv>

=item C<gsl_blas_dger >

=item C<gsl_blas_dsyr>

=item C<gsl_blas_dsyr2>

=item C<gsl_blas_chemv>

=item C<gsl_blas_cgeru >

=item C<gsl_blas_cgerc>

=item C<gsl_blas_cher>

=item C<gsl_blas_cher2>

=item C<gsl_blas_zhemv >

=item C<gsl_blas_zgeru>

=item C<gsl_blas_zgerc>

=item C<gsl_blas_zher>

=item C<gsl_blas_zher2 >

=back

=head2 Level 3 - Matrix-matrix operations

=over 3 

=item C<gsl_blas_sgemm>

=item C<gsl_blas_ssymm>

=item C<gsl_blas_ssyrk>

=item C<gsl_blas_ssyr2k >

=item C<gsl_blas_strmm>

=item C<gsl_blas_strsm>

=item C<gsl_blas_dgemm>

=item C<gsl_blas_dsymm >

=item C<gsl_blas_dsyrk>

=item C<gsl_blas_dsyr2k>

=item C<gsl_blas_dtrmm>

=item C<gsl_blas_dtrsm >

=item C<gsl_blas_cgemm>

=item C<gsl_blas_csymm>

=item C<gsl_blas_csyrk>

=item C<gsl_blas_csyr2k >

=item C<gsl_blas_ctrmm>

=item C<gsl_blas_ctrsm>

=item C<gsl_blas_zgemm>

=item C<gsl_blas_zsymm >

=item C<gsl_blas_zsyrk>

=item C<gsl_blas_zsyr2k>

=item C<gsl_blas_ztrmm>

=item C<gsl_blas_ztrsm >

=item C<gsl_blas_chemm>

=item C<gsl_blas_cherk>

=item C<gsl_blas_cher2k>

=item C<gsl_blas_zhemm >

=item C<gsl_blas_zherk >

=item C<gsl_blas_zher2k >

=back

You have to add the functions you want to use inside the qw /put_funtion_here /. 
You can also write use Math::GSL::PowInt qw/:all/ to use all avaible functions of the module. 
Other tags are also avaible, here is a complete list of all tags for this module :

=over 3

=item C<level1>

=item C<level2>

=item C<level3> 

=back

For more informations on the functions, we refer you to the GSL offcial documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>

Tip : search on google: site:http://www.gnu.org/software/gsl/manual/html_node/ name_of_the_function_you_want


=head1 EXAMPLES

=head1 AUTHOR

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}
