#!/usr/bin/perl

# xaero2voxel.pl - convert xaero waypoints to voxelmap format
#
# 

# Input Xareos Folder
$xareosIn = "Multiplayer_servername";

# Output Voxel File
$voxelOut = "servername.points";




open(OF,">$voxelOut") || die "Error creating voxel waypoints ($voxelOut).";

print OF "subworlds:\n";
print OF "oldNorthWorlds:\n";
print OF "seeds:\n";


if (-f "${xareosIn}/overworld/mw65,1,0_1.txt") {
   open(IF,"<${xareosIn}/overworld/mw65,1,0_1.txt") || die "error opening overworld file";
   while (<IF>) {
      chomp();
      last if /^$/;
      @list = split(':');
      $name = $list[1];
      $x = $list[3];
      $y = $list[4];
      $z = $list[5];
      print OF "name:", $name, ",x:", $x, ",z:", $z, ",y:", $y,
                ",enabled:true,red:0.0,green:1.0,blue:0.0,suffix:star,world:,dimensions:overworld#\n";
      }
   close(IF);
}

if (-f "${xareosIn}/the_nether/mw65,1,0_1.txt") {
   open(IF,"<${xareosIn}/the_nether/mw65,1,0_1.txt") || die "error opening nether file";
   while (<IF>) {
      chomp();
      last if /^$/;
      @list = split(':');
      $name = $list[1];
      $x = $list[3];
      $y = $list[4];
      $z = $list[5];
      print OF "name:",$name,",x:",$x,",z:",$z,",y:",$y,
                ",enabled:true,red:1.0,green:0.0,blue:0.0,suffix:star,world:,dimensions:the_nether#\n";
      }
   close(IF);
}

if (-f "${xareosIn}/the_end/mw65,1,0_1.txt") {
   open(IF,"<${xareosIn}/the_end/mw65,1,0_1.txt") || die "error opening the end file";
   while (<IF>) {
      chomp();
      last if /^$/;
      @list = split(':');
      $name = $list[1];
      $x = $list[3];
      $y = $list[4];
      $z = $list[5];
      print OF "name:",$name,",x:",$x,",z:",$z,",y:",$y,
                ",enabled:true,red:0.0,green:0.0,blue:1.0,suffix:star,world:,dimensions:the_end#\n";
      }
   close(IF);
}

close(OF);

exit(0);
