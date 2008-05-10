%module RNG
%{
    #include "/usr/local/include/gsl/gsl_rng.h"
%}
%import "/usr/local/include/gsl/gsl_types.h"

%include "/usr/local/include/gsl/gsl_rng.h"

%perlcode %{

@EXPORT_OK = qw/ gsl_rng_alloc gsl_rng_set gsl_rng_get gsl_rng_free gsl_rng_memcpy
                 gsl_rng_fwrite gsl_rng_fread gsl_rng_clone gsl_rng_max gsl_rng_min
                 gsl_rng_name gsl_rng_size gsl_rng_state gsl_rng_print_state 
                $gsl_rng_default $$gsl_rng_knuthran $$gsl_rng_ran0 $gsl_rng_borosh13
                $gsl_rng_coveyou $gsl_rng_cmrg $gsl_rng_fishman18 $gsl_rng_fishman20 $gsl_rng_fishman2x
                $gsl_rng_gfsr4 $gsl_rng_knuthran $gsl_rng_knuthran2 $gsl_rng_knuthran2002 $gsl_rng_lecuyer21
                $gsl_rng_minstd $gsl_rng_mrg $gsl_rng_mt19937 $gsl_rng_mt19937_1999 $gsl_rng_mt19937_1998
                $gsl_rng_r250 $gsl_rng_ran0 $gsl_rng_ran1 $gsl_rng_ran2 $gsl_rng_ran3
                $gsl_rng_rand $gsl_rng_rand48 $gsl_rng_random128_bsd $gsl_rng_random128_gli $gsl_rng_random128_lib
                $gsl_rng_random256_bsd $gsl_rng_random256_gli $gsl_rng_random256_lib $gsl_rng_random32_bsd
                $gsl_rng_random32_glib $gsl_rng_random32_libc $gsl_rng_random64_bsd $gsl_rng_random64_glib 
                $gsl_rng_random64_libc $gsl_rng_random8_bsd $gsl_rng_random8_glibc $gsl_rng_random8_libc5
                $gsl_rng_random_bsd $gsl_rng_random_glibc2 $gsl_rng_random_libc5 $gsl_rng_randu
                $gsl_rng_ranf $gsl_rng_ranlux $gsl_rng_ranlux389 $gsl_rng_ranlxd1 $gsl_rng_ranlxd2 $gsl_rng_ranlxs0
                $gsl_rng_ranlxs1 $gsl_rng_ranlxs2 $gsl_rng_ranmar $gsl_rng_slatec $gsl_rng_taus $gsl_rng_taus2
                $gsl_rng_taus113 $gsl_rng_transputer $gsl_rng_tt800 $gsl_rng_uni $gsl_rng_uni32 $gsl_rng_vax
                $gsl_rng_waterman14 $gsl_rng_zuf 
              /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );
 

sub new {
    my ($class,$type, $seed) = @_;
    my $rng = gsl_rng_alloc($type);

    gsl_rng_set($rng, $seed);
    return $rng;
}


%}
