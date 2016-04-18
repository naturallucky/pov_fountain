//fountain
#version 3.7;

#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
#include "skies.inc"

global_settings {
  assumed_gamma 2.2
}

camera {
	location <-30, 50, -110>
	look_at <0, 20, 0>
	angle 80
}

light_source { <100, 100, -100> color rgb 1.6 }

// 空と霞
sky_sphere {
    S_Cloud5
}

	 
plane {
	-y, 1
	texture {
		pigment { color rgb <.9,.8,.9> }
	}
}

/*box{<-200,0,-200><200,0.1,200>
	         texture { T_Grnt9
                   //normal { agate 0.15 scale 0.15}
                   finish { phong 0.2 } 
                   scale 5
                 } // end of texture 
}
*/

/*
	 // scale your object first!!!
	 texture{ pigment{ brick color White                // color mortar
	                         color rgb<0.4,0,0>    // color brick
	                   brick_size <.8, 0.19, 0.4> // format in x ,y and z- direction 
	                   mortar 0.01                      // size of the mortar 
	                 } // end of pigment
	          normal {wrinkles 0.75 scale 0.01}
	          finish {ambient 0.15 diffuse 0.95 phong 0.2} 
	          scale 4
	          rotate<0,0,0>  translate<-0.01, 0.02,0.10>
	} // end of texture
}*/

#declare fountain =
isosurface { //-------------------------------------------------------------

  function { sin( 4 *y*2*pi ) /15
             + sqrt(x*x*4 + z*z*4) - 0.5 }
  threshold 0
  contained_by {box {<-1,0,-1>, < 1, 1, 1>}}
  max_gradient 10
  accuracy 0.005
  open  // optional

  texture {
            pigment{ color rgb<1,1,1>}
            finish { phong 0.51 reflection 0.2}
	  }
  scale 20
  rotate <0, 0, 0>
  translate < 0, 0, 0>
} // end of isosurface ----------------------------------------------------- 
;

#declare fountainX = array[3]{0,50,-50};
#declare fountainY = array[3]{0,0,0};
#declare fountainZ = array[3]{0,50,50};

object{ fountain translate <fountainX[0],fountainY[0],fountainZ[0]> pigment {color <.6, .6, 1>}}
object{ fountain translate <fountainX[1],fountainY[1],fountainZ[1]> pigment {color <.6, 1, .6>}}
object{ fountain translate <fountainX[2],fountainY[2],fountainZ[2]> pigment {color <1, .6, .6>}}

//box {<-50,19,0><50,20,.1> pigment{color Red}}
//box {<-50,19,50><50,20,50.1> pigment{color Red}}

sphere  {<fountainX[0],fountainY[0],fountainZ[0]> 12 pigment {color <.6, .6, 1>}}
sphere  {<50,0,50> 12 pigment {color <.6, 1, .6>}}
sphere  {<-50,0,50> 12 pigment {color <1, .6, .6>}}



	
#declare sn = 27;
#declare maxTick = sn*10;//max frame (or +KFF)

#declare senario = array[sn+1] 
    // 2 3 4 5 6 7 8 9 A 1 2 3 4 5 6 7 8 9 A
	{1,1,1,1,1,1,1,0,0,2,2,2,2,2,2,2,0,0,4,4,
	 4,4,4,4,4,0,0/*,6,6,7,7,0,0,0,2,2,0,7,0,0,
	 0,0,0,2,4,2,4,2,4,1,2,4,1,0,0,4,2,4,2,4,
	 2,1,4,2,1,0,0,0,1,6,1,6,0,0,3,5,3,5,7,7
	 0,0,0,7,7,0,0,7,7,0,0,0,0,0,0,0,0,0,0,0*/,0};
#declare senarioC = array[sn+1] 
	{
	 0,0,1,1,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,
	 1,1,1,0,0,0,0/*,0,0,0,0,0,0,0,0,0,0,0,0,0,
	 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
	 0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0*/,0};
#declare senarioS = array[3][sn+1] 
	{{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	 0,0,0,0,0,0,0/*,0,0,0,0,0,0,0,0,0,0,0,0,0,
	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	 0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0*/,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	 0,0,0,0,0,0,0/*,0,0,0,0,0,0,0,0,0,0,0,0,0,
	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	 0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0*/,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	 0,0,0,0,0,0,0/*,0,0,0,0,0,0,0,0,0,0,0,0,0,
	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	 0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0*/,0}};


	 
