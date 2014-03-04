#!/usr/bin/perl -w
# (c) 2008, HuKi Huang. <Huki_Huang@htc.com>

my $filename = '';
my $tmp;
my $i;

$tmp = 0;
open CHECK, "whereis dos2unix |";
while(<CHECK>) {
    if ($_ =~ m/^dos2unix:\n/) {
        print "Please install tofrodos package,\n";
        print "Ex: sudo aptitude install tofrodos\n";
        $tmp++;
    }
}
open CHECK, "git --version |";
while(<CHECK>) {
    if (!($_ =~ m/^git version 1.5.[4-9]/) &&
        !($_ =~ m/^git version [2-9]/) &&
        !($_ =~ m/^git version 1.[6-9]/)) {
        print "1. Please install git-core version > 1.5.4.3.\n";
        goto exit_script;
        $tmp++;
    }
}
close CHECK;
if ($tmp > 0) {
    goto exit_script;
}

open GIT, "git diff --name-status -r HEAD^..HEAD |";
@GIT_data = <GIT>;
close GIT;

check_file:
foreach $commit (@GIT_data) {
    # Get "git diff --name-status HEAD^..HEAD" result
    $filename = $commit;
    # Only process Modify & Add files
    $filename =~ s/^[M|A]\t//;
    $filename =~ s/\n$//;
    print "=> ".$filename."\n";

    if (($filename =~ m/\.(h|c|mk)$/) or ($filename =~ m/^Makefile$/)) {
    # Dos format to unix format
    # Must install tofrodos package
        if ((-w $filename) or (-w $filename)) {
            print "dos2unix file: ".$filename."\n";
            system("dos2unix $filename");
        }
        else {
            print "No write permission for $filename.\n";
        }

    # If not Makefile, to run Lindent check code format
    # Must install indent package
#        if (!($filename =~ m/\.mk$/) && !($filename =~ m/^Makefile$/)) {
#            print "Lindent file: ".$filename."\n";
#            system("scripts/Lindent $filename");
#        }

    # Chmod file permission to 0644
        if ((-x $filename) or (-X $filename)) {
            print "chmod file: ".$filename."\n";
            system("chmod 644 $filename");
        }
    }
}

# Get commit value
open COMMIT, "git log HEAD^..HEAD | grep commit |";
$COMMIT_data = <COMMIT>;
close COMMIT;
$COMMIT_data =~ s/^commit //;
$COMMIT_data =~ s/\n$//;
# git commit -C can reuse message
system("git commit --amend -a -C $COMMIT_data");

# Must setup git config user.name "YourUserName"
# Must setup git config user.email YourMail
open PATCH, "git format-patch -1 -s |";
$PATCH_data = <PATCH>;
close PATCH;
$PATCH_data =~ s/\n$//;
print "\nCheck: $PATCH_data\n==>\n\n";
$tmp = 0;
open CHECK, "checkpatch.pl $PATCH_data |";
while (<CHECK>) {
    if ($_ =~ m/^total: 0 errors, 0 warnings, /) {
        $tmp++;
    }
    print $_;
}
close CHECK;

if ($tmp == 1) {
    print "\n";
    goto exit_script;
}

print "\nDo you want to check patch?\n";
print "Press \"Enter\" to continue, press \"q|Q\" to exit.\n";
while (<>) {
    if ($_ =~ m/^(q|Q)\n$/) {
        goto exit_script;
    } elsif ($_ =~ m/^\n$/) {
        system("rm $PATCH_data");
        goto check_file;
    }
}

exit_script:
exit();
