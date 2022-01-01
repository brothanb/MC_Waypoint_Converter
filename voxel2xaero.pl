#!/usr/bin/perl

# Input Voxel File
$voxelIn = "servername.points";

# Output Xareos Folder
$xareosOut = "Multiplayer_servername";

# convert voxelmap waypoints to xaero format

open(IF,"<${voxelIn}") || die "Error opening voxel waypoints (${voxelIn}).";

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
      push(@{$waypoints{$dim}}, { %point });
      }
   }
close(IF);

undef $point;

# Overworld
mkdir("${xareosOut}");
mkdir("${xareosOut}/dim%0");
if (exists $waypoints{'overworld'}) {
open(OF,">${xareosOut}/dim%0/mw65,1,0_1.txt") || die "error creating overworld file";
foreach $p ( @{$waypoints{'overworld'}}) {
   print OF "waypoint:",
            $p->{'name'},":",
            substr($p->{'name'},0,1),":",
            $p->{'x'},":".
            $p->{'y'},":".
            $p->{'z'},":".
            "6:false:0:gui.xaero_default:false:0\n";
   }
close(OF);
}

# Nether
# Voxel multiplies the X and Z by 8...  (ugh)
mkdir("${xareosOut}/dim%-1");
if (exists $waypoints{'the_nether'}) {
open(OF,">${xareosOut}/dim%-1/mw65,1,0_1.txt") || die "error creating nether file";
foreach $p ( @{$waypoints{'the_nether'}}) {
   print OF "waypoint:",
            $p->{'name'},":",
            substr($p->{'name'},0,1),":",
            int($p->{'x'}/8),":".
            $p->{'y'},":".
            int($p->{'z'}/8),":".
            "6:false:0:gui.xaero_default:false:0\n";
   }
close(OF);
}

# The End
mkdir("${xareosOut}/dim%1");
if (exists $waypoints{'the_end'}) {
open(OF,">${xareosOut}/dim%1/mw65,1,0_1.txt") || die "error creating end file";
foreach $p ( @{$waypoints{'the_end'}}) {
   print OF "waypoint:",
            $p->{'name'},":",
            substr($p->{'name'},0,1),":",
            $p->{'x'},":".
            $p->{'y'},":".
            $p->{'z'},":".
            "6:false:0:gui.xaero_default:false:0\n";
   }
close(OF);
}
