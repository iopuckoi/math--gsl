package Math::GSL::Randist::Test;
use base q{Test::Class};
use Test::Most tests => 18;
use Math::GSL::Test    qw/:all/;
use Math::GSL::RNG     qw/:all/;
use Math::GSL::Errno   qw/:all/;
use Math::GSL::Randist qw/:all/;
use Math::GSL::Const   qw/ $M_PI /;
use List::Util qw/sum/;
use Data::Dumper;
BEGIN { gsl_set_error_handler_off() }

use strict;
use warnings;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{rng} = Math::GSL::RNG->new;
}

sub teardown : Test(teardown) {
    my $self = shift;
    undef $self->{rng};
}

sub GSL_RAN_PDF : Tests(4) {
    ok_similar(0, gsl_ran_bernoulli_pdf(2, 0.5), 'gsl_ran_bernoulli_pdf(2,0.5)=0' );
    ok_similar( gsl_ran_gaussian_pdf(0,1), 1/sqrt(2*$M_PI), 'gsl_ran_gaussian_pdf' );
    ok_similar( gsl_ran_ugaussian_pdf(0), 1/sqrt(2*$M_PI), 'gsl_ran_ugaussian_pdf' );
    ok_similar( gsl_ran_chisq_pdf(1,2), exp(-1/2)/2, 'gsl_ran_chisq_pdf' );
}

sub GSL_RAN_BASIC : Tests {
    my $self = shift;
    lives_ok( sub{ gsl_ran_lognormal($self->{rng}->raw, 0.1, 0.2 ) },
        'gsl_ran_lognormal works');
}

sub GSL_RAN_DIRICHLET : Tests(4) {
    my $self = shift;
    my $alpha = [ 1.0, 2.0 ];
    my $theta = [ 2.0, 3.0 ];

    lives_ok( sub{ gsl_ran_dirichlet($self->{rng}->raw, $alpha ) }, 'gsl_ran_dirichlet');
    lives_ok( sub{ gsl_ran_dirichlet_pdf($theta, $alpha ) }, 'gsl_ran_dirichlet_pdf');
    lives_ok( sub{ gsl_ran_dirichlet_lnpdf($theta, $alpha ) }, 'gsl_ran_dirichlet_lnpdf');

    ok_similar(sum(@{gsl_ran_dirichlet($self->{rng}->raw, $alpha)}), 1.0, 'sum(gsl_ran_dirichlet(alpha))=1');
}
sub GSL_RAN_MULTINOMIAL : Tests(4) {
    my $self = shift;
    my $prob = [ .25, .25, .5 ];
    my $N = 100;
    my $counts = [100, 112, 220];

    lives_ok( sub{ gsl_ran_multinomial($self->{rng}->raw, $prob, $N) }, 'gsl_ran_multinomial');
    lives_ok( sub{ gsl_ran_multinomial_pdf($counts,$prob ) }, 'gsl_ran_multinomial_pdf');
    lives_ok( sub{ gsl_ran_multinomial_lnpdf($counts,$prob ) }, 'gsl_ran_multinomial_lnpdf');

    ok_similar(sum(@{gsl_ran_multinomial($self->{rng}->raw, $prob, $N )}), 100, 'gsl_ran_multinomial(N,p)=N');
}

sub magnitude{ return sum map {$_ * $_} @_; }

sub GSL_RAN_DIR : Tests(5) {
    my $self = shift;
    my $raw = $self->{rng}->raw;
    lives_ok( sub{ gsl_ran_dir_nd($self->{rng}->raw, 20) }, 'gsl_ran_dir_nd');
    ok_similar(magnitude(@{gsl_ran_dir_nd($raw, 20)}), 1.0, 'norm(gsl_ran_dir_nd(N)|^2=1.0');
    ok_similar(magnitude(gsl_ran_dir_2d($raw)), 1.0, '|gsl_ran_dir_2d()|^2=1.0');
    ok_similar(magnitude(gsl_ran_dir_2d_trig_method($raw)), 1.0, '|gsl_ran_dir_2d()|^2=1.0');
    ok_similar(magnitude(gsl_ran_dir_3d($raw)), 1.0, '|gsl_ran_dir_3d()|^2=1.0');
}

Test::Class->runtests;