#declare fountainC = array[3] [2];
#declare fountainC[0][0] = 0;
#declare fountainC[0][1] = 1;
#declare fountainC[1][0] = 0;
#declare fountainC[1][1] = 2;
#declare fountainC[2][0] = 0;
#declare fountainC[2][1] = 3;
#declare colR = array[4]{
	color rgb <.95,.93,.96>,
	color rgb <.6,.6,1>,
	color rgb <.6,1,.6>,
	color rgb <1,.6,.6>}


#declare BN = 400;
#declare pos = array [BN][3];
#declare vel = array [BN][3];
#declare col = array [BN];
#declare typ = array [BN];

#declare SD = seed(12889);
	
#for (i,0,BN-1)
	#declare typ[i] = 0;
#end

#macro apear(num,X,Y,Z,c,sv) 
	#for (i,0,BN-1)
		#if (typ[i] = 0)
			#declare pos[i][0] = X;
			#declare pos[i][2] = Z;
		
			#declare pos[i][1] = Y+20;
		
			#declare vel[i][0] = (rand(SD)-.5)*.2*8;
			#declare vel[i][2] = (rand(SD)-.5)*.2*8;
			#declare vel[i][1] = rand(SD)*2+10+sv;
			
			#declare col[i] = c;//color rgb<rand(SD),rand(SD),rand(SD)>;
			#declare typ[i] = 1;
			
			//#debug concat ("appear   c:" str(c,5,0))
			
			#declare num = num -1;
			#if (num <= 0)
				#break;
			#end
		#end
	#end
	
	#if (num > 0)
		#warning concat("warn: over max particle(" , str(num,4,0), ")")
	#end
#end

#macro apearFid(fi,si)
	apear(int(rand(SD)*4+1)*3,
	fountainX[fi],fountainY[fi],fountainZ[fi],
	fountainC[fi][senarioC[si]],senarioS[fi][si])
#end

#declare tn = int(clock * maxTick);
#declare gravi = 1.2;

#for (tm,0,tn-1)
	#declare si = int(tm/maxTick*sn);
	#declare id = senario[si];
	#if (id > 0)
		#if (mod(id,2) = 1)
			apearFid(0,si)
		#end
		#if (mod(id,4) >= 2)
			apearFid(1,si)
		#end
		#if (id >= 4)
			apearFid(2,si)
		#end
	#end

	#for (i,0,BN-1)
		#if (typ[i] > 0)
			#declare vel[i][1] =vel[i][1]-gravi;
	
			#declare pos[i][0] =pos[i][0]+vel[i][0];
			#declare pos[i][1] =pos[i][1]+vel[i][1];
			#declare pos[i][2] =pos[i][2]+vel[i][2];
		
			#if (pos[i][1]-1 <= 0 )
				#declare typ[i] = 0;
				/*
				#declare tv = ((pos[i][1]-1) / vel[i][1])*gravi;
				#declare vel[i][1] = vel[i][1] +tv;
				#declare pos[i][1] = pos[i][1] +tv;
				#declare pos[i][1] = abs(pos[i][1]-1)+1;
				#declare vel[i][1] = abs(vel[i][1])*.92;
				
				#declare vel[i][1] =vel[i][1]-tv;
				#declare pos[i][1] =pos[i][1]-tv;
				*/
			#end
		#end
	#end
#end



#macro setBlob(c) 
	#declare num = 0;
	#for (i,0,BN-1)
		#if (typ[i] >0)
			#if (col[i]  = c)
				#declare num = num +1;
				#if (num = 1)
					blob{
						threshold 4
				#end
						sphere{<0,0,0> 2.2 8
							scale<.8,2,.3>
							translate<pos[i][0],pos[i][1],pos[i][2]> 
						}
			#end
		#end
	#end
	#if (num > 0)
						pigment{ color Clear}
						finish { F_Glass1 }
						interior {I_Glass1 
							fade_color colR[c]
							caustics 0.88}
					}
		//#debug concat ("paintr num:" str(num,4,0)  "\n")
	#end
#end


setBlob(0)
setBlob(1)
setBlob(2)
setBlob(3)
