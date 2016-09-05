//viti da comprare http://www.gandini.it/www/vitidadi/index.cfm?fuseaction=frm&ctg=12&languageid=IT&idarticolo=VgqI%2BdBsAMT8SlY%3D&uid=4265
//midi connector http://www.tme.eu/en/details/650-0500/din-connectors/deltron/ 
//Midi datasheet http://www.tme.eu/en/Document/c24d4f95a51f52ffcffa8c310e451145/650.pdf
//jack connector http://www.tme.eu/en/details/klbm-3/jack-connectors/lumberg/klbm-3/
//jack datasheet http://www.tme.eu/en/Document/241958aabe0df011f74a316a9e79eb51/KLBM-3.pdf
use <./ArduinoNanoXY/ArduinoNanoXY.scad>;
use <./millefori.scad>;
Xbox=160;
Ybox=55;
Zbox=30;
spessore=3;

Njack=5;
Djack=9+.75; //inserisci diametro Jack
Dmidi=16;  //inserisci diametro Midi

mill=2.54;
$fn=50;

Hdistanziale=3; //altezza
Ldistanziale=10;
spessoreMillefori=2;
Dvite=4.4;
TestaVite=8;
DadoVite=8.5;
tolleranza=1;

Pvite=[ [0,0,0],];
DistanzialeInf=[ 
	[0,0,spessore],
	[Xbox-Ldistanziale,0,spessore],
	[0,Ybox-Ldistanziale,spessore],
	[Xbox-Ldistanziale,Ybox-Ldistanziale,spessore] ];
DistanzialeSup=[ 
	[tolleranza,tolleranza,spessore],
	[Xbox-Ldistanziale,tolleranza,spessore],
	[tolleranza,Ybox-Ldistanziale,spessore],
	[Xbox-Ldistanziale,Ybox-Ldistanziale,spessore] ];

//top
translate ([0,Ybox+10,0]){
	difference() {
	union(){
		minkowski(){
		 cube([Xbox,Ybox,spessore]);
		 cylinder(r=spessore,h=.1);
		}
		translate ([tolleranza,tolleranza,spessore]) cube([Xbox-2*tolleranza,Ybox-2*tolleranza,spessore/2]);
//distanziale superiore
	for (p=DistanzialeSup) translate(p) cube([Ldistanziale-tolleranza,Ldistanziale-tolleranza,Zbox-Hdistanziale-spessoreMillefori]);
	}
	for (p=DistanzialeInf) translate(p) translate([Ldistanziale,Ldistanziale,-spessore*2-.1]/2) cylinder(h=Zbox,d=Dvite);
	//testa vite
	for (p=DistanzialeInf) translate(p) translate([Ldistanziale,Ldistanziale,-spessore*2-.1]/2) cylinder(h=2.4,d1=TestaVite, d2=4.7);
	}
}
//bottom
difference() {
union() {
	//box
	difference(){
		minkowski(){
		 cube([Xbox,Ybox,Zbox]);
		 cylinder(r=spessore,h=1);
		}
		translate ([0,0,spessore]) cube([Xbox,Ybox,Zbox]);
	}
	//distanziale inferiore
//	color([0.1,0.1,0.1,0.1,])
	for (I=DistanzialeInf) translate(I) difference() {
		cube([Ldistanziale,Ldistanziale,Hdistanziale]);
		translate([Ldistanziale,Ldistanziale,-spessore]/2) cylinder(h=Zbox,d=Dvite);
	}
}
e=Ldistanziale+((Xbox-Ldistanziale*2)/Njack*1-(Xbox-Ldistanziale*2)/Njack/2);
echo(e);
//jack
for(j=[1:1:Njack]) translate([Ldistanziale+((Xbox-Ldistanziale*2)/Njack*j-(Xbox-Ldistanziale*2)/Njack/2),5+Ybox+3-33.5,(Zbox+spessore)/2]) rotate([-90,0,0]) cylinder (h=33.5, d=Djack);
//midi	
translate([60,-1.6-spessore,(Zbox+spessore)/2]) rotate([-90,0,0]) cylinder (h=20.5, d=Dmidi);
//dado inglobato
for (p=DistanzialeInf) translate(p) translate([Ldistanziale,Ldistanziale,-spessore*2]/2) cylinder(h=3.6,d=DadoVite,$fn=6);
//arduino usb foro
translate ([-1.5,20,17.5]) cube([4,15,9], center=true);
}
//decommentare qui sotto per vedere i componenti
/*
//jack
for(j=[1:1:Njack]) translate([Ldistanziale+((Xbox-Ldistanziale*2)/Njack*j-(Xbox-Ldistanziale*2)/Njack/2),5+Ybox+3-33.5,(Zbox+spessore)/2]) rotate([-90,0,0]) cylinder (h=33.5, d=6.4);
//midi	
translate([60,-2-spessore,(Zbox+spessore)/2]) rotate([-90,0,0]) cylinder (h=10, d=Dmidi-1);
for (p=DistanzialeInf) translate(p) translate([Ldistanziale,Ldistanziale,-spessore-2.4]/2) cylinder(h=3.6,d=8.5,$fn=6);
//millefori
translate([1,1,spessore+Hdistanziale]) millefori(Xbox-2,Ybox-2);
//color([0.1,0.1,0.1,0.4,]) translate([1,1,spessore+Hdistanziale]) cube([Xbox-2,Ybox-2,1.6]);	
//arduino
rotate([0,0,-90]) translate ([-Ldistanziale-2,1,7+2.54*2]) ArduinoNano();

//https://github.com/DonaldSBosley/Neutrik_Jacks