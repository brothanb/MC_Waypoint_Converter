#!/usr/bin/perl

# convert voxelmap waypoints to xaero format

open(IF,"<185.38.151.238~colon~25567.points") || die "Error opening voxel waypoints.";

%waypoints = ();

while(<IF>) {
   chomp();
   last if /^$/;
   next if $_ !~ /^name:/;
   @list = split(',');
   %point = ();
   foreach $p (@list) {
      ($n, $v) = split(':', $p, 2);
      $point{$n} = $v;
      }
   $point{'dimensions'} =~ s/\#\cM$//;
   @dims = split('#',$point{'dimensions'});
   foreach $dim (@dims) {
      $waypoints{$dim}{$point{'name'}}{'name'} = $point{'name'};
      $waypoints{$dim}{$point{'name'}}{'X'} = $point{'x'};
      $waypoints{$dim}{$point{'name'}}{'Z'} = $point{'z'};
      $waypoints{$dim}{$point{'name'}}{'Y'} = $point{'y'};
      }
   }
close(IF);

undef $point;

mkdir("Multiplayer_185.38.151.238");
mkdir("Multiplayer_185.38.151.238/overworld");
mkdir("Multiplayer_185.38.151.238/the_nether");
mkdir("Multiplayer_185.38.151.238/the_end");

if (exists $waypoints{'overworld'}) {
open(OF,">Multiplayer_185.38.151.238/overworld/mw65,1,0_1.txt") || die "error creating overworld file";
foreach $p (sort keys $waypoints{'overworld'}) {
   print OF "waypoint:",$p,":",substr($p,0,1),":",
            $waypoints{'overworld'}{$p}{'X'},":".
            $waypoints{'overworld'}{$p}{'Y'},":".
            $waypoints{'overworld'}{$p}{'Z'},":".
            "5:false:0:gui.xaero_default:false:0\n";
   }
close(OF);
}

if (exists $waypoints{'the_nether'}) {
open(OF,">Multiplayer_185.38.151.238/the_nether/mw65,1,0_1.txt") || die "error creating nether file";
foreach $p (sort keys $waypoints{'the_nether'}) {
   print OF "waypoint:",$p,":",substr($p,0,1),":",
            $waypoints{'the_nether'}{$p}{'X'},":".
            $waypoints{'the_nether'}{$p}{'Y'},":".
            $waypoints{'the_nether'}{$p}{'Z'},":".
            "5:false:0:gui.xaero_default:false:0\n";
   }
close(OF);
}

if (exists $waypoints{'the_end'}) {
open(OF,">Multiplayer_185.38.151.238/the_end/mw65,1,0_1.txt") || die "error creating end file";
foreach $p (sort keys $waypoints{'the_end'}) {
   print OF "waypoint:",$p,":",substr($p,0,1),":",
            $waypoints{'the_end'}{$p}{'X'},":".
            $waypoints{'the_end'}{$p}{'Y'},":".
            $waypoints{'the_end'}{$p}{'Z'},":".
            "5:false:0:gui.xaero_default:false:0\n";
   }
close(OF);
}
