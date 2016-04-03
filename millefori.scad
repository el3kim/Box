x=20;
y=30;
millefori(x,y);

module millefori(x,y) {
	mill=2.54;
	spessore=1.6;
	x=x/2.54;
	y=y/2.54;
difference() {
	cube ([x*mill,y*mill,spessore]);	
	for (x=[0:1:x], y=[0:1:y]) translate([x*mill-.1,y*mill-.1,-.1]) color("gold") 
	cube([1,1,spessore+.2]);
//		cylinder(h=spessore+.2,d=1,$fn=3);
	}
}
//millefori