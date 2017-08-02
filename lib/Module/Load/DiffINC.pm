package Module::Load::DiffINC;

# DATE
# VERSION

sub import {
    my $pkg = shift;

    my %INC0 = %INC;
    for my $mod (@_) {
        (my $mod_pm = "$mod.pm") =~ s!::!/!g;
        require $mod_pm;
    }
    for my $k (sort keys %INC0) {
        next if exists $INC{$k};
        print "-$k\t$INC0{$k}\n";
    }
    for my $k (sort keys %INC) {
        next if exists $INC0{$k};
        print "+$k\t$INC{$k}\n";
    }
}

1;
# ABSTRACT: Load a module and show difference in %INC before vs after

=head1 SYNOPSIS

On the command-line:

 % perl -MModule::Load::DiffINC=Log::ger::Util -e1
 +Log/ger.pm     /home/ujang/perl5/perlbrew/perls/perl-5.26.0/lib/site_perl/5.26.0/Log/ger.pm
 +Log/ger/Heavy.pm       /home/ujang/perl5/perlbrew/perls/perl-5.26.0/lib/site_perl/5.26.0/Log/ger/Heavy.pm
 +Log/ger/Util.pm        /home/ujang/perl5/perlbrew/perls/perl-5.26.0/lib/site_perl/5.26.0/Log/ger/Util.pm
 +strict.pm      /home/ujang/perl5/perlbrew/perls/perl-5.26.0/lib/5.26.0/strict.pm
 +warnings.pm    /home/ujang/perl5/perlbrew/perls/perl-5.26.0/lib/5.26.0/warnings.pm


=head1 DESCRIPTION

This module will record C<%INC>, load (using C<require()>) all modules specified
in the import argument, then compare C<%INC> with the originally recorded before
loading the modules.
