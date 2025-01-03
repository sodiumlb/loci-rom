#!/usr/bin/perl
use JSON;

#my $bitfontmaker2_json = <DATA>;

my $hash_ref = decode_json(<DATA>);
printf ("; Font %s by %s\n", ${$hash_ref}{'name'},${$hash_ref}{'copy'});
for(my $i=32; $i<=95; $i++){
    printf(";<%c>\n", $i);
    my $arr_ref = ${$hash_ref}{$i};
    my @r = map(unpack('C', pack('B8',unpack('b8',pack('C',$_)))),@{$arr_ref}[5 .. 12]);
    my @p;
    $p[0] = $r[0]<<18 | $r[1]<<12 | $r[2]<<6 | $r[3];  
    $p[1] = $r[4]<<18 | $r[5]<<12 | $r[6]<<6 | $r[7];
    my @s;
    for(my $j=0; $j<=2; $j++){
        $s[$j+0] = ($p[0] >> (16-($j*8))) & 0xFF;
        $s[$j+3] = ($p[1] >> (16-($j*8))) & 0xFF;
    }  
    my @glyph = map(sprintf("\$%02X",$_), @s);
    print ".byte ";
#    foreach my $line (@glyph){
#        printf "\$%02X, ", $line>>2;
#    }
    print join(", ",@glyph);
    print "\n";
}
 
__DATA__
{"33":[0,0,0,0,0,56,40,40,124,108,108,124,0,0,0,0],"34":[0,0,0,0,0,48,32,32,124,108,108,124,0,0,0,0],"35":[0,0,0,0,0,56,124,108,124,56,12,92,0,0,0,0],"36":[0,0,0,0,0,16,80,84,52,24,16,16,0,0,0,0],"37":[0,0,0,0,0,16,56,84,84,124,124,56,0,0,0,0],"38":[0,0,0,0,0,116,92,116,4,116,92,116,0,0,0,0],"39":[0,0,0,0,0,56,108,84,108,124,108,56,0,0,0,0],"40":[0,0,0,0,0,16,56,48,48,48,16,124,0,0,0,0],"41":[0,0,0,0,0,124,116,84,84,84,116,124,0,0,0,0],"42":[0,0,0,0,0,0,144,216,252,216,144,0,0,0,0,0],"43":[0,0,0,0,0,0,36,108,252,108,36,0,0,0,0,0],"44":[0,0,0,0,0,0,16,56,124,0,124,0,0,0,0,0],"45":[0,0,0,0,0,0,56,124,124,124,56,0,0,0,0,0],"46":[0,0,0,0,0,124,84,84,124,124,124,124,0,0,0,0],"48":[0,0,0,0,0,56,68,68,0,68,68,56,0,0,0,0],"49":[0,0,0,0,0,0,64,64,0,64,64,0,0,0,0,0],"50":[0,0,0,0,0,56,64,64,56,4,4,56,0,0,0,0],"51":[0,0,0,0,0,56,64,64,56,64,64,56,0,0,0,0],"52":[0,0,0,0,0,0,68,68,56,64,64,0,0,0,0,0],"53":[0,0,0,0,0,56,4,4,56,64,64,56,0,0,0,0],"54":[0,0,0,0,0,56,4,4,56,68,68,56,0,0,0,0],"55":[0,0,0,0,0,56,64,64,0,64,64,0,0,0,0,0],"56":[0,0,0,0,0,56,68,68,56,68,68,56,0,0,0,0],"57":[0,0,0,0,0,56,68,68,56,64,64,56,0,0,0,0],"name":"LociWidgets","copy":"Sodiumlightbaby","letterspace":"64","basefont_size":"512","basefont_left":"62","basefont_top":"0","basefont":"Arial","basefont2":"","monospace":true,"monospacewidth":"6"}
